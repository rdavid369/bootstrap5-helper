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

      @id          = opts.fetch(:id,          uuid)
      @class       = opts.fetch(:class,       '')
      @data        = opts.fetch(:data,        {})
      @always_open = opts.fetch(:always_open, false)
      @flush       = opts.fetch(:flush,       false)
      @content     = block || proc { '' }
    end

    def item(*args, &block)
      Accordion::Item.new(self, (@always_open ? nil : @id), *args, &block)
    end

    # String representation of the object.
    #
    # @return [String]
    #
    def to_s
      content_tag(
        :div,
        id:    @id,
        class: "accordion #{@flush ? 'accordion-flush' : ''} #{@class}",
        data:  @data
      ) do
        @content.call(self)
      end
    end
  end
end
