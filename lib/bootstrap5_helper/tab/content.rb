module Bootstrap5Helper
  class Tab
    # Build a Content component to be used with Tabs
    #
    #
    class Content < Component
      # Class constructor
      #
      # @param [ActionView] template
      # @param [Hash] opts
      # @option opts [String]  :id
      # @option opts [String]  :class
      # @option opts [Hash]    :data
      #
      def initialize(template, opts = {}, &block)
        super(template)

        @attrs   = opts
        @id      = @attrs.delete(:id)    { uuid }
        @class   = @attrs.delete(:class) { '' }
        @data    = @attrs.delete(:data)  { {} }
        @content = block || proc { '' }
      end

      # Builds the pane for the tab.
      #
      # @param [Symbol] source
      # @param [Hash]   opts
      # @option opts [String]  :class
      # @option opts [Hash]    :data
      # @return [String]
      #
      def pane(source, opts = {}, &block)
        attrs = opts
        id    = attrs.delete(:id)    { source }
        klass = attrs.delete(:class) { '' }
        data  = attrs.delete(:data)  { {} }

        content_tag(
          :div,
          {
            id:    id,
            class: "tab-pane #{klass}",
            role:  'tabpanel',
            data:  data
          }.merge(attrs),
          &block
        )
      end

      # String representation of the object.
      #
      # @return [String]
      #
      def to_s
        content_tag(
          :div,
          {
            id:    @id,
            class: "tab-content #{@class}",
            data:  @data
          }.merge(@attrs)
        ) do
          @content.call(self)
        end
      end
    end
  end
end
