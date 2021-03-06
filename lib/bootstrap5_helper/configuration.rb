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
      badges:            :span,
      cards:             {
        header: :h5,
        body:   :div,
        footer: :div,
        title:  :h5,
        text:   :p
      },
      dropdowns:         {},
      dropdown_menus:    {
        text:    :span,
        header:  :h6,
        divider: :div
      },
      navs:              {
        base: :ul
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
