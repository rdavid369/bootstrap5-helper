require 'test_helper'

class AlertTest < ActionView::TestCase
  setup do
    render 'components/alerts', name: 'Todos', min: 1, max: 5

    @root     = document_root_element.at("//div[contains(@id, 'root')]")
    @default  = @root.at(".//div[contains(@id,    'default')]")
                     .at(".//div[contains(@class, 'alert')]")
    @custom   = @root.at(".//div[contains(@id,    'custom')]")
                     .at(".//div[contains(@class, 'alert')]")
    @bindings = @root.at(".//div[contains(@id,    'bindings')]")
                     .at(".//div[contains(@class, 'alert')]")
  end

  test 'Default alert should have a default contextual class' do
    assert(@default['class'].match?('alert-secondary'))
  end

  test 'Custom alert should have the following classes .alert .custom-alert' do
    assert(
      %w[alert custom-alert].all? { |klass| @custom['class'].match?(klass) }
    )
  end

  test 'Custom alert should be dismissible' do
    assert(@custom['class'].match?('alert-dismissible'))
  end

  test 'Custom alert should have a custom id attribute' do
    assert(@custom['id'].match?('custom_alert'))
  end

  test 'Bindings alert should have P tag with the proper text' do
    assert(@bindings.text.match?('List for Todos'))
  end

  test 'Bindings alert should have five LI elements' do
    li = @bindings.search('.//li')
    assert(li.count == 5 && li.each_with_index { |l, i| l.text.match?("Todo ##{i + 1}") })
  end
end
