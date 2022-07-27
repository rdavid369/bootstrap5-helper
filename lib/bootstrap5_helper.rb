require 'bootstrap5_helper/version'
require 'bootstrap5_helper/railtie'
require 'bootstrap5_helper/constants'

Bootstrap5Helper::Constants::COMPONENTS.each do |component|
  require "bootstrap5_helper/#{component}"
end

require 'bootstrap5_helper/initialize'

# This is the module that will get included in your partials.
#
#
module Bootstrap5Helper
  # Creates a single Accordion element.  The header component
  # already provides the DOM element to link the Collapse area.
  # You just need to provide the text or additional markup, if
  # you want it.
  #
  # @example
  #   ```erb
  #    <%= accordion_helper do |a| %>
  #      <%= a.item do |item| %>
  #        <%= item.header do %>
  #          // Some HTML or Ruby
  #        <% end %>
  #        <%= item.body %>
  #          // Some HTML or Ruby
  #        <% end %>
  #      <% end %>
  #    <% end %>
  #   ```
  #
  # @param  [Hash] opts
  # @option opts [String]  :id
  # @option opts [String]  :class
  # @option opts [Hash]    :data
  # @option opts [Boolean] :always_open
  # @option opts [Boolean] :flush
  # @return [Accordion]
  #
  def accordion_helper(opts = {}, &block)
    Accordion.new(self, opts, &block)
  end

  # Creates an Alert component.
  #
  # @example
  #   ```erb
  #   <%= alert_helper :danger, dismissble: true do %>
  #     Something went wrong with your model data...
  #   <% end %>
  #   ```
  #
  # @overload alert_helper(context, opts)
  #   @param [Symbol|String] context - :primary, :danger etc
  #   @param [Hash] opts
  #   @option opts [String] :id
  #   @option opts [String] :class
  #   @option opts [Boolean] :dismissible
  #
  # @overload alert_helper(opts)
  #   @param [Hash] opts
  #   @option opts [String] :id
  #   @option opts [String] :class
  #   @option opts [Boolean] :dismissible
  #
  # @return [String]
  #
  def alert_helper(*args, &block)
    Alert.new(self, *args, &block)
  end

  # Creates a badge component.  Badges have a context variable.  Providing nothing
  # will give you the `secondary` context.
  #
  # @example
  #   ```erb
  #   <li>
  #    Messages: <%= badge_helper(:primary) { @messages.count } %>
  #   </li>
  #   <li>
  #     Notifications: <%= badge_healper { @notifications.count } %>
  #   </li>
  #   ```
  #
  # @overload badge_helper(context, opts)
  #   @param [Symbol|String] context - :primary, :danger etc
  #   @param [Hash] opts
  #   @option opts [String] :id
  #   @option opts [String] :class
  #   @option opts [Hash] : :data
  #
  # @overload badge_helper(opts)
  #   @param [Hash] opts
  #   @option opts [String] :id
  #   @option opts [String] :class
  #   @option opts [Hash] : :data
  #
  # @return [String]
  #
  def badge_helper(*args, &block)
    Badge.new(self, *args, &block)
  end

  # @todo
  #
  #
  def callout_helper(*args, &block)
    Callout.new(self, *args, &block)
  end

  # Creates a Card component.
  #
  #
  # @example Regular Card
  #   ```erb
  #   <%= card_helper do |c| %>
  #     <%= c.header class: 'text-white bg-primary' do %>
  #         <h4>This is the header...</h4>
  #     <% end %>
  #     <%= c.body do %>
  #         <%= c.title { 'This is the title' } %>
  #         <%= c.text { 'This card body' } %>
  #         <ul>
  #             <% [1, 2, 3].each do |x|  %>
  #                 <li>Item: <%= x %></li>
  #             <% end %>
  #         </ul>
  #     <% end %>
  #     <%= c.footer do %>
  #         This is the footer...
  #     <% end %>
  #   <% end %>
  #   ```
  #
  # @example Horizontal Card
  #   ```erb
  #   <%= card_helper do |c| %>
  #       <div class="row no-gutters">
  #           <div class="col-md-4">
  #               <%= image_tag 'placeholder.svg', class: 'card-img' %>
  #           </div>
  #           <div class="col-md-8">
  #               <%= c.body do %>
  #                   <%= c.title { "Card title" } %>
  #                   <%= c.text do
  #                     This is a wider card with supporting text below as a natural
  #                     lead-in to additional content.
  #                   <% end %>
  #                   <%= c.text do %>
  #                       <small class="text-muted">Last updated 3 mins ago</small>
  #                   <% end %>
  #              <% end %>
  #           </div>
  #       </div>
  #   <% end %>
  #   ```
  #
  # @param  [Hash] opts
  # @option opts [String] :id
  # @option opts [String] :class
  # @option opts [Hash]   :data
  # @return [String]
  #
  def card_helper(opts = {}, &block)
    Card.new(self, opts, &block)
  end

  # Generates a Dropdown component.  Default type `:dropdown`.
  #
  # @example Dropdown
  #   ```erb
  #    <%= dropdown_helper do |dropdown| %>
  #      <%= dropdown.button(:primary) { "Action" } %>
  #      <%= dropdown.menu do |menu| %>
  #          <%= menu.link 'Edit', '#' %>
  #          <%= menu.link 'Delete', '#' %>
  #          <%= menu.text 'Static text' %>
  #      <% end %>
  #    <% end %>
  #   ```
  #
  # @example Dropup
  #   ```erb
  #    <%= dropdown_helper :dropup do |dropdown| %>
  #      <%= dropdown.button(:primary) { "Action" } %>
  #      <%= dropdown.menu do |menu| %>
  #          <%= menu.link 'Edit', '#' %>
  #          <%= menu.link 'Delete', '#' %>
  #          <%= menu.text 'Static text' %>
  #      <% end %>
  #    <% end %>
  #   ```
  #
  # @example Dropdown w/ menu
  #   ```erb
  #   <%= dropdown_helper do |dropdown| %>
  #     <%= dropdown.button :primary do %>
  #         Login
  #     <% end %>
  #     <%= dropdown.menu do |menu| %>
  #         <form class="px-4 py-3">
  #             <div class="form-group">
  #                 <label for="exampleDropdownFormEmail1">Email address</label>
  #                 <input type="email" class="form-control" id="exampleDropdownFormEmail1" placeholder="email@example.com">
  #             </div>
  #             <div class="form-group">
  #                 <label for="exampleDropdownFormPassword1">Password</label>
  #                 <input type="password" class="form-control" id="exampleDropdownFormPassword1" placeholder="Password">
  #             </div>
  #             <div class="form-group">
  #                 <div class="form-check">
  #                     <input type="checkbox" class="form-check-input" id="dropdownCheck">
  #                     <label class="form-check-label" for="dropdownCheck">
  #                         Remember me
  #                     </label>
  #                 </div>
  #             </div>
  #             <button type="submit" class="btn btn-primary">Sign in</button>
  #         </form>
  #         <%= menu.divider %>
  #         <%= menu.link "New around here? Sign up", "#" %>
  #         <%= menu.link "Forgot password", "#" %>
  #     <% end %>
  #   <% end %>
  #   ```
  #
  # @example Dropdown::Menu in a Nav menu
  #   ```erb
  #   <%= nav.dropdown 'More' do |dropdown| %>
  #     <%= dropdown.item :item5 %>
  #     <%= dropdown.item(:item6) { 'Item 6' } %>
  #   <% end %>
  #   ```
  #
  # @overload dropdown_helper(type, opts)
  #   @param [Symbol|String] type - :dropdown, :dropup, :dropstart, :dropend
  #   @param [Hash] opts
  #   @option opts [String]  :id
  #   @option opts [String]  :class
  #   @option opts [Hash]    :data
  #   @option opts [Boolean] :split
  #
  # @overload dropdown(opts)
  #   @param [Hash] opts
  #   @option opts [String]  :id
  #   @option opts [String]  :class
  #   @option opts [Hash]    :data
  #   @option opts [Boolean] :split
  #
  # @return [String]
  #
  def dropdown_helper(*args, &block)
    Dropdown.new(self, *args, &block)
  end

  # Generates Modal windows.
  #
  # @example
  #   ```erb
  #    <%= modal_helper id: 'exampleModal' do |m| %>
  #      <%= m.header do %>
  #          <%= m.title { 'Example Modal' } %>
  #          <%= m.close_button %>
  #      <% end %>
  #      <%= m.body do %>
  #          Lorem ipsum dolor sit amet consectetur adipisicing elit. Vel nisi tempora, eius iste sit nobis
  #          earum in harum optio dolore explicabo. Eveniet reprehenderit harum itaque ad fuga beatae, quasi
  #          sequi! Laborum ea porro nihil ipsam repudiandae vel harum voluptates minima corrupti unde quas,
  #          dolore possimus doloribus voluptatem sint fuga dolores odio dignissimos at molestias earum.
  #      <% end %>
  #      <%= m.footer do %>
  #          <%= m.close_button class: 'btn btn-secondary' do %>
  #              Close
  #          <% end %>
  #      <% end %>
  #    <% end %>
  #   ```
  #
  # @param  [Hash] opts
  # @option opts [String]  :id
  # @option opts [String]  :class
  # @option opts [Hash]    :data
  # @option opts [Boolean] :scrollable
  # @option opts [Boolean] :vcentered
  # @option opts [Boolean] :static
  # @option opts [Boolean|Symbol] :fullscreen - true, :sm, :lg, :xl etc
  # @option opts [Symbol]  :size - :sm, :md, :lg etc
  # @return [String]
  #
  def modal_helper(opts = {}, &block)
    Modal.new(self, opts, &block)
  end

  # Generates Nav components.
  #
  # @example
  #   ```erb
  #    <%= nav_helper do |nav| %>
  #      <%= nav.link "Item 1", "https://www.google.com" %>
  #      <%= nav.link "Item 2", "#" %>
  #      <%= nav.link "Item 3", "#" %>
  #      <%= nav.dropdown :more do |menu| %>
  #          <%= menu.link 'People', '#' %>
  #          <%= menu.link 'Records', '#' %>
  #      <% end %>
  #
  #      <%= nav.dropdown "More 2" do |menu| %>
  #          <%= menu.link 'People', '#' %>
  #          <%= menu.link 'Records', '#' %>
  #      <% end %>
  #    <% end %>
  #   ```
  #
  # @overload nav_helper(tag, opts)
  #   @param [Symbol|String] tag - :nav, :ul
  #   @param [Hash] opts
  #   @option opts [String]  :id
  #   @option opts [String]  :class
  #   @option opts [Hash]    :data
  #   @option opts [Hash]    :child - data attributes for child, NOT wrapper
  #
  # @overload nav_helper(opts)
  #   @param [Hash] opts
  #   @option opts [String]  :id
  #   @option opts [String]  :class
  #   @option opts [Hash]    :data
  #   @option opts [Hash]    :child - data attributes for child, NOT wrapper
  #
  # @return [String]
  #
  def nav_helper(*args, &block)
    Nav.new(self, *args, &block)
  end

  # Generates a Offcanvas component.
  #
  # @example:
  #   ```erb
  #   <%= offcanvas_helper :top, id: 'off_canvas_example1' do |off| %>
  #     <%= off.button 'Open sidebar', class: 'btn btn-primary' %>
  #     <%= off.content do |c| %>
  #         <%= c.header do %>
  #             <%= c.title { 'Sidebar content' } %>
  #             <%= c.close_button %>
  #         <% end %>
  #         <%= c.body do %>
  #             <p>Some content in the sidebar!</p>
  #         <% end %>
  #     <% end %>
  #   <% end %>
  #   ```
  #
  # @example:
  #   ```erb
  #   <%= offcanvas_helper scrollable: true, id: 'off_canvas_example2' do |off| %>
  #     <%= off.link class: 'btn btn-danger' do %>
  #         <strong>*</strong> Open sidebar 2
  #     <% end %>
  #
  #     <%= off.content do |c| %>
  #         <%= c.header do %>
  #             <%= c.title { 'Sidebar content 2' } %>
  #             <%= c.close_button class: 'btn btn-info' do %>
  #                 Close
  #             <% end %>
  #         <% end %>
  #         <%= c.body do %>
  #             <p>Some content in the sidebar 2!</p>
  #         <% end %>
  #     <% end %>
  #   <% end %>
  #   ```
  #
  # @overload offcanvas_helper(position, options)
  #   @param  [Symbol] position - :start, :end, :top, :bottom
  #   @param  [Hash] opts
  #   @option opts [String]  :id
  #   @option opts [String]  :class
  #   @option opts [Hash]    :data
  #   @option opts [Hash]    :aria
  #   @option opts [Boolean] :scrollable
  #   @option opts [Boolean|String] :backdrop - true, false, 'static'
  #
  # @overload offcanvas_helper(options)
  #   @param  [Hash] opts
  #   @option opts [String]  :id
  #   @option opts [String]  :class
  #   @option opts [Hash]    :data
  #   @option opts [Hash]    :aria
  #   @option opts [Boolean] :scrollable
  #   @option opts [Boolean|String] :backdrop - true, false, 'static'
  #
  # @return [String]
  #
  def offcanvas_helper(*args, &block)
    Offcanvas.new(self, *args, &block)
  end

  # Generates a page header, similiar to bootstrap 3
  #
  # @example
  #   ```erb
  #   <%= page_header_helper class: 'mt-5' do %>
  #     Test Application
  #   <% end %>
  #   ```
  #
  # @overload page_header_helper(tag, opts)
  #   @param [Symbol|String] tag
  #   @param [Hash] opts
  #   @option opts [String]  :id
  #   @option opts [String]  :class
  #   @option opts [Hash]    :data
  #
  # @overload page_header_helper(opts)
  #   @param [Hash] opts
  #   @option opts [String]  :id
  #   @option opts [String]  :class
  #   @option opts [Hash]    :data
  #
  # @return [String]
  #
  def page_header_helper(*args, &block)
    PageHeader.new(self, *args, &block)
  end

  # Generates a input group component.
  #
  # @example
  #   ```erb
  #    <%= input_group_helper do |ig| %>
  #      <%= ig.text do %>
  #        <i class="fas fa-at"></i>
  #      <% end %>
  #      <input type="text" value="" name="email" placeholder="Email" class="form-control" />
  #    <% end %>
  #   ```
  #
  # @example Large input group
  #   ```erb
  #    <%= input_group_helper :lg do |ig| %>
  #      <input type="text" value="" name="email" placeholder="Email" class="form-control" />
  #      <%= ig.text { "@" } %>
  #    <% end %>
  #   ```
  #
  # @overload input_group_helper(context, options)
  #   @param [Symbol|String] context - :sm, :lg
  #   @param [Hash] opts
  #   @option opts [String] :id
  #   @option opts [String] :class
  #   @option opts [Hash]   :data
  #
  # @overload input_group_helper(opts)
  #   @param [Hash] opts
  #   @option opts [String] :id
  #   @option opts [String] :class
  #   @option opts [Hash]   :data
  #
  # @return [String]
  #
  def input_group_helper(*args, &block)
    InputGroup.new(self, *args, &block)
  end

  # Generates a Tab component.
  #
  # @example
  #   ```erb
  #    <%= tab_helper do |tab| %>
  #      <%= tab.nav do |nav| %>
  #          <%= nav.item :item1 do %>
  #              Item 1
  #          <% end %>
  #          <%= nav.item(:item2, class: 'active') { "Item 2" } %>
  #          <%= nav.item(:item3) { "Item 3" } %>
  #          <%= nav.item :item4 %>
  #          <%= nav.dropdown 'More' do |dropdown| %>
  #              <%= dropdown.item :item5 %>
  #              <%= dropdown.item(:item6) { 'Item 6' } %>
  #          <% end %>
  #      <% end %>
  #
  #      <%= tab.content do |content| %>
  #          <%= content.pane :item1, class: 'mt-3' do %>
  #              Content 1
  #          <% end %>
  #
  #          <%= content.pane :item2, class: 'active mt-3' do %>
  #              Content 2
  #          <% end %>
  #
  #          <%= content.pane :item3, class: 'mt-3' do %>
  #              Content 3
  #          <% end %>
  #
  #          <%= content.pane :item4, class: 'mt-3' do %>
  #              Content 4
  #          <% end %>
  #
  #          <%= content.pane :item5, class: 'mt-3' do %>
  #              Content 5
  #          <% end %>
  #
  #          <%= content.pane :item6, class: 'mt-3' do %>
  #              Content 6
  #          <% end %>
  #      <% end %>
  #    <% end %>
  #   ```
  #
  # @param  [Hash] opts
  # @option opts [Symbol]  :type - :tabs, :pills
  # @option opts [String]  :id
  # @option opts [String]  :class
  # @option opts [Hash]    :data
  # @return [String]
  #
  def tab_helper(opts = {}, &block)
    Tab.new(self, opts, &block)
  end

  # Generates spinner annimations.
  #
  # @example
  #   ```erb
  #    <%= spinner_helper class: 'text-warning' %>
  #    <%= spinner_helper type: :grow, class: 'text-danger', id: 'loadingRecords' %>
  #   ```
  #
  # @param  [Hash] args
  # @option opts [Symbol]  :type - :border, :grow
  # @option opts [String]  :id
  # @option opts [String]  :class
  # @option opts [Hash]    :data
  # @return [String]
  #
  def spinner_helper(opts = {}, &block)
    Spinner.new(self, opts, &block)
  end
end
