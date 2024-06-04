require 'test_helper'

# rubocop:disable Metrics/ClassLength
class CardTest < ActionView::TestCase
  setup do
    render 'components/cards', name: 'Todos', min: 1, max: 5

    @root      = document_root_element.at("//div[contains(@id, 'root')]")
    @default   = @root.at(".//div[contains(@id,    'default')]")
                      .at(".//div[contains(@class, 'card')]")
    @image_cap = @root.at(".//div[contains(@id,    'image_cap')]")
                      .at(".//div[contains(@class, 'card')]")
    @custom    = @root.at(".//div[contains(@id,    'custom')]")
                      .at(".//div[contains(@class, 'card')]")
    @bindings  = @root.at(".//div[contains(@id,    'bindings')]")
                      .at(".//div[contains(@class, 'card')]")
  end

  test 'Default card wrapper component should have default class' do
    assert(@default['class'].match?('card'))
  end

  test 'Default card should have a header component' do
    assert(default_header.present?)
  end

  test 'Default card header should have the proper text' do
    assert(default_header.text.match?('This is the default header...'))
  end

  test 'Default card should have a body component' do
    assert(default_body.present?)
  end

  test 'Default card body should have a title component' do
    title = default_body.at(".//*[contains(@class, 'card-title')]")
    assert(title.present? && title.text.match?('Default title'))
  end

  test 'Default card body should have a subtitle component' do
    subtitle = default_body.at(".//*[contains(@class, 'card-subtitle')]")
    assert(subtitle.present? && subtitle.text.match?('Default subtitle'))
  end

  test 'Default card body should have a text component' do
    text = default_body.at(".//*[contains(@class, 'card-text')]")
    assert(text.present? && text.text.match?('Default card text'))
  end

  test 'Default card body should have a ul component' do
    ul = default_body.at('.//ul')
    assert(ul.present? && ul.search('li').count == 3)
  end

  test 'Default card should have a footer component' do
    assert(default_footer.present?)
  end

  test 'Default card footer should have the proper text' do
    assert(default_footer.text.match?('This is the default footer...'))
  end

  test 'ImageCap card should have a image cap component' do
    image = @image_cap.at(".//img[contains(@class, 'card-img-top')]")
    assert(image.present?)
  end

  test 'ImageCap card should have a proper file or url location for the image component' do
    image = @image_cap.at(".//img[contains(@class, 'card-img-top')]")
    assert(image['src'] == '/images/placeholder.svg')
  end

  test 'ImageCap card should have a body component' do
    assert(@image_cap.at(".//*[contains(@class, 'card-body')]").present?)
  end

  test 'Custom card should have the following classes :card :custom-wrapper-class' do
    assert(
      %w[card custom-wrapper-class].all? { |klass| @custom['class'].match?(klass) }
    )
  end

  test 'Custom card should have the correct id attribute' do
    assert(@custom['id'].match?('custom_wrapper_id'))
  end

  test 'Custom card should have the correct data attributes' do
    assert(@custom['data-name'].match?('CustomCard'))
  end

  test 'Custom card should have a header component' do
    assert(custom_header.present?)
  end

  test 'Custom card header should be a div element' do
    assert(custom_header.name == 'div')
  end

  test <<-TEXT do
    Custom card header should have the following classes .card-header .custom-card-header
  TEXT
    assert(
      %w[card-header h5].all? do |klass|
        custom_header['class'].match?(klass)
      end
    )
  end

  test 'Custom card header should have the correct id attribute' do
    assert(custom_header['id'].match?('custom_header'))
  end

  test 'Custom card header should have the correct data attributes' do
    assert(custom_header['data-name'].match?('CustomHeader'))
  end

  test 'Custom card body should have the following classes .card-body .custom-body' do
    assert(
      %w[card-body custom-body].all? { |klass| custom_body['class'].match?(klass) }
    )
  end

  test 'Custom card body should have the correct id attribute' do
    assert(custom_body['id'].match?('custom_body'))
  end

  test 'Custom card body should have the correct data attribute' do
    assert(custom_body['data-name'].match?('CustomBody'))
  end

  # @note Simple iterator to generate the exact same tests for the following
  #   :title, :subtitle and :text.
  #
  %i[title subtitle text].each do |type|
    test "Custom card #{type} should be a div element" do
      assert(send("custom_#{type}").name == 'div')
    end

    test "Custom card #{type} should have the correct id attribute" do
      assert(send("custom_#{type}")['id'].match?("custom_#{type}"))
    end

    test "Custom card #{type} should the following classes .card-#{type} custom-#{type}" do
      assert(
        ["card-#{type}", "custom-#{type}"].all? do |klass|
          send("custom_#{type}")['class'].match?(klass)
        end
      )
    end

    test "Custom card #{type} should have the correct data attributes" do
      assert(send("custom_#{type}")['data-name'].match?("Custom#{type.to_s.capitalize}"))
    end
  end

  test 'Bindings card header should have the correct text' do
    header = @bindings.at(".//*[contains(@class, 'card-header')]")
    assert(header.text.match?('My Todos List:'))
  end

  test 'Bindings card title should have the correct text' do
    title = bindings_body.at(".//*[contains(@class, 'card-title')]")
    assert(title.text.match?('Title: Todos'))
  end

  test 'Bindings card subtitle should have the correct text' do
    subtitle = bindings_body.at(".//*[contains(@class, 'card-subtitle')]")
    assert(subtitle.text.match?('Subtitle: Todos'))
  end

  test 'Bindings card text should have the correct text' do
    text = bindings_body.at(".//*[contains(@class, 'card-text')]")
    assert(text.text.match?('Text: Todos'))
  end

  test 'bindings card body should have a ul element with 5 li elements' do
    ul = bindings_body.search('ul')
    assert(ul.present? && ul.search('li').count == 5)
  end

  test 'Bindings card body li elements should have correct text' do
    count = 0
    lis   = bindings_body.search('ul').search('li')

    assert(lis.all? { |li| li.text.match?("Todo Item: #{count += 1}") })
  end

  test 'Bindings card footer should have the correct text' do
    footer = @bindings.at(".//*[contains(@class, 'card-footer')]")
    assert(footer.text.match?('Todos list: 1-5'))
  end

  private

  # Get the card-header component, regardless if of element used.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_header
    @default.at(".//*[contains(@class, 'card-header')]")
  end

  # Get the card-body component, regardless if of element used.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_body
    @default.at(".//*[contains(@class, 'card-body')]")
  end

  # Get the card-footer component, regardless if of element used.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_footer
    @default.at(".//*[contains(@class, 'card-footer')]")
  end

  # Get the card-header component, regardless if of element used.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_header
    @custom.at(".//*[contains(@class, 'card-header')]")
  end

  # Get the card-body component, regardless if of element used.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_body
    @custom.at(".//*[contains(@class, 'card-body')]")
  end

  # Get the card-footer component, regardless if of element used.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_footer
    @custom.at(".//*[contains(@class, 'card-footer')]")
  end

  # Get the card-title component, regardless if of element used.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_title
    custom_body.at(".//*[contains(@class, 'card-title')]")
  end

  # Get the card-subtitle component, regardless if of element used.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_subtitle
    custom_body.at(".//*[contains(@class, 'card-subtitle')]")
  end

  # Get the card-text component, regardless if of element used.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_text
    custom_body.at(".//*[contains(@class, 'card-text')]")
  end

  # Get the card-body component, regardless if of element used.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def bindings_body
    @bindings.at(".//*[contains(@class, 'card-body')]")
  end
end
# rubocop:enable Metrics/ClassLength
