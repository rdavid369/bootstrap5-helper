# Bootstrap5Helper

Short description and motivation.

## Usage

How to use my plugin.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "bootstrap5_helper"
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install bootstrap5_helper
```

## Usage

All of the helpers will be available inside your views. If you wish to stop that behavior and only include the helpers on the views of your choosing, pass the following to the `config` object in a intializer:

<em>config/initializers/bootstrap5-helper.rb</em>

```ruby
Bootstrap5Helper.config do |config|
  config.autoload_in_views = false
end
```

> Note: Almost all the helpers and their child components support attributes for `id`, `class`, `data` and `aria` HTML attributes.

### Accordion(s):

```erb
<%= accordion_helper id: 'custom_id' do |a| %>
    <%= a.item expanded: true do |item| %>
        <%= item.header do %>
            // html or ruby here
        <% end %>
        <%= item.body do %>
            // html or ruby here
        <% end %>
    <% end %>
    <%= a.item do |item| %>
        <%= item.header do %>
            // html or ruby here
        <% end %>
        <%= item.body do %>
            // html or ruby here
        <% end %>
    <% end %>
<% end %>
```

### Alerts

Alerts use the context helper, where you can pass the context of the object and it will render the appropriate colors.

```erb
<%= alert_helper :danger, dismissble: true do %>
    Something went wrong with your model data...
<% end %>
```

### Badges

The badge helper will build badges realitively quickly. If you are just passing a String, use the shorter curly brace block syntax. If you plan on building other HTML elements or using other Ruby proceedures, use the do/end method.

```erb
<li>
   Messages: <%= badge_helper(:primary) { @messages.count } %>
</li>
<li>
   Notifications: <%= badge_healper { @notifications.count } %>
</li>
<li>
    Users: <%= badge_helper :danger do %> Some HTML / Ruby <% end %>
</li>
```

### Cards

Cards support a few methods that make building them easier:

- `body`
- `header`
- `footer`
- `image_overlay`
- `image`
- `image_cap`
- `text`
- `title`

For usage on various card sub components, @see https://getbootstrap.com/docs/4.0/components/card/

```erb
<%# Regular %>

<%= card_helper do |c| %>
    <%= c.header class: 'text-white bg-primary' do %>
        <h4>This is the header...</h4>
    <% end %>
    <%= c.body do %>
        <%= c.title { 'This is the title' } %>
        <%= c.text { 'This card body' } %>
        <ul>
            <% [1, 2, 3].each do |x|  %>
                <li>Item: <%= x %></li>
            <% end %>
        </ul>
    <% end %>
    <%= c.footer do %>
        This is the footer...
    <% end %>
<% end %>

<%# Horizontal %>

<div class="row">
    <div class="col-sm mt-3 mb-3">
        <%= card_helper do |c| %>
            <div class="row no-gutters">
                <div class="col-md-4">
                    <%= image_tag 'placeholder.svg', class: 'card-img' %>
                </div>
                <div class="col-md-8">
                    <%= c.body do %>
                        <%= c.title { "Card title" } %>
                        <%= c.text { "This is a wider card with supporting text below as a natural lead-in to additional content." } %>
                        <%= c.text do %>
                            <small class="text-muted">Last updated 3 mins ago</small>
                        <% end %>
                    <% end %>
                </div>
            </div>
        <% end %>
    </div>
</div>
```

### Dropdowns

Generates a Dropdown component. Default type `:dropdown`. Supports `:dropdown` `:dropup` `:dropstart` `:dropend`

Dropdowns support the following methods:

- `button`
- `menu`
  - `item` - Use this method when you are using the item in the menu as a trigger for tab content.
  - `link` - Use this method when the item in the menu is nothing more than a hyperlink.
  - `text` - simple text
  - `header` - Is a header item
  - `divider` - A dividing element

```erb
<%= dropdown_helper do |dropdown| %>
    <%= dropdown.button(:primary) { "Action" } %>
    <%= dropdown.menu do |menu| %>
        <%= menu.link 'Edit', '#' %>
        <%= menu.link 'Delete', '#' %>
        <%= menu.text 'Static text' %>
    <% end %>
<% end %>

<%= dropdown_helper :group, class: 'dropright' do |dropdown| %>
    <button type="button" class="btn btn-danger">Action 2</button>
    <%= dropdown.button(:danger, split: true) %>
    <%= dropdown.menu do |menu| %>
        <%= menu.header "Crud operations" %>
        <%= menu.divider %>
        <%= menu.link 'Edit', 'SOME-URL' %>
        <%= menu.link 'Delete', 'SOME-URL' %>
    <% end %>
<% end %>

<%= dropdown_helper do |dropdown| %>
    <%= dropdown.button :primary do %>
        <i class="fas fa-users"></i> User
    <% end %>
    <%= dropdown.menu do |menu| %>
        <form class="px-4 py-3">
            <div class="form-group">
                <label for="exampleDropdownFormEmail1">Email address</label>
                <input type="email" class="form-control" id="exampleDropdownFormEmail1" placeholder="email@example.com">
            </div>
            <div class="form-group">
                <label for="exampleDropdownFormPassword1">Password</label>
                <input type="password" class="form-control" id="exampleDropdownFormPassword1" placeholder="Password">
            </div>
            <div class="form-group">
                <div class="form-check">
                    <input type="checkbox" class="form-check-input" id="dropdownCheck">
                    <label class="form-check-label" for="dropdownCheck">
                        Remember me
                    </label>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Sign in</button>
        </form>
        <%= menu.divider %>
        <%= menu.link "New around here? Sign up", "#" %>
        <%= menu.link "Forgot password", "#" %>
    <% end %>
<% end %>
```

### Modals

Builds a modal window.

> Note: When the `close_button` is not passed a block, it will default to the X icon.

```erb
<%= modal_helper id: 'exampleModal' do |m| %>
    <%= m.header do %>
        <%= m.title { 'Example Modal' } %>
        <%= m.close_button %>
    <% end %>
    <%= m.body do %>
        Lorem ipsum dolor sit amet consectetur adipisicing elit. Vel nisi tempora, eius iste sit nobis
        earum in harum optio dolore explicabo. Eveniet reprehenderit harum itaque ad fuga beatae, quasi
        sequi! Laborum ea porro nihil ipsam repudiandae vel harum voluptates minima corrupti unde quas,
        dolore possimus doloribus voluptatem sint fuga dolores odio dignissimos at molestias earum.
    <% end %>
    <%= m.footer do %>
        <%= m.close_button class: 'btn btn-secondary' do %>
            Close
        <% end %>
    <% end %>
<% end %>
```

### Navs

For building nav components. The Nav compoent has the following methods:

- `dropwdown` - @see Dropdown for list of methods
- `item`
- `link`

```erb
<%= nav_helper do |nav| %>
    <%= nav.link "Item 1", "https://www.google.com" %>
    <%= nav.link "Item 2", "#" %>
    <%= nav.link "Item 3", "#" %>
    <%= nav.dropdown :more do |menu| %>
        <%= menu.link 'People', '#' %>
        <%= menu.link 'Records', '#' %>
    <% end %>

    <%= nav.dropdown "More 2" do |menu| %>
        <%= menu.link 'People', '#' %>
        <%= menu.link 'Records', '#' %>
    <% end %>
<% end %>
```

### Tabs

> Note: There are two types, `:tabs` and `:pills`. The default is `:tabs`.
>
> Example:
> `<%= tab_helper :pills do |tab| %>`

```erb
<%= tab_helper :tabs do |tab| %>
    <%= tab.nav do |nav| %>
        <%= nav.item :item1 do %>
            Item 1
        <% end %>
        <%= nav.item(:item2, class: 'active') { "Item 2" } %>
        <%= nav.item(:item3) { "Item 3" } %>
        <%= nav.item :item4 %>
        <%= nav.dropdown 'More' do |dropdown| %>
            <%= dropdown.item :item5 %>
            <%= dropdown.item(:item6) { 'Item 6' } %>
        <% end %>
    <% end %>

    <%= tab.content do |content| %>
        <%= content.pane :item1, class: 'mt-3' do %>
            Content 1
        <% end %>

        <%= content.pane :item2, class: 'active mt-3' do %>
            Content 2
        <% end %>

        <%= content.pane :item3, class: 'mt-3' do %>
            Content 3
        <% end %>

        <%= content.pane :item4, class: 'mt-3' do %>
            Content 4
        <% end %>

        <%= content.pane :item5, class: 'mt-3' do %>
            Content 5
        <% end %>

        <%= content.pane :item6, class: 'mt-3' do %>
            Content 6
        <% end %>
    <% end %>
<% end %>
```

### Spinners

Creates CSS spinner components. Supports two types: `:border` and `:grow`. Teh default is `:border`

```erb
<%= spinner_helper class: 'text-warning' %>
<%= spinner_helper type: :grow, class: 'text-danger', id: 'loadingRecords' %>
```

## Contributing

If you would like to contribution, by all means, do a PR and send up your suggestions.

If there are components you would like to see added, open an issue and I will try to get to them, or you can do a PR and add them yourself :D

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
