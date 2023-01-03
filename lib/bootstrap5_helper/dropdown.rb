module Bootstrap5Helper
  # Builds a Dropdown component that can be used in other components.
  #
  #
  class Dropdown < Overlay
    # Class constructor
    #
    # @param [ActionView]    template
    # @param [Symbol|String] type
    # @param [Hash]          opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @option opts [Boolea]  :split
    # @option opts [Boolean] :centered
    #
    def initialize(template, *tag_or_options, &block)
      super(template, &block)

      @tag, @args = parse_tag_or_options(*tag_or_options, {})
      @type       = :dropdown
    end
  end
end
