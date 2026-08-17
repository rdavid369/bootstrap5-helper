module Bootstrap5Helper
  # Builds a Overlay component that can be used in other components.
  #
  #
  class Overlay < Component
    # Class constructor
    #
    # @overload initialize(template, tag, opts)
    #   @param [ActionView]    template
    #   @param [Symbol|String] tag - The HTML element to use to wrap the component.
    #   @param [Hash]          opts
    #   @option opts [String]  :id
    #   @option opts [String]  :class
    #   @option opts [Hash]    :data
    #   @option opts [Boolean] :centered
    #
    # @overload initialize(template, opts)
    #   @param [ActionView]    template
    #   @param [Hash]          opts
    #   @option opts [String]  :id
    #   @option opts [String]  :class
    #   @option opts [Hash]    :data
    #   @option opts [Boolean] :centered
    #
    # @return [Overlay]
    #
    def initialize(template, *tag_or_options, &block)
      super(template)

      @tag, args = parse_tag_or_options(*tag_or_options, {})
      @attrs     = args
      @split     = @attrs.delete(:split)    { false }
      @centered  = @attrs.delete(:centered) { false }
      @id        = @attrs.delete(:id)       { uuid }
      @class     = @attrs.delete(:class)    { '' }
      @data      = @attrs.delete(:data)     { {} }

      @content   = block || proc { '' }
    end

    # rubocop:disable Metrics/MethodLength

    # Used to generate a button for the dropdown.  This button just
    # opens the coresponding dropdown menu.
    #
    # @param  [Symbol] context
    # @param  [Hash]   opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @return [String]
    #
    def button(context = :primary, opts = {}, &block)
      attrs  = opts
      klass  = attrs.delete(:class) { '' }
      data   = attrs.delete(:data)  { {} }
      aria   = attrs.delete(:aria)  { {} }

      content_tag(
        :button,
        {
          type:  'button',
          class: "dropdown-toggle btn btn-#{context} #{klass}",
          data:  data.merge(
            'bs-toggle'  => 'dropdown',
            'bs-display' => 'static'
          ),
          aria:  aria.merge(
            haspopup: true,
            expanded: false
          )
        }.merge(attrs),
        &block
      )
    end
    # rubocop:enable Metrics/MethodLength

    # Used to generate a button with just the caret, to open the dropdown.
    #
    # @param  [Symbol] context
    # @param  [Hash]   opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @return [String]
    #
    def caret(context = :primary, opts = {})
      id     = opts.fetch(:id,    nil)
      klass  = opts.fetch(:class, '')
      data   = opts.fetch(:data,  {}).merge('bs-toggle' => 'dropdown')

      content_tag(
        :button,
        id:    id,
        type:  'button',
        class: "dropdown-toggle btn btn-#{context} #{klass} dropdown-toggle-split",
        data:  data,
        aria:  { haspopup: true, expanded: false }
      ) do
        content_tag(:span, 'Toggle Dropdown', class: 'visually-hidden')
      end
    end

    # Used to create a new <tt>Overlay::Menu</tt>
    #
    # @param  [Hash] opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @yield [Menu]
    # @return [Menu]
    #
    def menu(*tag_or_options, &block)
      Menu.new(@template, *tag_or_options, &block)
    end

    # String reprentation of the object.
    #
    # @return [String]
    #
    def to_s
      content_tag(
        @tag || :div,
        {
          id:    @id,
          class: "#{@type} #{alignment_type_class} #{@class}",
          data:  @data
        }.merge(@attrs)
      ) do
        @content.call(self)
      end
    end

    private

    # Returns the alignment class for the dropdown component.
    #
    # @return [String]
    #
    def alignment_type_class
      case @type
      when :dropdown, :dropup
        @centered ? "#{@type}-center" : ''
      else
        ''
      end
    end
  end
end
