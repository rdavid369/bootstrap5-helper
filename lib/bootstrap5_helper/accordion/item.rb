module Bootstrap5Helper
  class Accordion
    class Item < Component # :nodoc:
      # Take note that if `parent_id` is <tt>NilClass</tt> it is because
      # the <tt>Accordion::Item</tt> is meant to stay open and not close
      # the previous one.
      #
      # @param [ActionView] template
      # @param [String|NilClass] parent_id
      # @param [Hash] opts
      # @option opts [String]  :id
      # @option opts [String]  :class
      # @option opts [Hash]    :data
      # @option opts [Hash]    :collapse
      #
      def initialize(template, parent_id = nil, opts = {}, &block)
        super(template)

        @parent         = parent_id
        @id             = opts.fetch(:id,       uuid)
        @class          = opts.fetch(:class,    '')
        @data           = opts.fetch(:data,     {})
        @expanded       = opts.fetch(:expanded, false)
        @collapse       = opts.fetch(:collapse, {})
        @collapse_id    = @collapse.fetch(:id,    uuid)
        @collapse_klass = @collapse.fetch(:class, '')
        @collapse_data  = @collapse.fetch(:data,  {})
        @header_id      = uuid
        @content        = block || proc { '' }
      end

      # rubocop:disable Metrics/MethodLength

      # Builds a header component for the accordion.
      #
      # @overload header(tag, opts)
      #   @param [Symbol|String] tag - The HTML element to use.
      #   @param [Hash] options
      #   @option opts [String] :id
      #   @option opts [String] :class
      #   @option opts [Hash] :data
      #
      # @overload header(opts)
      #   @param [Hash] options
      #   @option opts [String] :id
      #   @option opts [String] :class
      #   @option opts [Hash] :data
      #
      # @return [String]
      #
      def header(*tag_or_options, &block)
        tag, args = parse_tag_or_options(*tag_or_options, {})

        @header_id = args.fetch(:id,    @header_id)
        klass      = args.fetch(:class, '')
        data       = args.fetch(:data,  {})

        content_tag(
          tag || config({ accordions: :header }, :h2),
          id:    @header_id,
          class: "accordion-header #{klass}",
          data:  data
        ) do
          content_tag(
            :button,
            type:  :button,
            class: "accordion-button #{@expanded ? '' : 'collapsed'}",
            data:  {
              'bs-toggle' => 'collapse',
              'bs-target' => "##{@collapse_id}"
            },
            aria:  {
              expanded: @expanded,
              controls: @collapse_id
            },
            &block
          )
        end
      end
      # rubocop:enable Metrics/MethodLength

      # rubocop:disable Metrics/MethodLength

      # Builds the body component for the accordion.
      #
      # @param  [Hash] opts
      # @option opts [String] :id
      # @option opts [String] :class
      # @option opts [Hash] :data
      # @return [String]
      #
      def body(opts = {}, &block)
        id     = opts.fetch(:id,    uuid)
        klass  = opts.fetch(:class, '')
        data   = opts.fetch(:data,  {})

        content_tag(
          :div,
          id:    @collapse_id,
          class: "accordion-collapse collapse #{@collapse_klass} #{@expanded ? 'show' : ''}",
          aria:  { labelledby: @header_id },
          data:  {
            'bs-parent' => @parent.present? ? "##{@parent}" : nil
          }.merge(@collapse_data)
        ) do
          content_tag(
            :div,
            id:    id,
            class: "accordion-body #{klass}",
            data:  data,
            &block
          )
        end
      end
      # rubocop:enable Metrics/MethodLength

      # String representation of the object.
      #
      # @return [String]
      #
      def to_s
        content_tag :div, id: @id, class: "accordion-item #{@class}", data: @data do
          @content.call(self)
        end
      end
    end
  end
end
