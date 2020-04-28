module EvClient
  class Engine < ::Rails::Engine

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
    
    initializer "ev_client.integration" do
      ActiveSupport.on_load :action_controller do
        helper EvClientHelper
      end
    end

  end
end
