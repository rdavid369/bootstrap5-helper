module Bootstrap5Helper
  # rubocop:disable Metrics/ClassLength

  # Builds a Nav Component that can be used in other components.
  class Nav < Component
    # Class constructor
    #
    # @param [ActionView]     template
    # @param [Symbol|Hash]    tag_or_options
    # @param [Hash]           opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @option opts [Hash]    :bs_attrs
    #
    def initialize(template, *tag_or_options, &block)
      super(template)

      @tag, args = parse_tag_or_options(*tag_or_options, {})
      @tag ||= config({ navs: :base }, :ul)

      @attrs    = args
      @id       = @attrs.delete(:id)       { uuid }
      @class    = @attrs.delete(:class)    { '' }
      @data     = @attrs.delete(:data)     { {} }
      @bs_attrs = @attrs.delete(:bs_attrs) { {} }
      @dropdown = Dropdown.new(@template)
      @content  = block || proc { '' }
    end

    # Adds an nav-item to the nav component. This method gets used when the nav-item
    # links to content in a tab or something.
    #
    # @param [Symbol|String] target
    # @param [Hash] opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @option opts [Hash]    :aria
    # @option opts [Hash]    :child
    # @return [String]
    #
    def item(target, opts = {}, &block)
      case @tag
      when :nav
        nav_item_without_wrapper(target, opts, &block)
      when :ul
        nav_item_with_wrapper(target, opts, &block)
      end
    end

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
    # @option opts [Hash]    :child
    # @return [String]
    #
    def dropdown(name, opts = {}, &block)
      id    = opts.fetch(:id,    nil)
      klass = opts.fetch(:class, '')
      data  = opts.fetch(:data,  {}).merge('bs-toggle' => 'dropdown')
      aria  = opts.fetch(:aria,  {}).merge(haspopup: true, expanded: false)

      nav_item_wrapper(
        id:    id,
        class: 'dropdown',
        data:  (@bs_attrs[:data] || {}).merge(
          'bs-toggle'  => 'dropdown',
          'bs-display' => 'static'
        )
      ) do
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
      content_tag(
        @tag,
        {
          id:    @id,
          class: "nav #{@class}",
          data:  @data
        }.merge(@attrs)
      ) do
        @content.call(self)
      end
    end

    private

    # rubocop:disable Metrics/AbcSize

    # @note This is one of the few places where things deviate
    #   a little from the pattern of child elements requiring
    #   the :child option class needing to be set in order to
    #   pass on the class. The reason being that the default DOM
    #   elements built for navs are UL, which means that the
    #   majority of them will have children elements. Just wanted
    #   an easy process of setting the active nav, without having
    #   to remember if you are using :nav or :ul components.
    #
    # @example Nav built with UL(default config) would require the
    #   the following for setting the active nav:
    #
    #   ```ruby
    #     <%= nav_helper do |nav| %>
    #       <%= nav.item(child: { class: 'active' }) do
    #       <% end %>
    #     <% end %>
    #
    # @example With the deviation:
    #
    #     <%= nav_helper do |nav| %>
    #       <%= nav.item(class: 'active') do
    #       <% end %>
    #     <% end %>
    #   ```
    #
    # @param [Symbol|String] target
    # @param [Hash] opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @option opts [Hash]    :aria
    # @option opts [Hash]    :child
    # @return [String]
    #
    def nav_item_with_wrapper(target, opts = {}, &block)
      attrs = opts
      child = attrs.delete(:child) { {} }.merge(@bs_attrs)
      child[:class] = (child[:class] || '') << ' nav-link'

      if attrs.fetch(:class, '').match?('active')
        attrs[:class].gsub!('active', '')
        child[:class] << ' active'
      end

      nav_item_wrapper(attrs) do
        content_tag(
          :a,
          { href: "##{target}", tabindex: -1 }.merge(child)
        ) do
          block_given? ? block.call : target.to_s.titleize
        end
      end
    end
    # rubocop:enable Metrics/AbcSize

    # @param [Symbol|String] target
    # @param [Hash] opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @option opts [Hash]    :aria
    # @return [String]
    #
    def nav_item_without_wrapper(target, opts = {}, &block)
      attrs = opts.merge(@bs_attrs)
      attrs[:class] = (attrs[:class] || '') << ' nav-link'

      nav_item_wrapper do
        content_tag(
          :a,
          { href: "##{target}", tabindex: -1 }.merge(attrs)
        ) do
          block_given? ? block.call : target.to_s.titleize
        end
      end
    end

    # Decorator for elements requiring a wrapper component.
    #
    # @return [String]
    #
    def nav_item_wrapper(opts = {}, &block)
      opts[:class] = (opts[:class] || '') << ' nav-item'

      case @tag
      when :nav
        block.call
      when :ul
        content_tag(:li, opts, &block)
      end
    end
  end
  # rubocop:enable Metrics/ClassLength
end
