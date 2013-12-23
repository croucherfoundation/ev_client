class UsersController < ApplicationController
  respond_to :html, :json
  before_filter :get_users, only: [:index]
  before_filter :get_user, only: [:show, :edit, :update, :confirm, :welcome]
  layout :no_layout_if_pjax

  # User-creation is always nested. 
  # Our usual purpose here is to list suggestions for the administrator choosing interviewers or screening judges
  #
  def index
    respond_with @users.to_a
  end
  
  # But people can change basic settings
  #
  def edit
    respond_with @user
  end
  
  def update
    authorize! :update, @user
    @user.assign_attributes(user_params)
    @user.save
    respond_with @user
  end
  
  # ...or confirm their account.
  
  def welcome
    @user = User.from_credentials(params[:id], params[:tok])
    if @user
      sign_in_and_remember @user
      if @user.confirmed?
        redirect_to after_sign_in_path_for(@user)
      else
        respond_with @user
      end
    else
      raise ActiveRecord::RecordNotFound, "Sorry: User credentials not recognised."
    end
  end

  def confirm
    authorize! :update, @user
    @user.assign_attributes(user_params)
    @user.assign_attributes(confirmed: true)
    @user.save
    respond_with @user, location: params[:destination].present? ? params[:destination] : after_sign_in_path_for(@user)
  end

protected

  def get_user
    if params[:id].present? && can?(:manage, User)
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def get_users
    @users = User.all
    @show = params[:show] || 10
    @page = params[:page] || 1
    unless @show == 'all'
      @users = @users.page(@page).per(@show) 
    end
    @users
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :confirmed)
  end

end

