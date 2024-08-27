require 'test_helper'

class ModalTest < ActionView::TestCase
  DEFAULT  = 'Default Modal'.freeze
  CUSTOM   = 'Custom Modal'.freeze
  BINDINGS = 'Binding Modal'.freeze

  setup do
    render 'components/modals', name: 'Todo', min: 1, max: 5

    @root     = document_root_element.at("//div[contains(@id, 'root')]")
    @default  = @root.at(".//div[contains(@id, 'default')]")
                     .at(".//*[contains(@class, 'modal')]")
    @custom   = @root.at(".//div[contains(@id, 'custom')]")
                     .at(".//*[contains(@class, 'modal')]")
    @bindings = @root.at(".//div[contains(@id, 'bindings')]")
                     .at(".//*[contains(@class, 'modal')]")
  end

  test "#{DEFAULT} root element should be a div" do
    assert(@default.name == 'div')
  end

  test "#{DEFAULT} should have a random id attribute" do
    assert(@default['id'].present?)
  end

  test "#{DEFAULT} should have a dialog component" do
    assert(default_dialog.present?)
  end

  test "#{DEFAULT} should have a content component" do
    assert(default_content.present?)
  end

  test "#{DEFAULT} should have a header component" do
    assert(default_header.present?)
  end

  test "#{DEFAULT} header component should be a div element" do
    assert(default_header.name == 'div')
  end

  test "#{DEFAULT} header component should have a close" do
    assert(default_header_close_btn.present?)
  end

  test "#{DEFAULT} close button should have the correct data attributes" do
    assert(default_header_close_btn['data-bs-dismiss'] == 'modal')
  end

  test "#{DEFAULT} header component should have a title element" do
    assert(default_header_title.present?)
  end

  test "#{DEFAULT} header title should be a h5 element" do
    assert(default_header_title.name == 'h5')
  end

  test "#{DEFAULT} header title should have the correct text" do
    assert(default_header_title.text.match?('Example Modal'))
  end

  test "#{DEFAULT} should have body component" do
    assert(default_body.present?)
  end

  test "#{DEFAULT} body should have the correct content" do
    p = default_body.at('p')
    assert(p.present? && p.text.match?('Modal content goes here.'))
  end

  test "#{DEFAULT} should have a footer element" do
    assert(default_footer.present?)
  end

  test "#{DEFAULT} footer should have a close button" do
    btn = default_footer.at('.//button')
    assert(btn['data-bs-dismiss'] == 'modal')
  end

  # Start testing custom modal

  private

  # Get the dialog component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_dialog
    @default.at(".//div[contains(@class, 'modal-dialog')]")
  end

  # Get the content component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_content
    default_dialog.at(".//div[contains(@class, 'modal-content')]")
  end

  # Get the header component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_header
    default_content.at(".//*[contains(@class, 'modal-header')]")
  end

  # Get the body component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_body
    default_content.at(".//*[contains(@class, 'modal-body')]")
  end

  # Get the footer component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_footer
    default_content.at(".//*[contains(@class, 'modal-footer')]")
  end

  # Get the header title component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_header_title
    default_header.at(".//*[contains(@class, 'modal-title')]")
  end

  # Get the header close button.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def default_header_close_btn
    default_header.at(".//*[contains(@class, 'btn-close')]")
  end

  # Get the dialog component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_dialog
    @custom.at(".//div[contains(@class, 'modal-dialog')]")
  end

  # Get the content component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_content
    custom_dialog.at(".//div[contains(@class, 'modal-content')]")
  end

  # Get the header component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_header
    custom_content.at(".//*[contains(@class, 'modal-header')]")
  end

  # Get the body component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_body
    custom_content.at(".//*[contains(@class, 'modal-body')]")
  end

  # Get the footer component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_footer
    custom_content.at(".//*[contains(@class, 'modal-footer')]")
  end

  # Get the header title component.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_header_title
    custom_header.at(".//*[contains(@class, 'modal-title')]")
  end

  # Get the header close button.
  #
  # @return [Nokogiri::XML::Element|NilClass]
  #
  def custom_header_close_btn
    custom_header.at(".//*[contains(@class, 'btn-close')]")
  end
end
