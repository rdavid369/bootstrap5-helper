module Bootstrap5Helper
  # rubocop:disable Metrics/ClassLength

  # Builds a Modal window component.
  #
  #
  class Modal < Component
    # Class constructor
    #
    # @param  [ActionView] template
    # @param  [Hash] opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @option opts [Boolean] :scrollable
    # @option opts [Boolean] :vcentered
    # @option opts [Boolean] :static
    # @option opts [Boolean|Symbol] :fullscreen
    # @option opts [Symbol]  :size
    #
    def initialize(template, opts = {}, &block)
      super(template)

      @id         = opts.fetch(:id,         uuid)
      @class      = opts.fetch(:class,      '')
      @data       = opts.fetch(:data,       {})
      @scrollable = opts.fetch(:scrollable, false)
      @vcentered  = opts.fetch(:vcentered,  false)
      @static     = opts.fetch(:static,     false)
      @fullscreen = opts.fetch(:fullscreen, true)
      @size       = opts.fetch(:size,       nil)
      @content    = block || proc { '' }
    end

    # Build the header component for the modal.
    #
    # @param  [Hash] opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @return [String]
    #
    def header(opts = {}, &block)
      build_main_component :header, opts, &block
    end

    # Builds the body component.
    #
    # @param  [Hash] opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @return [String]
    #
    def body(opts = {}, &block)
      build_main_component :body, opts, &block
    end

    # Builds the footer component.
    #
    # @param  [Hash] opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @return [String]
    #
    def footer(opts = {}, &block)
      build_main_component :footer, opts, &block
    end

    # Builds a title component.
    #
    # @param  [Hash] opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @return [String]
    #
    def title(opts = {}, &block)
      build_sub_component config({ modals: :title }, :h5), :title, opts, &block
    end

    # Builds a close button component.
    #
    # @param  [Hash] opts
    # @option opts [String] :class
    # @return [String]
    #
    def close_button(opts = {})
      klass = opts.fetch(:class, '')

      content_tag(
        :button,
        type:  'button',
        class: block_given? ? klass : 'btn-close',
        data:  { 'bs-dismiss': 'modal' },
        aria:  { label: 'Close' }
      ) do
        block_given? ? yield : xbutton
      end
    end

    # rubocop:disable Metrics/MethodLength

    # String representation of the object.
    #
    # @return [String]
    #
    def to_s
      @data.merge!('bs-backdrop' => 'static', 'bs-keyboard' => false) if @static

      content_tag(
        :div,
        id:       @id,
        class:    "modal #{@class}",
        tabindex: -1,
        role:     'dialog',
        data:     @data
      ) do
        content_tag(
          :div,
          class: "modal-dialog #{size} #{scrollable} #{vcentered} #{fullscreen}",
          role:  'document'
        ) do
          content_tag(:div, class: 'modal-content') { @content.call(self) }
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    private

    # Used to build main components, usually divs.
    #
    # @param  [Symbol|String] type
    # @param  [Hash] opts
    # @return [String]
    #
    def build_main_component(type, opts = {}, &block)
      build_sub_component :div, type, opts, &block
    end

    # Used to build more specific components.
    #
    # @param [Symbol] tag
    # @param [Symbol|String] type
    # @param [Hash] opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @return [String]
    #
    def build_sub_component(tag, type, opts = {}, &block)
      id    = opts.fetch(:id,    nil)
      klass = opts.fetch(:class, '')
      data  = opts.fetch(:data,  {})

      content_tag(
        tag,
        id:    id,
        class: "modal-#{type} #{klass}",
        data:  data,
        &block
      )
    end

    # Builds the `x` button normally used in the header.
    #
    # @return [String]
    #
    def xbutton
      content_tag :span, '&times;'.html_safe, class: 'visually-hidden', aria: { hidden: true }
    end

    # Gets the scrollable CSS class.
    #
    # @return [String]
    #
    def scrollable
      @scrollable ? 'modal-dialog-scrollable' : ''
    end

    # Gets the vertical-center CSS class.
    #
    # @return [String]
    #
    def vcentered
      @vcentered ? 'modal-dialog-centered' : ''
    end

    # Gets the fullscreen class.
    #
    # @return [String]
    #
    def fullscreen
      case @fullscreen
      when TrueClass
        'modal-fullscreen'
      when String, Symbol
        "modal-fullscreen-#{@fullscreen}-down	"
      else
        ''
      end
    end

    # Gets the size of the modal window.
    #
    # @return [String]
    #
    def size
      case @size
      when :xlarge
        'modal-xl'
      when :large
        'modal-lg'
      when :small
        'modal-sm'
      else
        ''
      end
    end
  end
  # rubocop:enable Metrics/ClassLength
end
