require 'test_helper'

# rubocop:disable Metrics/ClassLength
class CardWithNavTabTest < ActionView::TestCase
  setup do
    render 'components/card_with_nav_tab', name: 'Todos', min: 1, max: 5

    @root      = document_root_element.at("//div[contains(@id, 'root')]")
    @default   = @root.at(".//div[contains(@id,    'default')]")
                      .at(".//div[contains(@class, 'card')]")
  end

  test <<~TEXT do
    Default Card With Nav Tab's base element should have the following classes
    .card .with-nav-tabs-secondary
  TEXT
    assert(
      %w[card with-nav-tabs-secondary].all? do |klass|
        @default['class'].match?(klass)
      end
    )
  end

  test <<~TEXT do
    Default Card With Nav Tab should have a header element wrapping the nav
    component with the class .card-header
  TEXT
    assert(default_header['class'].match?('card-header'))
  end

  test 'Default Card With Nav Tab should have six nav items' do
    assert(default_nav_items.count == 6)
  end

  test 'Default Card With Nav Tab nav items should have correct class .nav-item' do
    assert(default_nav_items.all? { |item| item['class'].match?('nav-item') })
  end

  test <<~TEXT do
    Default Card With Nav Tab nav items should all have anchor elements to tie
    them to their respective content panes
  TEXT
    assert(
      default_nav_items.all? do |item|
        item.at(".//a[contains(@class, 'nav-link')]").present?
      end
    )
  end

  test <<~TEXT do
    Default Card With Nav Tab nav items should all have the proper text
  TEXT
    count = 0

    assert(
      default_nav_items[0...-1].all? do |nav_item|
        nav_item.at(".//a[contains(@class, 'nav-link')]").text.match?("Item #{count += 1}")
      end
    )
  end

  test <<~TEXT do
    Default Card With Nav Tab nav items should all have links that conect them
    to the proper content pane
  TEXT
    skip
  end

  test 'Default Card With Nav Tab last item in nav, should be a dropdown' do
    assert(
      %w[nav-item dropdown].all? do |klass|
        default_nav_items.last['class'].match?(klass)
      end
    )
  end

  test 'Default Card With Nav Tab dropdown should have a toggle element' do
    toggle = default_nav_dropdown.at(".//*[contains(@class, 'dropdown-toggle')]")
    assert(toggle.present?)
  end

  test 'Default Card With Nav Tab dropdown should have a dropdown menu element' do
    assert(default_nav_dropdown_menu.present?)
  end

  test 'Default Card With Nav Tab dropdown menu should have two items' do
    assert(default_nav_dropdown_menu_items.count == 2)
  end

  test <<~TEXT do
    Default Card With Nav Tab dropdown menu items should all have anchors that point
    to the correct content pane
  TEXT
    skip
  end

  test 'Default Card With Nav Tab dropdown menu items should all have the correct text' do
    count = 5
    assert(
      default_nav_dropdown_menu_items.all? do |menu_item|
        menu_item.text.match?("Item #{count += 1}")
      end
    )
  end

  test 'Default Card With Nav Tab should have a card body component' do
    assert(default_body.present?)
  end

  test 'Default Card With Nav Tab should have a tab content component' do
    assert(default_content['class'].match?('tab-content'))
  end

  test 'Default Card With Nav Tab should have seven content panes' do
    assert(default_content_panes.count == 7)
  end

  test 'Default Card With Nav Tab content panes should have the correct text' do
    count = 0
    assert(
      default_content_panes.all? do |pane|
        pane.text.match?("Content for: Item #{count += 1}")
      end
    )
  end

  test 'Default Card With Nav Tab content pane should have the correct class .tab-pane' do
    assert(
      default_content_panes.all? { |pane| pane['class'].match?('tab-pane') }
    )
  end

  private

  # Get the card-header component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_header
    @default.at(".//div[contains(@class, 'card-header')]")
  end

  # Get the card header nav component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_nav
    default_header.at(".//ul[contains(@class, 'card-header-tabs')]")
  end

  # Get the nav item components.
  #
  # @return [Nokogiri::XML::NodeSet|NilClass]
  #
  def default_nav_items
    default_nav.search(".//li[contains(@class, 'nav-item')]")
  end

  # Get the nav dropdown item component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_nav_dropdown
    default_nav.at(".//li[contains(@class, 'nav-item') and contains(@class, 'dropdown')]")
  end

  # Get the nav dropdown menu component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_nav_dropdown_menu
    default_nav_dropdown.at(".//*[contains(@class, 'dropdown-menu')]")
  end

  # Get thee dropdown menu item components.
  #
  # @return [Nokogiri::XML::NodeSet|NilClass]
  #
  def default_nav_dropdown_menu_items
    default_nav_dropdown_menu.search(".//*[contains(@class, 'dropdown-item')]")
  end

  # Get the card-body component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_body
    @default.at(".//div[contains(@class, 'card-body')]")
  end

  # Get the tab-content component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_content
    default_body.at(".//div[contains(@class, 'tab-content')]")
  end

  # Get the content pane components.
  #
  # @return [Nokogiri::XML::NodeSet|NilClass]
  #
  def default_content_panes
    default_content.search(".//div[contains(@class, 'tab-pane')]")
  end
end
# rubocop:enable Metrics/ClassLength
