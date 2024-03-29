module Bootstrap5Helper
  # Simple configuration object for setting options for the gem.
  #
  # @todo Build a better, more comprehensive system.
  #
  class Configuration
    DEFAULT_SETTINGS = {
      autoload_in_views: true,
      accordions:        {
        header: :h2,
        body:   :div
      },
      badges:            {
        contrast: false,
        base:     :span
      },
      callouts:          {
        header: :h4
      },
      cards:             {
        header:   :h5,
        body:     :div,
        footer:   :div,
        title:    :h5,
        subtitle: :h6,
        text:     :p
      },
      dropdowns:         {},
      overlay_menus:     {
        base:    :div,
        text:    :span,
        header:  :h6,
        divider: :div
      },
      modals:            {
        title: :h5
      },
      navs:              {
        base: :ul
      },
      offcanvas:         {
        header:  :div,
        title:   :h5,
        close:   :button,
        body:    :div,
        trigger: :div
      },
      page_header:       :h1
    }.freeze

    attr_accessor(*DEFAULT_SETTINGS.keys)

    # Class constructor
    #
    # @param  [Hash] _args
    # @return [ClassName]
    #
    def initialize(_args = {})
      DEFAULT_SETTINGS.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    # Simple predicate method
    #
    # @return [Boolean]
    #
    def autoload_in_views?
      @autoload_in_views
    end
  end
end
