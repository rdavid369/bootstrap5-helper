module Bootstrap5Helper
  # Builds a simple CSS spinner component.
  #
  #
  class Spinner < Component
    # Class constructor
    #
    # @note The different support types are: `:border` and `:grow`
    #
    # @param [ActionView] template
    # @param [Hash] opts
    # @option opts [Symbol]  :type
    # @option opts [Symbol]  :size
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    #
    def initialize(template, opts = {}, &block)
      super(template)

      @attrs   = opts
      @type    = @attrs.delete(:type)  { :border }
      @size    = @attrs.delete(:size)  { nil }
      @id      = @attrs.delete(:id)    { uuid }
      @class   = @attrs.delete(:class) { '' }
      @data    = @attrs.delete(:data)  { {} }
      @content = block || proc { '' }
    end

    # String representation of the object.
    #
    # @return [String]
    #
    def to_s
      content_tag(
        :span,
        {
          id:    @id,
          class: component_classes,
          role:  'status',
          aria:  { hidden: true },
          data:  @data
        }.merge(@attrs)
      ) do
        content_tag :span, 'Loading', class: 'visually-hidden'
      end
    end

    private

    # Cleaner way of getting the base component classes.
    #
    # @return [String]
    #
    def component_classes
      string = "spinner-#{@type} #{@class}"
      string << " spinner-#{@type}-#{@size}" if @size.present?

      string
    end
  end
end
