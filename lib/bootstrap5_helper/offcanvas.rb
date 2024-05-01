module Bootstrap5Helper
  # Builds a Offcanvas component.
  #
  #
  class Offcanvas < Component
    # Class constructor
    #
    # @param  [ActionView]
    # @param  [NilClass|Symbol|Hash] position_or_options - :start, :end, :top, :bottom
    # @param  [Hash] opts
    # @option opts [String]  :id
    # @option opts [String]  :class
    # @option opts [Hash]    :data
    # @option opts [Hash]    :aria
    # @option opts [Boolean] :scrollable
    # @option opts [Boolean|String] :backdrop - true, false, static
    # @return [Offcanvas]
    #
    def initialize(template, position_or_options = nil, opts = {}, &block)
      super(template)
      @pos, args  = parse_position_or_options(position_or_options, opts)
      @id         = args.fetch(:id,         uuid)
      @class      = args.fetch(:class,      '')
      @data       = args.fetch(:data,       {})
      @aria       = args.fetch(:aria,       {})
      @scrollable = args.fetch(:scrollable, false)
      @backdrop   = args.fetch(:backdrop,   true)
      @content    = block || proc { '' }
    end
    # rubocop:disable Metrics/MethodLength

    # Creates a button element to act as the trigger for the offcanvas component.
    #
    # @param  [NilClass|String|Hash] text_or_options
    # @param  [Hash] opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @option opts [Hash]   :aria
    # @return [String]
    #
    def button(text_or_options = nil, opts = {}, &block)
      text, args = parse_text_or_options(text_or_options, opts)

      id    = args.fetch(:id,    nil)
      klass = args.fetch(:class, '')

      data = args.fetch(:data, {}).merge!(
        'bs-toggle' => 'offcanvas',
        'bs-target' => "##{@id}"
      )

      aria = args.fetch(:aria, {}).merge!(
        'controls' => @id
      )

      content_tag(
        :button,
        text,
        type:  :button,
        id:    id,
        class: klass,
        data:  data,
        aria:  aria,
        &block
      )
    end
    # rubocop:enable Metrics/MethodLength

    # Creates a simple link to toggle the offcanvas content.
    #
    # @param  [String|Hash|NilClass] text_or_options
    # @param  [Hash] opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @option opts [Hash]   :aria
    # @return [String]
    #
    def link(text_or_options = nil, opts = {}, &block)
      text, args  = parse_text_or_options(text_or_options, opts)
      args[:data] = args.fetch(:data,  {}).merge!({ 'bs-toggle': 'offcanvas' })
      args[:aria] = args.fetch(:aria,  {}).merge!({ 'controls': @id })

      options = ["##{@id}", args]
      options.prepend(text) if text.present?

      @template.link_to(*options, &block)
    end

    # rubocop:disable Metrics/MethodLength

    # Used to make a custom dom element for a trigger.  Use this when the
    # trigger isnt a link or button.
    #
    # @param  [Symbol|Hash|NilClass] tag_or_options
    # @param  [Hash] opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @option opts [Hash]   :aria
    # @return [String]
    #
    def trigger(tag_or_options = nil, opts = {}, &block)
      tag, args = parse_tag_or_options(tag_or_options, opts)

      id    = args.fetch(:id,    nil)
      klass = args.fetch(:class, '')
      aria  = args.fetch(:aria,  {}).merge!({ 'controls': @id })
      data  = args.fetch(:data,  {}).merge!(
        'bs-toggle': 'offcanvas',
        'bs-target': "##{@id}"
      )

      content_tag(
        tag || config({ offcanvas: :trigger }, :div),
        id:    id,
        class: klass,
        data:  data,
        aria:  aria,
        &block
      )
    end
    # rubocop:enable Metrics/MethodLength

    # Used to generate the main component.  This class serves as a wrapper, so
    # that buttons and links have reference to the content component.
    #
    # @return [String]
    #
    def content(&block)
      Content.new(
        @template,
        {
          id:         @id,
          class:      @class,
          data:       @data,
          aria:       @aria,
          scrollable: @scrollable,
          backdrop:   @backdrop,
          position:   @pos
        },
        &block
      )
    end

    # Renders the component as a String, but only to the output bugger.
    #
    # @note Was updated to return an empty string opposed to nil.
    # @see changelog.md
    #
    # @return [String]
    #
    def to_s
      @content.call(self)

      ''
    end

    private

    # Because this options parser is only going to be used here, I figured
    # we would just define it here.  That way other components don't have
    # to inherit it.
    #
    # @return [Array]
    #
    def parse_position_or_options(*args)
      parse_arguments(*args, 'start')
    end
  end
end
