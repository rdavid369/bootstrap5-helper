module Bootstrap5Helper
  # Builds a Dropdown component that can be used in other components.
  #
  #
  class Overlay < Component
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
    def initialize(template, &block)
      super(template)

      @split    = @args.fetch(:split,    false)
      @centered = @args.fetch(:centered, false)
      @id       = @args.fetch(:id,       uuid)
      @class    = @args.fetch(:class,    '')
      @data     = @args.fetch(:data,     {})
      @content  = block || proc { '' }
    end

    # Used to generate a button for the dropdown.  The button default is to just
    # opens the coresponding dropdown menu.  The `split: true` option
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

    # Used to create a new <tt>Dropdown::Menu</tt>
    #
    # @param  [Hash] opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @yield [Menu]
    # @return [Menu]
    #
    def menu(opts = {}, &block)
      Menu.new(@template, opts, &block)
    end

    # String reprentation of the object.
    #
    # @return [String]
    #
    def to_s
      if @tag.present?
        content_tag(
          @tag,
          id:    @id,
          class: "#{@type} #{alignment_type_class} #{@class}",
          data:  @data
        ) do
          @content.call(self)
        end
      else
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
