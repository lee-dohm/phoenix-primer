defmodule Primer.Navigation do
  @moduledoc """
  Functions for generating
  [Primer Navigation](https://github.com/primer/primer/tree/master/modules/primer-navigation) elements.
  """
  use Phoenix.HTML

  alias Primer.Labels
  alias Primer.Utility

  @doc """
  Renders a menu element.

  **See:** [Menu element documentation](https://github.com/primer/primer/tree/master/modules/primer-navigation#menu)

  ## Example

  Slime template:

  ```
  = menu do
    = menu_item("Foo", "/path/to/foo", selected: true)
    = menu_item("Bar", "/path/to/bar")
  ```

  generates:

  ```html
  <nav class="menu">
    <a class="menu-item selected" href="/path/to/foo">Foo</a>
    <a class="menu-item" href="/path/to/bar">Bar</a>
  </nav>
  ```
  """
  @spec menu(Keyword.t()) :: Phoenix.HTML.safe()
  def menu(block)

  def menu(do: block) do
    content_tag(:nav, block, class: "menu")
  end

  @doc """
  Renders a menu item element.

  ## Options

  * `:octicon` - Renders an [Octicon](https://octicons.github.com) with the menu item
  * `:selected` - If `true`, renders the menu item as selected

  All other options are passed through to the underlying HTML `a` element.
  """
  @spec menu_item(String.t(), String.t(), Keyword.t()) :: Phoenix.HTML.safe()
  def menu_item(text, link, options \\ []) do
    selected = options[:selected]

    class =
      "menu-item"
      |> Utility.append_class(options[:class])
      |> Utility.append_class(if selected, do: "selected", else: nil)

    tag_options =
      options
      |> Keyword.drop([:octicon, :selected])
      |> Keyword.put(:href, link)
      |> Keyword.put(:class, class)

    content =
      if options[:octicon] do
        [
          PhoenixOcticons.octicon(options[:octicon], width: 16),
          text
        ]
      else
        text
      end

    content_tag(:a, content, tag_options)
  end

  @doc """
  Renders an `UnderlineNav` element.

  The `underline_nav_item/3` function is used to generate the nav items within the nav element.

  **See:** [UnderlineNav element documentation](https://github.com/primer/primer/tree/master/modules/primer-navigation#underline-nav)

  ## Options

  All options are passed through to the underlying HTML `nav` element.

  ## Example

  Slime template:

  ```
  = underline_nav do
    = underline_nav_item "Foo", "/path/to/foo", selected: true
    = underline_nav_item "Bar", "/path/to/bar"
  ```

  generates:

  ```html
  <nav class="UnderlineNav">
    <div class="UnderlineNav-body">
      <a class="UnderlineNav-item selected" href="/path/to/foo">Foo</a>
      <a class="UnderlineNav-item" href="/path/to/bar">Bar</a>
    </div>
  </div>
  ```
  """
  @spec underline_nav(Keyword.t(), Keyword.t()) :: Phoenix.HTML.safe()
  def underline_nav(options \\ [], block)

  def underline_nav(options, do: block) do
    class = Utility.append_class("UnderlineNav", options[:class])

    content_tag(:nav, class: class) do
      content_tag(:div, block, class: "UnderlineNav-body")
    end
  end

  @doc """
  Renders an `UnderlineNav-item` element.

  ## Options

  * `:counter` - When supplied with an integer value, renders a `Counter` element
  * `:selected` - When `true`, renders this item as selected

  All other options are passed through to the underlying HTML `a` element.
  """
  @spec underline_nav_item(String.t(), String.t(), Keyword.t()) :: Phoenix.HTML.safe()
  def underline_nav_item(text, link, options \\ []) do
    count = options[:counter]
    selected = options[:selected]

    class =
      "UnderlineNav-item"
      |> Utility.append_class(options[:class])
      |> Utility.append_class(if selected, do: "selected", else: nil)

    tag_options =
      options
      |> Keyword.drop([:counter, :selected])
      |> Keyword.put(:class, class)

    tag_options = if selected, do: tag_options, else: Keyword.put(tag_options, :href, link)
    content = if count, do: [text, Labels.counter(count)], else: text

    content_tag(:a, content, tag_options)
  end
end
