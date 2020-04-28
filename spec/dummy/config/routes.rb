Rails.application.routes.draw do

  mount EvClient::Engine => "/ev_client"
end
