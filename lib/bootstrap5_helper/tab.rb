module Bootstrap5Helper
  # Builds a Tab component.
  #
  #
  class Tab < Component
    # Class constructor
    #
    # @param [ActionView] template
    # @param [Symbol|String|Hash] type_or_options
    # @param [Hash] opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    #
    def initialize(template, type_or_options = nil, opts = {}, &block)
      super(template)
      @type, args = type_or_options(type_or_options, opts)

      @id      = args.fetch(:id,    uuid)
      @class   = args.fetch(:class, '')
      @data    = args.fetch(:data,  {})
      @content = block || proc { '' }
    end

    # Builds a custom Nav component for the tabs.
    #
    # @overload nav(tag, opts)
    #   @param [Symbol|String] tag - :nav, :ul
    #   @param [Hash] opts
    #   @option opts [String]  :id
    #   @option opts [String]  :class
    #   @option opts [Hash]    :data
    #   @option opts [Hash]    :child - data attributes for child, NOT wrapper
    #
    # @overload nav(opts)
    #   @param [Hash] opts
    #   @option opts [String]  :id
    #   @option opts [String]  :class
    #   @option opts [Hash]    :data
    #   @option opts [Hash]    :child - data attributes for child, NOT wrapper
    #
    # @yield  [Nav]
    # @return [Nav]
    #
    def nav(*tag_or_options, &block)
      tag, args = parse_tag_or_options(*tag_or_options, {})

      args[:class] = (args[:class] || '') << " nav-#{@type}"
      args[:data]  = (args[:data]  || {}).merge('bs-toggle' => 'tab')
      args[:child] = { data: { 'bs-toggle' => 'tab' } }

      Nav.new(@template, tag, args, &block)
    end

    # Builds the Content object for the Tab.
    #
    # @param  [Hash] opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @return [Tab::Content]
    #
    def content(opts = {}, &block)
      Content.new(@template, opts, &block)
    end

    # @note This has a weird interaction.  Because this object doesn't actually return any wrapping
    #   string or DOM element, we want to return nil, so that only the output buffer on the sub components are
    #   returned.
    #
    # @note Was updated to return an empty string opposed to nil.
    # @see changelog.md
    #
    def to_s
      @content.call(self)

      ''
    end

    def type_or_options(*args)
      parse_arguments(*args, :tabs)
    end
  end
end
