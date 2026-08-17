module Bootstrap5Helper
  class Offcanvas
    # Builds a Content component for use in offcanvas.
    #
    #
    class Content < Component
      # @param  [Hash] opts
      # @return [ClassName]
      #
      def initialize(template, opts = {}, &block)
        super(template)

        @attrs      = opts
        @id         = @attrs.delete(:id)         { uuid }
        @class      = @attrs.delete(:class)      { '' }
        @data       = @attrs.delete(:data)       { {} }
        @aria       = @attrs.delete(:aria)       { {} }
        @scrollable = @attrs.delete(:scrollable) { false }
        @position   = @attrs.delete(:position)   { 'start' }
        @backdrop   = @attrs.delete(:backdrop)   { true }
        @content    = block || proc { '' }
      end

      # @todo
      def header(opts = {}, &block)
        attrs = opts
        id    = attrs.delete(:id)    { nil }
        klass = attrs.delete(:class) { '' }
        data  = attrs.delete(:data)  { {} }

        content_tag(
          config({ offcanvas: :header }, :div),
          {
            id:    id,
            class: "offcanvas-header #{klass}",
            data:  data
          }.merge(attrs),
          &block
        )
      end

      # @todo
      def title(text_or_options = nil, opts = {}, &block)
        text, attrs = parse_text_or_options(text_or_options, opts)

        id    = attrs.delete(:id)    { nil }
        klass = attrs.delete(:class) { '' }
        data  = attrs.delete(:data)  { {} }

        content_tag(
          config({ offcanvas: :title }, :h6),
          text,
          {
            id:    id,
            class: "offcanvas-title #{klass}",
            data:  data
          }.merge(attrs),
          &block
        )
      end

      # @todo
      def close_button(opts = {})
        attrs = opts
        klass = attrs.delete(:class)  { '' }
        data  = attrs.delete(:data)   { {} }
        aria  = attrs.delete(:aria)   { {} }

        content_tag(
          config({ offcanvas: :close }, :button),
          class: block_given? ? klass : 'btn-close',
          data:  data.merge('bs-dismiss' => 'offcanvas'),
          aria:  aria.merge(label: 'Close')
        ) do
          block_given? ? yield : xbutton
        end
      end

      # @todo
      def body(opts = {}, &block)
        attrs = opts
        id    = attrs.delete(:id)    { nil }
        klass = attrs.delete(:class) { '' }
        data  = attrs.delete(:data)  { {} }
        aria  = attrs.delete(:aria)  { {} }

        content_tag(
          :div,
          {
            id:    id,
            class: "offcanvas-body #{klass}",
            data:  data,
            aria:  aria
          }.merge(attrs),
          &block
        )
      end

      # @todo
      def to_s
        content_tag(
          :div,
          {
            id:       @id,
            class:    "offcanvas offcanvas-#{@position} #{@class}",
            tabindex: -1,
            data:     @data.merge!(
              'bs-scroll'   => @scrollable,
              'bs-backdrop' => @backdrop
            ),
            aria:     @aria.merge!(labelledby: 'offcanvasExampleLabel')
          }.merge(@attrs)
        ) do
          @content.call(self)
        end
      end

      private

      # Builds the `x` button normally used in the header.
      #
      # @return [String]
      #
      def xbutton
        content_tag :span, '&times;'.html_safe, class: 'visually-hidden', aria: { hidden: true }
      end
    end
  end
end
