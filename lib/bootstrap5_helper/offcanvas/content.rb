module Bootstrap5Helper
  class Offcanvas
    # Builds a Content component for use in offcanvas.
    #
    #
    class Content < Component
      # Constructor description...
      #
      #
      # @param  [Hash] opts
      # @return [ClassName]
      #
      def initialize(template, opts = {}, &block)
        super(template)

        @id         = opts.fetch(:id,         uuid)
        @class      = opts.fetch(:class,      '')
        @data       = opts.fetch(:data,       {})
        @aria       = opts.fetch(:aria,       {})
        @scrollable = opts.fetch(:scrollable, false)
        @position   = opts.fetch(:position,   'start')
        @content    = block || proc { '' }
      end

      # @todo
      #
      #
      def header(opts = {}, &block)
        id    = opts.fetch(:id,    nil)
        klass = opts.fetch(:class, '')
        data  = opts.fetch(:data,  {})

        content_tag(
          config({ offcanvas: :header }, :div),
          id:    id,
          class: "offcanvas-header #{klass}",
          data:  data,
          &block
        )
      end

      # @todo
      #
      #
      def title(text_or_options = nil, opts = {}, &block)
        text, args = parse_text_or_options(text_or_options, opts)

        id    = args.fetch(:id,    nil)
        klass = args.fetch(:class, '')
        data  = args.fetch(:data,  {})

        content_tag(
          config({ offcanvas: :title }, :h6),
          text,
          id:    id,
          class: "offcanvas-title #{klass}",
          data:  data,
          &block
        )
      end

      # @todo
      #
      #
      def close_button(opts = {})
        klass = opts.fetch(:class, '')

        content_tag(
          config({ offcanvas: :close }, :button),
          class: block_given? ? klass : 'btn-close',
          data:  { 'bs-dismiss': 'offcanvas' },
          aria:  { label: 'Close' }
        ) do
          block_given? ? yield : xbutton
        end
      end

      # @todo
      #
      #
      def body(opts = {}, &block)
        id    = opts.fetch(:id, nil)
        klass = opts.fetch(:class, '')
        data  = opts.fetch(:data, {})
        aria  = opts.fetch(:aria, {})

        content_tag(
          :div,
          id:    id,
          class: "offcanvas-body #{klass}",
          data:  data,
          aria:  aria,
          &block
        )
      end

      # @todo
      #
      #
      def to_s
        @data.merge!('bs-scroll':   @scrollable)
        @data.merge!('bs-backdrop': @backdrop)

        content_tag(
          :div,
          id:       @id,
          class:    "offcanvas offcanvas-#{@position} #{@class}",
          tabindex: -1,
          data:     @data,
          aria:     { labelledby: 'offcanvasExampleLabel' }
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
