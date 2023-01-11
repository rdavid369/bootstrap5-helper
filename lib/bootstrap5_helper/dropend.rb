module Bootstrap5Helper
  # Builds a Dropdown component that can be used in other components.
  #
  #
  class Dropend < Overlay
    # Class constructor
    #
    # @overload initialize(template, tag, opts)
    #   @param [ActionView]    template
    #   @param [Symbol|String] tag - The HTML element to use to wrap the component.
    #   @param [Hash]          opts
    #   @option opts [String]  :id
    #   @option opts [String]  :class
    #   @option opts [Hash]    :data
    #   @option opts [Boolea]  :split
    #   @option opts [Boolean] :centered
    #
    # @overload initialize(template, opts)
    #   @param [ActionView]    template
    #   @param [Hash]          opts
    #   @option opts [String]  :id
    #   @option opts [String]  :class
    #   @option opts [Hash]    :data
    #   @option opts [Boolea]  :split
    #   @option opts [Boolean] :centered
    #
    # @return [Dropend]
    #
    def initialize(template, *tag_or_options, &block)
      super(template, *tag_or_options, &block)
      @type = :dropend
    end
  end
end
