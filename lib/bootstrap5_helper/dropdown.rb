module Bootstrap5Helper
  # Builds a Dropdown component that can be used in other components.
  #
  #
  class Dropdown < Component
    # Class constructor
    #
    # @param [ActionView]    template
    # @param [Symbol|String] type
    # @param [Hash]          opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @option opts [Boolea]  :split
    # @option opts [Boolean] :centered
    #
    def initialize(template, type = :dropdown, opts = {}, &block)
      super(template)

      @type     = type
      @split    = opts.fetch(:split,    false)
      @centered = opts.fetch(:centered, false)
      @id       = opts.fetch(:id,       uuid)
      @class    = opts.fetch(:class,    '')
      @data     = opts.fetch(:data,     {})
      @content  = block || proc { '' }
    end

    # Used to generate a button for the dropdown.  The buttons default as just
    # a button that opens the coresponding dropdown menu.  The `split: true` option
    # make the button just the arrow indicator that open the menu.
    #
    # @param  [Symbol] context
    # @param  [Hash]   opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @option opts [Boolean] :split
    # @return [String]
    #
    def button(context = :primary, opts = {})
      id     = opts.fetch(:id,    nil)
      klass  = opts.fetch(:class, '')
      split  = opts.fetch(:split, false)
      data   = opts.fetch(:data,  {}).merge('bs-toggle' => 'dropdown')
      extra  = @split ? 'dropdown-toggle-split' : ''

      content_tag(
        :button,
        id:    id,
        type:  'button',
        class: "dropdown-toggle btn btn-#{context} #{klass} #{extra}",
        data:  data,
        aria:  { haspopup: true, expanded: false }
      ) do
        split ? content_tag(:span, 'Toggle Dropdown', class: 'visually-hidden') : yield
      end
    end

    # Used to create a new `Dropdown::Menu`
    #
    # @param  [Hash] opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @return [Dropdown::Menu]
    #
    def menu(opts = {}, &block)
      Menu.new(@template, opts, &block)
    end

    # String reprentation of the object.
    #
    # @return [String]
    #
    def to_s
      content_tag(
        :div,
        id:    @id,
        class: "#{element_type_class} #{alignment_type_class} #{@class}",
        data:  @data
      ) do
        @content.call(self)
      end
    end

    private

    # Returns the container class for the dropdown component.
    #
    # @return [String]
    #
    def element_type_class
      case @type
      when :dropdown
        'dropdown'
      when :dropup
        'dropup'
      when :dropstart
        'dropstart'
      when :dropend
        'dropend'
      else
        ''
      end
    end

    # Returns the alignment class for the dropdown component.
    #
    # @return [String]
    #
    def alignment_type_class
      case @type
      when :dropdown, :dropup
        @centered ? "#{element_type_class}-center" : ''
      else
        ''
      end
    end
  end
end
