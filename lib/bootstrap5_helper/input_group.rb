module Bootstrap5Helper
  # The InputGroup helper is meant to help you rapidly build Bootstrap input
  # group components quickly and easily.
  #
  class InputGroup < Component
    VALID_TYPES = %i[append prepend].freeze

    # Class constructor
    #
    # @param  [Class] template - Template in which your are binding too.
    # @param  [Symbol] type - Whether the component is prepend or append.
    # @param  [Hash]  opts
    # @return [InputGroup]
    #
    def initialize(template, context_or_options = nil, opts = {}, &block)
      super(template)

      @context, args = parse_context_or_options(context_or_options, opts)

      @id      = args.fetch(:id,     nil)
      @class   = args.fetch(:class,  '')
      @data    = args.fetch(:data,   {})
      @content = block || proc { '' }
    end

    # This is the element that actually houses the icon or text used
    # in the input group.
    #
    # @param  [Hash] opts
    # @return [String]
    #
    def text(opts = {}, &block)
      opts[:class] = (opts[:class] || '') << ' input-group-text'
      content_tag :span, opts, &block
    end

    # Used to render out the InputGroup component.
    #
    # @return [String]
    #
    def to_s
      content_tag(
        :div,
        id:    @id,
        class: "input-group #{size_class} #{@class}",
        data:  @data
      ) do
        @content.call(self)
      end
    end

    private

    # Used to get the size of the input group.
    #
    # @return [String]
    #
    def size_class
      case @context
      when :sm
        'input-group-sm'
      when :lg
        'input-group-lg'
      else
        ''
      end
    end
  end
end
