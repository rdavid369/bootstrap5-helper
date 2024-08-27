require "test_helper"

# rubocop:disable Metrics/ClassLength
class DropupTest < ActionView::TestCase
  DEFAULT  = "Default Dropup".freeze
  CUSTOM   = "Custom Dropup".freeze
  BINDINGS = "Binding Dropup".freeze

  setup do
    render "components/dropups", name: "Todo", min: 1, max: 5

    @root      = document_root_element.at("//div[contains(@id, 'root')]")
    @default   = @root.at(".//div[contains(@id,  'default')]")
                      .at(".//*[contains(@class, 'dropup')]")
    @custom    = @root.at(".//div[contains(@id,  'custom')]")
                      .at(".//*[contains(@class, 'dropup')]")
    @bindings  = @root.at(".//div[contains(@id,  'bindings')]")
                      .at(".//*[contains(@class, 'dropup')]")
  end

  test "#{DEFAULT} root element should be a div" do
    assert(@default.name == 'div')
  end

  test "#{DEFAULT} should have the dropup class" do
    assert(@default['class'].match?('dropup'))
  end

  test "#{DEFAULT} should have a random id attribute" do
    assert(@default['id'].present?)
  end

  test "#{DEFAULT} should have a dropdown toggle" do
    assert(default_toggle.present?)
  end

  test "#{DEFAULT} dropdown toggle should be a button" do
    assert(default_toggle.name == 'button')
  end

  test "#{DEFAULT} dropdown toggle should have the correct data attributes" do
    assert(
      %i[toggle display].all? { |attr| default_toggle["data-bs-#{attr}"].present? }
    )
  end

  test "#{DEFAULT} dropdown toggle should have the correct text" do
    default_toggle.text == 'Action'
  end

  test "#{DEFAULT} should have a dropdown menu" do
    assert(default_menu.present?)
  end

  test "#{DEFAULT} dropdown menu should have a random id attribute" do
    assert(default_menu['id'].present?)
  end

  test "#{DEFAULT} dropdown menu should have three items" do
    assert(default_menu_items.count == 3)
  end

  test "#{DEFAULT} dropdown menu should have 2 anchor elements" do
    assert(
      [default_menu_items[0], default_menu_items[1]].all? do |element|
        element.name == 'a'
      end
    )
  end

  test "#{DEFAULT} dropdown menu should have 1 static text element" do
    assert(default_menu_items.last['class'].match?('dropdown-item-text'))
  end

  test "#{CUSTOM} root element should be a span" do
    assert(@custom.name == 'span')
  end

  test "#{CUSTOM} should have the following classes .dropdown and .custom-dropdown" do
    assert(
      ['dropdown', 'custom-dropdown'].all? do |klass|
        @custom['class'].match?(klass)
      end
    )
  end

  test "#{CUSTOM} should have the correct id attribute" do
    assert(@custom['id'] == 'custom_dropdown')
  end

  test "#{CUSTOM} should have the correct data attributes" do
    assert(@custom['data-name'] == 'CustomDropdown')
  end

  test "#{CUSTOM} should have a dropdown toggle" do
    assert(custom_toggle.present?)
  end

  test <<~TEXT do
    #{CUSTOM} dropdown toggle should have the correct classes
    .dropdown-toggle .custom-button
  TEXT
    assert(
      ['dropdown-toggle', 'custom-button'].all? do |klass|
        custom_toggle['class'].match?(klass)
      end
    )
  end

  test "#{CUSTOM} dropdown toggle should have the correct id attribute" do
    assert(custom_toggle['id'] == 'custom_button')
  end

  test <<~TEXT do
    #{CUSTOM} dropdown toggle should have the correct data attributes
    data-name data-bs-toggle data-bs-display
  TEXT
    assert(
      ['data-name','data-bs-toggle','data-bs-display'].all? do |attr|
        custom_toggle[attr].present?
      end
    )
  end

  test "#{CUSTOM} should have a dropdown menu" do
    assert(custom_menu.present?)
  end

  test "#{CUSTOM} dropdown menu should have the correct id attribute" do
    assert(custom_menu['id'] == 'custom_menu')
  end

  test <<~TEXT do
    #{CUSTOM} dropdown menu should have the correct classes .dropdown-menu .custom-menu
  TEXT
    assert(
      ['dropdown-menu', 'custom-menu'].all? do |klass|
        custom_menu['class'].match?(klass)
      end
    )
  end

  test <<~TEXT do
    #{CUSTOM} dropdown menu should have the correct data attribute data-name
  TEXT
    assert(custom_menu['data-name'] == 'CustomMenu')
  end

  test "#{CUSTOM} dropdown menu should have three menu items" do
    assert(custom_menu_items.count == 3)
  end

  test "#{CUSTOM} dropdown menu should have a divider element" do
    assert(custom_menu.at(".//*[contains(@class, 'dropdown-divider')]").present?)
  end

  test <<~TEXT do
    #{CUSTOM} dropdown menu item should have a edit link with the classes
    .dropdown-item .custom-edit-link
  TEXT
    assert(custom_menu_items_edit_link.present?)
  end

  test <<~TEXT do
    #{CUSTOM} dropdown menu item should have a edit link with the correct
    data attribute
  TEXT
    assert(
      custom_menu_items_edit_link&.send('[]', 'data-name')&.match?('CustomEditLink')
    )
  end

  test "#{CUSTOM} dropdown menu should have a custom paragraph element" do
    ptag = custom_menu.at(".//p")
    assert(ptag.present? && ptag.text.match?('Some custom content'))
  end

  test "#{BINDINGS} root element should be a div" do
    assert(@bindings.name == 'div')
  end

  test "#{BINDINGS} should have a caret toggle button" do
    assert(bindings_toggle.present?)
  end

  test "#{BINDINGS} caret element should have the correct classes" do
    assert(
      ['dropdown-toggle', 'dropdown-toggle-split'].all? do |klass|
        bindings_toggle['class'].match?(klass)
      end
    )
  end

  test "#{BINDINGS} should have a dropdown menu" do
    assert(bindings_menu.present?)
  end

  test "#{BINDINGS} dropdown menu should have five items" do
    assert(bindings_menu_items.count == 5)
  end

  test "#{BINDINGS} dropdown menu items should all have the correct text" do
    count = 0
    assert(
      bindings_menu_items.all? do |item|
        item.text.match?("Todo Dropdown Link #{count += 1}")
      end
    )
  end

  private

  # Get the toggle component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_toggle
    @default.at(".//*[contains(@class, 'dropdown-toggle')]")
  end

  # Get the menu component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_menu
    @default.at(".//*[contains(@class, 'dropdown-menu')]")
  end

  # Get thee dropdown menu item components.
  #
  # @return [Nokogiri::XML::NodeSet|NilClass]
  #
  def default_menu_items
    default_menu.search(".//*[contains(@class, 'dropdown-item')]")
  end

  # Get the toggle component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_toggle
    @custom.at(".//*[contains(@class, 'dropdown-toggle')]")
  end

  # Get the menu component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_menu
    @custom.at(".//*[contains(@class, 'dropdown-menu')]")
  end

  # Get thee dropdown menu item components.
  #
  # @return [Nokogiri::XML::NodeSet|NilClass]
  #
  def custom_menu_items
    custom_menu.search(".//*[contains(@class, 'dropdown-item')]")
  end

  # Get the menu edit link component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_menu_items_edit_link
    custom_menu.at(
      ".//*[contains(@class, 'dropdown-item') and contains(@class, 'custom-edit-link')]"
    )
  end

  # Get the toggle component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def bindings_toggle
    @bindings.at(".//*[contains(@class, 'dropdown-toggle')]")
  end

  # Get the menu component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def bindings_menu
    @bindings.at(".//*[contains(@class, 'dropdown-menu')]")
  end

  # Get thee dropdown menu item components.
  #
  # @return [Nokogiri::XML::NodeSet|NilClass]
  #
  def bindings_menu_items
    bindings_menu.search(".//*[contains(@class, 'dropdown-item')]")
  end
end
