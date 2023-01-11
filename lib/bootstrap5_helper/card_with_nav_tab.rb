module Bootstrap5Helper
  class CardWithNavTab < Component # :nodoc:
    # Class constructor
    #
    # @param [ActionView] template
    # @param [Symbol|String|Hash] type_or_options
    # @param [Hash] opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    #
    def initialize(template, *context_or_options, &block)
      super(template)
      @context, args = parse_context_or_options(*context_or_options, {})
      @id      = args.fetch(:id,    '')
      @class   = args.fetch(:class, '')
      @data    = args.fetch(:data,  nil)
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
      tag, args      = parse_tag_or_options(*tag_or_options, {})
      args[:class]   = (args[:class] || '') << 'nav-tabs card-header-tabs'
      args[:data]    = (args[:data]  || {}).merge('bs-toggle' => 'tab')
      args[:child]   = { data: { 'bs-toggle' => 'tab' } }
      args[:overlay] = { menu: [:ul, {}] }

      content_tag :div, class: 'card-header' do
        Nav.new(@template, tag, args, &block).to_s
      end
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
      content_tag :div, class: 'card-body' do
        Tab::Content.new(@template, opts, &block).to_s
      end
    end

    # @todo
    #
    #
    def to_s
      content_tag :div, class: "card with-nav-tabs-#{@context}" do
        @content.call(self)
      end
    end
  end
end
