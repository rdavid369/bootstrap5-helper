module Bootstrap5Helper
  # Simple Railtie to hook out module into ActionView.
  #
  #
  class Railtie < ::Rails::Railtie
    config.after_initialize do
      ActiveSupport.on_load(:action_view) do
        include Bootstrap5Helper if Bootstrap5Helper.config.autoload_in_views?
      end
    end
  end
end
