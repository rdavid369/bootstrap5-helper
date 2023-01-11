module Bootstrap5Helper
  class Overlay
    # Builds a menu component for use in dropdowns.
    #
    #
    class Menu < Component
      # Class constructor
      #
      # @param [ActionView]     template
      # @param [Symbol|Hash]    tag_or_options
      # @param [Hash]           opts
      # @option opts [String]  :id
      # @option opts [String]  :class
      # @option opts [Hash]    :data
      #
      def initialize(template, *tag_or_options, &block)
        super(template)

        @tag, opts = parse_tag_or_options(*tag_or_options, {})
        @id        = opts.fetch(:id,    uuid)
        @class     = opts.fetch(:class, '')
        @data      = opts.fetch(:data,  {})
        @content   = block || proc { '' }
      end

      # Use this method when the menu `item` is nothing more than a
      # hyperlink.
      #
      # @param  [String] name
      # @param  [Hash]   options
      # @param  [Hash]   html_options
      # @return [String]
      #
      def link(name = nil, options = nil, html_options = nil, &block)
        html_options ||= {}
        html_options[:class] = (html_options[:class] || '') << ' dropdown-item'

        nav_item_wrapper do
          @template.link_to(name, options, html_options, &block)
        end
      end

      # rubocop:disable Metrics/MethodLength

      # Use this method when you are using the item in the menu as trigger for
      # something like tab content.
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
        data  = opts.fetch(:data,  {}).merge('bs-toggle' => 'tab')
        aria  = opts.fetch(:aria,  {})

        nav_item_wrapper do
          content_tag(
            :a,
            id:    id,
            class: "dropdown-item #{klass}",
            href:  "##{target}",
            aria:  aria,
            data:  data
          ) do
            block_given? ? yield : target.to_s.titleize
          end
        end
      end
      # rubocop:enable Metrics/MethodLength

      # Builds a Text component
      #
      # @param  [Symbol|String] text
      # @param  [Hash] opts
      # @option opts [String]  :id
      # @option opts [String]  :class
      # @option opts [Hash]    :data
      # @return [String]
      #
      def text(text, opts = {}, &block)
        nav_item_wrapper do
          build_sub_component(
            config({ overlay_menus: :text }, :span),
            text,
            'item-text',
            opts,
            &block
          )
        end
      end

      # Builds a Header component
      #
      # @param  [Symbol|String] text
      # @param  [Hash] opts
      # @option opts [String]  :id
      # @option opts [String]  :class
      # @option opts [Hash]    :data
      # @return [String]
      #
      def header(text, opts = {}, &block)
        nav_item_wrapper do
          build_sub_component(
            config({ overlay_menus: :header }, :h6),
            text,
            'header',
            opts,
            &block
          )
        end
      end

      # Builds a divider element
      #
      # @return [String]
      #
      def divider
        nav_item_wrapper do
          content_tag(
            config({ overlay_menus: :divider }, :div),
            '',
            class: 'dropdown-divider'
          )
        end
      end

      # String representation of the object.
      #
      # @return [String]
      #
      def to_s
        content_tag(
          @tag || config({ overlay_menus: :base }, :div),
          id:    @id,
          class: "dropdown-menu #{@class}",
          data:  @data
        ) do
          @content.call(self)
        end
      end

      private

      # Decorator for elements requiring a wrapper component.
      #
      # @return [String]
      #
      def nav_item_wrapper(&block)
        case @tag
        when :div, nil
          block.call
        when :ul
          content_tag(:li, &block)
        end
      end

      # Used to build specific components.
      #
      # @param [Symbol] tag
      # @param [Symbol|String] text
      # @param [Symbol|String] type
      # @param [Hash] opts
      # @option opts [String]  :id
      # @option opts [String]  :class
      # @option opts [Hash]    :data
      # @return [String]
      #
      def build_sub_component(tag, text, type, opts)
        id    = opts.fetch(:id,    nil)
        klass = opts.fetch(:class, '')
        data  = opts.fetch(:data,  {})

        content_tag(
          tag,
          id:    id,
          class: "dropdown-#{type} #{klass}",
          data:  data
        ) do
          block_given? ? yield : text || ''
        end
      end
    end
  end
end
