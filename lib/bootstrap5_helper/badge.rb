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
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash] : :data
    #
    def initialize(template, context_or_options = nil, opts = {}, &block)
      super(template)
      @context, args = parse_context_or_options(context_or_options, opts)

      @id      = args.fetch(:id,    nil)
      @class   = args.fetch(:class, '')
      @data    = args.fetch(:data,  {})
      @content = block || proc { '' }
    end

    # String representation of the object.
    #
    # @return [String]
    #
    def to_s
      content_tag(
        config({ badges: :base }, :span),
        id:    @id,
        class: container_class,
        data:  @data
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
      "badge #{component_class} #{@class}"
    end

    def component_class
      contrast = config({ badges: :contrast }, false)

      if @context == 'secondary'
        contrast ? 'text-bg-secondary' : 'bg-secondary'
      else
        contrast ? "text-bg-#{@context}" : "bg-#{@context}"
      end
    end
  end
end
