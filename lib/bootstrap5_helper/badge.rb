module Bootstrap5Helper
  # Creates Bootstrap badge components that can be used anywhere.
  #
  #
  class Badge < Component
    # Class constructor
    #
    # @param [ActionView] template
    # @param [NilClass|String|Symbol|Hash] context_or_options
    # @param [Hash] opts
    #
    def initialize(template, context_or_options = nil, opts = {}, &block)
      super(template)
      @context, args = parse_context_or_options(context_or_options, opts)

      @id      = args.fetch(:id,    nil)
      @class   = args.fetch(:class, '')
      @content = block || proc { '' }
    end

    # String representation of the object.
    #
    #
    def to_s
      content_tag(
        config(:badges, :span),
        id:    @id,
        class: container_class
      ) do
        @content.call(self)
      end
    end

    private

    # Used to get the container classes.
    #
    # @return [String]
    #
    def container_class
      string = 'badge '
      string += @context == 'secondary' ? 'bg-secondary' : "bg-#{@context}"
      string += " #{@class}"
      string
    end
  end
end
