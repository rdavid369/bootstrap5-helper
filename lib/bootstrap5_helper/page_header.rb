module Bootstrap5Helper
  # Builds a simple CSS spinner component.
  #
  #
  class PageHeader < Component
    # Class constructor
    #
    # @param [ActionView] template
    # @param [Symbol|Hash]    tag_or_options
    # @param [Hash] opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    #
    def initialize(template, tag_or_options = nil, opts = {}, &block)
      super(template)

      @tag, args = parse_tag_or_options(tag_or_options, opts)
      @tag ||= config(:page_header, :h1)

      @id      = args.fetch(:id,    uuid)
      @class   = args.fetch(:class, '')
      @data    = args.fetch(:data,  {})
      @content = block || proc { '' }
    end

    # String representation of the object.
    #
    # @return [String]
    #
    def to_s
      content_tag(
        @tag,
        id:    @id,
        class: "pb-2 mt-4 mb-2 border-bottom #{@class}",
        data:  @data
      ) do
        @content.call(self)
      end
    end
  end
end
