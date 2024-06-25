module Bootstrap5Helper
  # Builds a Nav Component that can be used in other components.
  #
  #
  class Nav < Component
    # Class constructor
    #
    # @param [ActionView]     template
    # @param [Symbol|Hash]    tag_or_options
    # @param [Hash]           opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @option opts [Array]   :dropdown
    # @option opts []
    #
    def initialize(template, *tag_or_options, &block)
      super(template)

      @tag, args = parse_tag_or_options(*tag_or_options, {})
      @tag ||= config({ navs: :base }, :ul)

      @id       = args.fetch(:id,    uuid)
      @class    = args.fetch(:class, '')
      @data     = args.fetch(:data,  {})
      @child    = args.fetch(:child, {})
      @content  = block || proc { '' }
      @dropdown = Dropdown.new(@template)
    end

    # rubocop:disable Metrics/MethodLength

    # Adds an nav-item to the nav component. this method gets used when the nav-item
    # links to content in a tab or something.
    #
    # @param [Symbol|String] target
    # @param [Hash] opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @option opts [Hash]    :aria
    # @return [String]
    #
    def item(target, opts = {})
      id    = opts.fetch(:id,    nil)
      klass = opts.fetch(:class, '')
      data  = opts.fetch(:data,  {})
      aria  = opts.fetch(:aria,  {})

      nav_item_wrapper id: id, data: data do
        content_tag(
          :a,
          class:    "nav-link #{klass}",
          href:     "##{target}",
          tabindex: -1,
          data:     @child[:data],
          aria:     aria
        ) do
          block_given? ? yield : target.to_s.titleize
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    # Use this when the nav item is nothing more than a hyperlink.
    #
    # @param [String|NilClass] name
    # @param [Hash|NilClass]   options
    # @param [Hash|NilClass]   html_options
    # @return [String]
    #
    def link(name = nil, options = nil, html_options = nil, &block)
      html_options ||= {}
      html_options[:class] = (html_options[:class] || '') << ' nav-link'

      nav_item_wrapper do
        @template.link_to(name, options, html_options, &block)
      end
    end

    # rubocop:disable Metrics/MethodLength

    # Creates a dropdown menu for the nav.
    #
    # @param [NilClass|Symbol|String] name
    # @param [Hash] opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @option opts [Hash]    :aria
    # @return [String]
    #
    def dropdown(name, opts = {}, &block)
      id    = opts.fetch(:id,    nil)
      klass = opts.fetch(:class, '')
      data  = opts.fetch(:data,  {}).merge('bs-toggle' => 'dropdown')
      aria  = opts.fetch(:aria,  {}).merge(haspopup: true, expanded: false)

      data.merge!('bs-display' => 'static') if @child[:data]&.key?('bs-display')

      nav_item_wrapper id: id, class: 'dropdown', data: data do
        content_tag(
          :a,
          name,
          class: "nav-link dropdown-toggle #{klass}",
          href:  '#',
          data:  data,
          role:  'button',
          aria:  aria
        ) + @dropdown.menu(opts, &block).to_s.html_safe
      end
    end
    # rubocop:enable Metrics/MethodLength

    # String representation of the object.
    #
    # @return [String]
    #
    def to_s
      content_tag(@tag, id: @id, class: "nav #{@class}", data: @data) do
        @content.call(self)
      end
    end

    private

    # Decorator for elements requiring a wrapper component.
    #
    # @return [String]
    #
    def nav_item_wrapper(opts = {}, &block)
      id    = opts.fetch(:id,    '')
      klass = opts.fetch(:class, '')
      data  = opts.fetch(:data,  {})

      case @tag
      when :nav
        block.call
      when :ul
        content_tag(
          :li,
          id:    id,
          class: "nav-item #{klass}",
          data:  data,
          &block
        )
      end
    end
  end
end
