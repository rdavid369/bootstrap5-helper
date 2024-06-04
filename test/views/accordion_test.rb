require 'test_helper'

# rubocop:disable Metrics/ClassLength
class AccordionTest < ActionView::TestCase
  setup do
    render 'components/accordions', name: 'Todos', min: 1, max: 5

    @root     = document_root_element.at("//div[contains(@id, 'root')]")
    @default  = @root.at(".//div[contains(@id,    'default')]")
                     .at(".//div[contains(@class, 'accordion')]")
    @custom   = @root.at(".//div[contains(@id,    'custom')]")
                     .at(".//div[contains(@class, 'accordion')]")
    @bindings = @root.at(".//div[contains(@id,    'bindings')]")
                     .at(".//div[contains(@class, 'accordion')]")

    @default_items = @default.search(".//div[contains(@class, 'accordion-item')]")
    @custom_items  = @custom.search(".//div[contains(@class, 'accordion-item')]")
    @binding_items = @bindings.search(".//div[contains(@class, 'accordion-item')]")
  end

  test 'Wrapper element should have default class attribute' do
    assert(@default['class'].match?('accordion'))
  end

  test 'Wrapper element should have a default id attribute' do
    assert(@default['id'].present?)
  end

  test 'Should have an two item elements' do
    assert_equal(@default_items.count, 2)
  end

  test 'Header should be a H2 element' do
    header, _button = default_first_header_and_button
    assert(header.name == 'h2')
  end

  test 'Header should have default class attribute' do
    header, _button = default_first_header_and_button
    assert(header['class'].match?('accordion-header'))
  end

  test 'Header should a default id attribute' do
    header, _button = default_first_header_and_button
    assert(header['id'].present?)
  end

  test 'Header should have a button for toggling the state' do
    _header, button = default_first_header_and_button
    assert(button['class'].match?('accordion-button'))
  end

  test 'Body should be wrapped in a collapse element' do
    body = @default_items.first.at('div')
    assert(body['class'].match?('accordion-collapse'))
  end

  test 'Body should have a default id attribute' do
    body = @default_items.first.at('div').at('div')
    assert(body['id'].present?)
  end

  test 'Body should have a default class attribute' do
    body = @default_items.first.at('div').at('div')
    assert(body['class'].match?('accordion-body'))
  end

  test 'Header button should target the body element' do
    _header, button = default_first_header_and_button
    body = @default_items.first.at('div')

    assert(button['data-bs-target'][1..-1] == body['id'])
  end

  test 'Block shorthand syntax should properly work in header elements' do
    header, _button = default_second_header_and_button
    assert(header.text.match?('Item Two Default Header.'))
  end

  test 'Block shorthand syntax should properly work in body elements' do
    body = @default_items.last.at('div')
    assert(body.text.match?('Item Two Default Body.'))
  end

  test 'Custom wrapper should have the following classes .accordion .user-defined' do
    assert(
      %w[accordion user-defined].all? { |klass| @custom['class'].match?(klass) }
    )
  end

  test 'Custom wrapper should have a custom id attribute' do
    assert(@custom['id'].match?('user_defined'))
  end

  test 'Custom wrapper should have data attributes' do
    assert(
      @custom['data-firstname'].match?('Billy') &&
      @custom['data-lastname'].match?('Bob')
    )
  end

  test 'Custom Accordion::Item should have the following classes .accordion-item .user-defined-item' do
    item = @custom_items.first
    assert(
      %w[accordion-item user-defined-item].all? { |klass| item['class'].match?(klass) }
    )
  end

  test 'Custom Accordion::Item should have custom id attribute' do
    item = @custom_items.first
    assert(item['id'].match?('user_defined_item'))
  end

  test 'Custom Accordion::Item should have custom data attributes' do
    item = @custom_items.first
    assert(
      item['data-age'].match?('50') &&
      item['data-eyes'].match?('blue')
    )
  end

  test 'Custom Header should be DIV element instead of the default H2' do
    header, _button = custom_first_header_and_button
    assert(header.name.match?('div'))
  end

  test 'Custom Header should have the following classes .accordion-header .h2' do
    header, _button = custom_first_header_and_button
    assert(
      %w[accordion-header h2].all? { |klass| header['class'].match?(klass) }
    )
  end

  test 'Custom Header should have a custom id attribute' do
    header, _button = custom_first_header_and_button
    assert(header['id'].match?('user_defined_header'))
  end

  test 'Custom Header should have custom data attributes' do
    header, _button = custom_first_header_and_button
    assert(
      header['data-height'].match?('5') &&
      header['data-weight'].match?('150')
    )
  end

  test 'Custom Body should have the following classes .accordion-body .user-defined-body' do
    body = @custom_items.first.search('div')[1].at('div')

    assert(
      %w[accordion-body user-defined-body].all? { |klass| body['class'].match?(klass) }
    )
  end

  test 'Custom Body should have data attributes' do
    body = @custom_items.first.search('div')[1].at('div')
    assert(body['data-status'].match?('working'))
  end

  test <<-TEXT do
    Custom Header with shorthand, should have the following classes .accordion-header
    .user-defined-shorthand-header
  TEXT
    header, _button = custom_second_header_and_button
    assert(
      %w[accordion-header user-defined-shorthand-header].all? do |klass|
        header['class'].match?(klass)
      end
    )
  end

  test <<-TEXT do
    Custom Body with shorthand, should have the following classes .accordion-body
    .user-defined-shorthand-body
  TEXT
    body = @custom_items.last.at('div').at('div')
    assert(
      %w[accordion-body user-defined-shorthand-body].all? do |klass|
        body['class'].match?(klass)
      end
    )
  end

  test 'Bindings Header should have proper text for variable' do
    header = @binding_items.first.at(".//h2[contains(@class, 'accordion-header')]")
    assert(header.text.match?('List for: Todos'))
  end

  test 'Bindings Body should have five Li elements' do
    body = @binding_items.first.at(".//div[contains(@class, 'accordion-body')]")
    assert(body.search('li').count == 5)
  end

  private

  # Get the first default header and button elements.
  #
  # @return [Array]
  #
  def default_first_header_and_button
    header = @default_items.first.at(".//h2[contains(@class, 'accordion-header')]")
    button = header.at(".//button[contains(@class, 'accordion-button')]")

    [header, button]
  end

  # Get the second default header and button elements.
  #
  # @return [Array]
  #
  def default_second_header_and_button
    header = @default_items.last.at(".//h2[contains(@class, 'accordion-header')]")
    button = header.at(".//button[contains(@class, 'accordion-button')]")

    [header, button]
  end

  # Get the first custom header and button elements.
  #
  # @return [Array]
  #
  def custom_first_header_and_button
    header = @custom_items.first.at(".//div[contains(@class, 'accordion-header')]")
    button = header.at(".//button[contains(@class, 'accordion-button')]")

    [header, button]
  end

  # Get the second custom header and button elements.
  #
  # @return [Array]
  #
  def custom_second_header_and_button
    header = @custom_items.last.at(".//h2[contains(@class, 'accordion-header')]")
    button = header.at(".//button[contains(@class, 'accordion-button')]")

    [header, button]
  end
end
# rubocop:enable Metrics/ClassLength
