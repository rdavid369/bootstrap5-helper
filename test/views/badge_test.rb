require 'test_helper'

class BadgeTest < ActionView::TestCase
  setup do
    render 'components/badges', name: 'Todos', min: 1, max: 5

    @root    = document_root_element.at("//div[contains(@id, 'root')]")
    @default = @root.at(".//div[contains(@id,     'default')]")
                    .at(".//span[contains(@class, 'badge')]")
    @custom  = @root.at(".//div[contains(@id,     'custom')]")
                    .at(".//span[contains(@class, 'badge')]")
  end

  test 'Default badge should have the default contextual class' do
    assert(
      %w[badge text-bg-secondary].all? { |klass| @default['class'].match?(klass) }
    )
  end

  test 'Default badge renders the proper text' do
    assert(@default.text.match?('5'))
  end

  test 'Custom badge has the following classes .badge .text-bg-primary .custom-badge' do
    assert(
      %w[badge text-bg-primary custom-badge].all? do |klass|
        @custom['class'].match?(klass)
      end
    )
  end
end
