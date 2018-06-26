defmodule Primer.ElementsTest do
  use Primer.Case

  import Primer.Elements

  alias Primer.Elements.MissingConfigurationError

  describe "code_with_heart" do
    setup do
      original = Application.get_env(:primer, :code_with_heart)

      on_exit(fn ->
        Application.put_env(:primer, :code_with_heart, original, timeout: :infinity)
      end)
    end

    test "renders the element", _context do
      element = render(code_with_heart("Author Name", "https://example.com"))
      link = find(element, "a.link-gray-dark")

      assert find(element, "svg.octicons.octicons-code")
      assert find(element, "svg.octicons.octicons-heart")
      assert text(element) =~ ~r{with\s+by}
      assert text(link) == "Author Name"
      assert attribute(link, "href") == ["https://example.com"]
    end

    test "passes through options to the link", _context do
      element = render(code_with_heart("Author Name", "https://example.com", foo: "bar"))
      link = find(element, "a.link-gray-dark")

      assert attribute(link, "foo") == ["bar"]
    end

    test "uses configuration if no parameters are given", _context do
      Application.put_env(
        :primer,
        :code_with_heart,
        name: "Author Name",
        url: "https://example.com"
      )

      element = render(code_with_heart())
      link = find(element, "a.link-gray-dark")

      assert find(element, "svg.octicons.octicons-code")
      assert find(element, "svg.octicons.octicons-heart")
      assert text(element) =~ ~r{with\s+by}
      assert text(link) == "Author Name"
      assert attribute(link, "href") == ["https://example.com"]
    end

    test "raises an error if no configuration and no parameters", _context do
      assert_raise MissingConfigurationError, fn ->
        code_with_heart()
      end
    end
  end

  describe "github_link" do
    setup do
      original = Application.get_env(:primer, :github_link)

      on_exit(fn ->
        Application.put_env(:primer, :github_link, original, timeout: :infinity)
      end)
    end

    test "renders the element", _context do
      link = render(github_link("https://github.com/foo/bar"))

      assert find(link, "a.link-gray-dark.tooltipped.tooltipped-n")
      assert find(link, "a svg.octicons.octicons-mark-github")
      assert attribute(link, "aria-label") == ["View this project on GitHub"]
      assert attribute(link, "href") == ["https://github.com/foo/bar"]
    end

    test "prepends https://github.com if only the name with owner is specified", _context do
      link = render(github_link("foo/bar"))

      assert attribute(link, "href") == ["https://github.com/foo/bar"]
    end

    test "uses configuration if no url is given", _context do
      Application.put_env(:primer, :github_link, "https://github.com/foo/bar")
      link = render(github_link())

      assert find(link, "a.link-gray-dark.tooltipped.tooltipped-n")
      assert find(link, "a svg.octicons.octicons-mark-github")
      assert attribute(link, "aria-label") == ["View this project on GitHub"]
      assert attribute(link, "href") == ["https://github.com/foo/bar"]
    end

    test "raises an error if no configuration and no url is given", _context do
      assert_raise MissingConfigurationError, fn ->
        github_link()
      end
    end
  end
end
