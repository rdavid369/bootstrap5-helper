require "test_helper"

# rubocop:disable Metrics/ClassLength
class CardWithNavTabTest < ActionView::TestCase
  DEFAULT  = "Default Card With Nav Tab".freeze
  CUSTOM   = "Custom Card With Nav Tab".freeze
  BINDINGS = "Binding Card With Nav Tab".freeze

  setup do
    render "components/card_with_nav_tab", name: "Todo", min: 1, max: 5

    @root      = document_root_element.at("//div[contains(@id, 'root')]")
    @default   = @root.at(".//div[contains(@id,    'default')]")
                      .at(".//div[contains(@class, 'card')]")
    @custom    = @root.at(".//div[contains(@id,    'custom')]")
                      .at(".//div[contains(@class, 'card')]")
    @bindings  = @root.at(".//div[contains(@id,    'bindings')]")
                      .at(".//div[contains(@class, 'card')]")
  end

  test <<~TEXT do
    #{DEFAULT} base element should have the following classes
    .card .with-nav-tabs-secondary
  TEXT
    assert(
      %w[card with-nav-tabs-secondary].all? do |klass|
        @default["class"].match?(klass)
      end
    )
  end

  test <<~TEXT do
    #{DEFAULT} should have a header element wrapping the nav
    component with the class .card-header
  TEXT
    assert(default_header["class"].match?("card-header"))
  end

  test "#{DEFAULT} nav should be a ul element" do
    assert(default_nav.name == "ul")
  end

  test "#{DEFAULT} nav items should be a li element" do
    assert(default_nav_items.first.name == "li")
  end

  test "Default Card With Nav Tab should have six nav items" do
    assert(default_nav_items.count == 6)
  end

  test "#{DEFAULT} nav items should have correct class .nav-item" do
    assert(default_nav_items.all? { |item| item["class"].match?("nav-item") })
  end

  test <<~TEXT do
    #{DEFAULT} nav items should all have anchor elements to tie
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
    #{DEFAULT} nav items should all have links that conect them
    to the proper content pane
  TEXT
    skip
  end

  test "#{DEFAULT} last item in nav, should be a dropdown" do
    assert(
      %w[nav-item dropdown].all? do |klass|
        default_nav_items.last["class"].match?(klass)
      end
    )
  end

  test "#{DEFAULT} dropdown should have a toggle element" do
    toggle = default_nav_dropdown.at(".//*[contains(@class, 'dropdown-toggle')]")
    assert(toggle.present?)
  end

  test "#{DEFAULT} dropdown should have a dropdown menu element" do
    assert(default_nav_dropdown_menu.present?)
  end

  test "#{DEFAULT} dropdown menu should have two items" do
    assert(default_nav_dropdown_menu_items.count == 2)
  end

  test <<~TEXT do
    #{DEFAULT} dropdown menu items should all have anchors that point
    to the correct content pane
  TEXT
    skip
  end

  test "#{DEFAULT} dropdown menu items should all have the correct text" do
    count = 5
    assert(
      default_nav_dropdown_menu_items.all? do |menu_item|
        menu_item.text.match?("Item #{count += 1}")
      end
    )
  end

  test "#{DEFAULT} should have a card body component" do
    assert(default_body.present?)
  end

  test "#{DEFAULT} should have a tab content component" do
    assert(default_content["class"].match?("tab-content"))
  end

  test "#{DEFAULT} should have seven content panes" do
    assert(default_content_panes.count == 7)
  end

  test "#{DEFAULT} content panes should have the correct text" do
    count = 0
    assert(
      default_content_panes.all? do |pane|
        pane.text.match?("Content for: Item #{count += 1}")
      end
    )
  end

  test "#{DEFAULT} content pane should have the correct class .tab-pane" do
    assert(
      default_content_panes.all? { |pane| pane["class"].match?("tab-pane") }
    )
  end

  test <<~TEXT do
    #{CUSTOM} base element should have the following classes .card
    .with-nav-tabs-primnary .custom-card-with-nav
  TEXT
    assert(
      %w[card with-nav-tabs-primary custom-card-with-nav].all? do |klass|
        @custom["class"].match?(klass)
      end
    )
  end

  test "#{CUSTOM} base element should have the correct id attribute" do
    assert(@custom["id"].match?("custom_card_with_nav"))
  end

  test "#{CUSTOM} base element should have the correct data attribute" do
    assert(@custom["data-name"].match?("CustomCardWithNav"))
  end

  test "#{CUSTOM} nav should be a nav element" do
    assert(custom_nav.name == "nav")
  end

  test <<~TEXT do
    #{CUSTOM} nav should have the following classes .nav .nav-tabs
    .card-header-tabs .custom-nav
  TEXT
    assert(
      %w[nav nav-tabs card-header-tabs custom-nav].all? do |klass|
        custom_nav["class"].match?(klass)
      end
    )
  end

  test "#{CUSTOM} nav should have the correct id attribute" do
    assert(custom_nav["id"].match?("custom_nav"))
  end

  test "#{CUSTOM} nav should have the correct data attribute" do
    assert(custom_nav["data-name"].match?("CustomNav"))
  end

  test "#{CUSTOM} nav should have 3 items" do
    assert(custom_nav_items.count == 3)
  end

  test "#{CUSTOM} first nav item text should not match href attribute" do
    item = custom_nav_items.first
    refute(item['href'].gsub('#', '').titleize.match?(item.text.titleize))
  end

  test "#{CUSTOM} first nav item should have the correct text" do
    item = custom_nav_items.first
    assert(item.text.match?('Custom Item 1 different than link.'))
  end

  test "#{CUSTOM} nav items should be a anchor element" do
    assert(custom_nav_items.first.name == "a")
  end

  test "#{CUSTOM} nav should have a dropdown menu" do
    assert(custom_nav_dropdown_menu.present?)
  end

  test "#{CUSTOM} dropdown menu items should all have the correct text" do
    count = 2
    assert(
      custom_nav_dropdown_menu_items.all? do |menu_item|
        menu_item.text.match?("Custom Item #{count += 1}")
      end
    )
  end

  test "#{CUSTOM} should have a card body component" do
    assert(custom_body.present?)
  end

  test "#{CUSTOM} should have a tab content component" do
    assert(custom_content["class"].match?("tab-content"))
  end

  test "#{CUSTOM} should have seven content panes" do
    assert(custom_content_panes.count == 4)
  end

  test "#{CUSTOM} content panes should have the correct text" do
    count = 0
    assert(
      custom_content_panes.all? do |pane|
        pane.text.match?("Content for: Item #{count += 1}")
      end
    )
  end

  test "#{CUSTOM} content pane should have the correct classes .tab-pane .custom-item-%-content" do
    count = 0
    assert(
      custom_content_panes.all? do |pane|
        ['tab-pane', "custom-item-#{count += 1}"].all? do |klass|
          pane["class"].match?(klass)
        end
      end
    )
  end

  test "#{CUSTOM} content pane should have the correct id attribute" do
    count = 0
    assert(
      custom_content_panes.all? do |pane|
        pane['id'].match?("custom_item_#{count += 1}_content")
      end
    )
  end

  test "#{CUSTOM} content pane should have the correct data attribute" do
    count = 0
    assert(
      custom_content_panes.all? do |pane|
        pane['data-name'].match?("CustomItem#{count += 1}Content")
      end
    )
  end

  test "#{BINDINGS} nav should have five nav items" do
    assert(bindings_nav_items.count == 5)
  end

  test "#{BINDINGS} nav items should have the correct text" do
    count = 0
    assert(
      bindings_nav_items.all? do |item|
        item.text.match?("Todo #{count += 1}")
      end
    )
  end

  test "#{BINDINGS} content should have five content panes" do
    assert(bindings_content_panes.count == 5)
  end

  test "#{BINDINGS} content panes should have the correct text" do
    count = 0
    assert(
      bindings_content_panes.all? do |item|
        item.text.match?("Todo Item: #{count += 1}")
      end
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
    default_header.at(".//*[contains(@class, 'card-header-tabs')]")
  end

  # Get the nav item components.
  #
  # @return [Nokogiri::XML::NodeSet|NilClass]
  #
  def default_nav_items
    default_nav.search(".//*[contains(@class, 'nav-item')]")
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

  # Get the card-header component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_header
    @custom.at(".//div[contains(@class, 'card-header')]")
  end

  # Get the card header nav component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_nav
    custom_header.at(".//*[contains(@class, 'card-header-tabs')]")
  end

  # Get the nav item components.
  #
  # @return [Nokogiri::XML::NodeSet|NilClass]
  #
  def custom_nav_items
    custom_nav.search(".//*[contains(@class, 'nav-link')]")
  end

  # Get the nav dropdown item component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_nav_dropdown
    custom_nav.at(".//li[contains(@class, 'nav-link') and contains(@class, 'dropdown-toggle')]")
  end

  # Get the nav dropdown menu component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_nav_dropdown_menu
    custom_nav.at(".//*[contains(@class, 'dropdown-menu')]")
  end

  # Get thee dropdown menu item components.
  #
  # @return [Nokogiri::XML::NodeSet|NilClass]
  #
  def custom_nav_dropdown_menu_items
    custom_nav_dropdown_menu.search(".//*[contains(@class, 'dropdown-item')]")
  end

  # Get the card-body component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_body
    @custom.at(".//div[contains(@class, 'card-body')]")
  end

  # Get the tab-content component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_content
    custom_body.at(".//div[contains(@class, 'tab-content')]")
  end

  # Get the content pane components.
  #
  # @return [Nokogiri::XML::NodeSet|NilClass]
  #
  def custom_content_panes
    custom_content.search(".//div[contains(@class, 'tab-pane')]")
  end

  # Get the card-header component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def bindings_header
    @bindings.at(".//div[contains(@class, 'card-header')]")
  end

  # Get the card header nav component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def bindings_nav
    bindings_header.at(".//*[contains(@class, 'card-header-tabs')]")
  end

  # Get the nav item components.
  #
  # @return [Nokogiri::XML::NodeSet|NilClass]
  #
  def bindings_nav_items
    bindings_nav.search(".//*[contains(@class, 'nav-item')]")
  end

  # Get the card-body component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def bindings_body
    @bindings.at(".//div[contains(@class, 'card-body')]")
  end

  # Get the tab-content component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def bindings_content
    bindings_body.at(".//div[contains(@class, 'tab-content')]")
  end

  # Get the content pane components.
  #
  # @return [Nokogiri::XML::NodeSet|NilClass]
  #
  def bindings_content_panes
    bindings_content.search(".//div[contains(@class, 'tab-pane')]")
  end
end
# rubocop:enable Metrics/ClassLength
