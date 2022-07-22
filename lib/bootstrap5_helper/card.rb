module Bootstrap5Helper
  # Used to build Bootstrap Card components.  Cards are wildly used through Bootstrap 4.
  #
  #
  class Card < Component
    # Used to initialize a new Card component.
    #
    # @param  [ActionView] template
    # @param  [Hash]  opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @return [Card]
    #
    def initialize(template, opts = {}, &block)
      super(template)

      @id      = opts.fetch(:id,    '')
      @class   = opts.fetch(:class, '')
      @data    = opts.fetch(:data,  nil)
      @content = block || proc { '' }
    end

    # Builds the Header component.
    #
    # @param  [Symbol|Hash|NilClass] tag_or_options
    # @param  [Hash] opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @return [String]
    #
    def header(tag_or_options = nil, opts = {}, &block)
      tag, args = parse_tag_or_options(tag_or_options, opts)
      build_base_component(
        tag || config({ cards: :header }, :h5),
        :header,
        args,
        &block
      )
    end

    # Builds the Body component.
    #
    # @param  [Symbol|Hash|NilClass] tag_or_options
    # @param  [Hash] opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @return [String]
    #
    def body(tag_or_options = nil, opts = {}, &block)
      tag, args = parse_tag_or_options(tag_or_options, opts)
      build_base_component(
        tag || config({ cards: :body }, :div),
        :body,
        args,
        &block
      )
    end

    # Builds the Footer component.
    #
    # @param  [Symbol|Hash|NilClass] tag_or_options
    # @param  [Hash] opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @return [String]
    #
    def footer(tag_or_options = nil, opts = {}, &block)
      tag, args = parse_tag_or_options(tag_or_options, opts)
      build_base_component(
        tag || config({ cards: :footer }, :div),
        :footer,
        args,
        &block
      )
    end

    # Builds a Title component.
    #
    # @param  [Symbol|Hash|NilClass] tag_or_options
    # @param  [Hash] opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @return [String]
    #
    def title(tag_or_options = nil, opts = {}, &block)
      tag, args = parse_tag_or_options(tag_or_options, opts)
      build_sub_component(
        tag || config({ cards: :title }, :h5),
        :title,
        args,
        &block
      )
    end

    # Builds a Text component.
    #
    # @param  [Symbol|Hash|NilClass] tag_or_options
    # @param  [Hash] opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @return [String]
    #
    def text(tag_or_options = nil, opts = {}, &block)
      tag, args = parse_tag_or_options(tag_or_options, opts)
      build_sub_component(
        tag || config(:card_text, :p),
        :text,
        args,
        &block
      )
    end

    # @todo
    #
    #
    def image(src, opts = {})
      (opts[:class] ||= '') << 'card-img'
      @template.image_tag(src, opts)
    end

    # Builds an Image Cap component.
    #
    # @param  [String] src,
    # @param  [Symbol|String] type
    # @param  [Hash] opts
    # @return [String]
    #
    def image_cap(src, type = :top, opts = {})
      (opts[:class] ||= '') << "card-img-#{type}"
      @template.image_tag(src, opts)
    end

    # Builds a Img Overlay component.
    #
    # @param  [Hash] args
    # @option args [String] :id
    # @option args [String] :class
    # @option args [Hash]   :data
    # @return [String]
    #
    def image_overlay(args = {}, &block)
      build_base_component(:div, 'img-overlay', args, &block)
    end

    # Outputs the Object in its String representation.
    #
    # @return [String]
    #
    def to_s
      content_tag :div, id: @id, class: "card #{@class}", data: @data do
        @content.call(self)
      end
    end

    private

    # Used to build basic DIV components.
    #
    # @param  [String] type
    # @param  [Mixed] args
    # @return [String]
    #
    def build_base_component(tag, type, args, &block)
      build_sub_component(tag, type, args, &block)
    end

    # Used to build various DOM components.
    #
    # @param  [Symbol] tag
    # @param  [String] type
    # @param  [Hash]   args
    # @option args [String] :id
    # @option args [String] :class
    # @option args [Hash]   :data
    # @return [String]
    #
    def build_sub_component(tag, type, args, &block)
      id    = args.fetch(:id,    '')
      klass = args.fetch(:class, '')
      data  = args.fetch(:data,  {})

      content_tag(
        tag,
        id:    id,
        class: "card-#{type} #{klass}",
        data:  data,
        &block
      )
    end
  end
end
