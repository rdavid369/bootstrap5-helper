module Bootstrap5Helper
  # The Alert helper is meant to help you rapidly build Bootstrap Alert
  # components quickly and easily. The dissmiss button is optional.
  #
  class Alert < Component
    # Class constructor
    #
    # @param [Class] template - Template in which your are binding too.
    # @param [NilClass|String|Symbol|Hash] context_or_options
    # @param [Hash]  opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Boolean] :dismissible
    # @return [Alert]
    #
    def initialize(template, context_or_options = nil, opts = {}, &block)
      super(template)
      @context, args = parse_context_or_options(context_or_options, opts)

      @id          = args.fetch(:id,          uuid)
      @class       = args.fetch(:class,       '')
      @dismissible = args.fetch(:dismissible, false)
      @content     = block || proc { '' }
    end

    # The dissmiss button, if the element has one.
    #
    # @return [String]
    #
    def close_button
      content_tag(
        :button,
        '',
        class: 'btn-close',
        data:  { 'bs-dismiss' => 'alert' },
        aria:  { label: 'Close' }
      )
    end

    # Used to render out the Alert component.
    #
    # @return [String]
    #
    def to_s
      content_tag :div, id: @id, class: container_class do
        concat(@dismissible ? close_button : '')
        @content.call(self)
      end
    end

    private

    # Used to get the container classes.
    #
    # @return [String]
    #
    def container_class
      "alert alert-#{@context} #{@class} #{dismissible_class}"
    end

    # Class used on parent element to signify a dismissible button.
    #
    # @return [String]
    #
    def dismissible_class
      @dismissible ? 'alert-dismissible fade show' : ''
    end
  end
end
