Rails.application.routes.draw do

  mount EvClient::Engine => "/pub_client"
end
