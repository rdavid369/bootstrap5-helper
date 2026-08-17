module Bootstrap5Helper
  # Builds a Accordion component.
  #
  #
  class Accordion < Component
    # Class constructor
    #
    # @param [ActionView] template
    # @param [Hash] opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @option opts [Boolean] :always_open
    # @option opts [Boolean] :flush
    #
    def initialize(template, opts = {}, &block)
      super(template)

      @attrs       = opts
      @id          = @attrs.delete(:id)          { uuid }
      @class       = @attrs.delete(:class)       { '' }
      @data        = @attrs.delete(:data)        { {} }
      @always_open = @attrs.delete(:always_open) { false }
      @flush       = @attrs.delete(:flush)       { false }
      @content     = block || proc { '' }
    end

    # Used to generate a <tt>Accordion::Item</tt> component.
    #
    # @return [Accodion::Item]
    #
    def item(opts = {}, &block)
      Accordion::Item.new(self, (@always_open ? nil : @id), opts, &block)
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
          class: "accordion #{@flush ? 'accordion-flush' : ''} #{@class}",
          data:  @data
        }.merge(@attrs)
      ) do
        @content.call(self)
      end
    end
  end
end
