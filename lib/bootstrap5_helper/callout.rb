module Bootstrap5Helper
  # Builds a Toast component.
  #
  #
  class Callout < Component
    # @param  [ActionView] template - Template in which your are binding too.
    # @param  [NilClass|String|Symbol|Hash] context_or_options - Bootstrap class context, or options hash.
    # @param  [Hash]  opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @return [Callout]
    #
    def initialize(template, context_or_options = nil, opts = {}, &block)
      super(template)
      @context, args = parse_context_or_options(context_or_options, opts)

      @id      = args.fetch(:id,    nil)
      @class   = args.fetch(:class, '')
      @data    = args.fetch(:data,  {})
      @content = block || proc { '' }
    end

    # Creates the header component for the Callout.
    #
    # @param  [String|Hash] text_or_options
    # @param  [Hash] opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @return [String]
    #
    def header(text_or_options = nil, opts = {}, &block)
      text = text_or_options.is_a?(String) ? text_or_options : nil
      content_tag(config({ callouts: :header }, :h4), text, opts, &block)
    end

    # Returns a string representation of the component.
    #
    # @return [String]
    #
    def to_s
      content_tag :div, id: @id, class: container_class, data: @data do
        @content.call(self)
      end
    end

    private

    # Used to get the container classes.
    #
    # @return [String]
    #
    def container_class
      "callout callout-#{@context} #{@class}"
    end
  end
end
