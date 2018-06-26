defmodule Primer.NavigationTest do
  use Primer.Case

  import Primer.Navigation

  describe "menu" do
    test "renders the element", _context do
      menu = render(menu(do: nil))

      assert find(menu, "nav.menu")
    end
  end

  describe "menu_item" do
    test "renders the element with no options", _context do
      item = render(menu_item("foo", "/path/to/foo"))

      assert find(item, "a.menu-item")
      assert attribute(item, "href") == ["/path/to/foo"]
      assert text(item) == "foo"
    end

    test "renders the element as selected", _context do
      item = render(menu_item("foo", "/path/to/foo", selected: true))

      assert find(item, "a.menu-item.selected")
      assert attribute(item, "href") == ["/path/to/foo"]
      assert text(item) == "foo"
    end

    test "renders the element with an octicon", _context do
      item = render(menu_item("foo", "/path/to/foo", octicon: :beaker))

      assert find(item, "a.menu-item")
      assert attribute(item, "href") == ["/path/to/foo"]
      assert text(item) == "foo"
      assert find(item, "a.menu-item svg")
    end
  end

  describe "underline_nav" do
    test "renders the elements", _context do
      nav = render(underline_nav(do: nil))

      assert find(nav, "nav.UnderlineNav")
      assert find(nav, "nav.UnderlineNav .UnderlineNav-body")
    end
  end

  describe "underline_nav_item" do
    test "renders the element without options", _context do
      item = render(underline_nav_item("foo", "/path/to/foo"))

      assert find(item, "a.UnderlineNav-item")
      assert attribute(item, "href") == ["/path/to/foo"]
      assert text(item) == "foo"
    end

    test "renders the element as selected", _context do
      item = render(underline_nav_item("foo", "/path/to/foo", selected: true))

      assert find(item, "a.UnderlineNav-item.selected")
      assert attribute(item, "href") == []
      assert text(item) == "foo"
    end

    test "renders the item with a counter", _context do
      item = render(underline_nav_item("foo", "/path/to/foo", counter: 5))

      assert find(item, "a.UnderlineNav-item span.Counter")
      assert attribute(item, "href") == ["/path/to/foo"]
      assert text(item) == "foo5"
    end
  end
end
