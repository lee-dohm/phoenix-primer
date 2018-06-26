defmodule Primer.Elements do
  @moduledoc """
  Functions for displaying common elements that are present on GitHub-authored sites.
  """
  use Phoenix.HTML

  defmodule MissingConfigurationError do
    defexception [:missing_keys]

    def exception(key) when is_atom(key), do: exception([key])

    def exception(keys) when is_list(keys) do
      %__MODULE__{missing_keys: keys}
    end

    def message(%{missing_keys: missing_keys}) do
      "application configuration missing: #{inspect(missing_keys)}"
    end
  end

  @doc """
  Renders the GitHub-style `<> with ♥ by [author link]` footer item.

  Retrieves the author's name and URL from the application configuration before passing to
  `code_with_heart/3`. This information can be added to the application configuration by adding the
  following to your `config.exs`:

  ```
  config :primer,
    code_with_heart: [
      name: "Author's name",
      url: "https://example.com"
    ]
  ```

  Raises a `Primer.Elements.MissingConfigurationError` if any of the required
  application configuration information is not specified and this function is called.
  """
  @spec code_with_heart(keyword) :: Phoenix.HTML.safe()
  def code_with_heart(options \\ []) do
    config = Application.get_env(Application.get_application(__MODULE__), :code_with_heart)
    name = config[:name]
    url = config[:url]

    unless name && url, do: raise(MissingConfigurationError, :code_with_heart)

    code_with_heart(name, url, options)
  end

  @doc """
  Renders the GitHub-style `<> with ♥ by [author link]` footer item.

  The text in this element is intentionally left untranslated because the form of the element is
  intended to be recognizable in its specific format.

  ## Options

  All options are passed to the underlying HTML `a` element.
  """
  @spec code_with_heart(binary, binary, keyword) :: Phoenix.HTML.safe()
  def code_with_heart(name, url, options \\ []) do
    link_options = Keyword.merge([to: url, class: "link-gray-dark"], options)

    html_escape([
      PhoenixOcticons.octicon(:code),
      " with ",
      PhoenixOcticons.octicon(:heart),
      " by ",
      link(name, link_options)
    ])
  end

  @doc """
  Renders a link to the project on GitHub.

  Retrieves the project name or URL from the application configuration. This configuration
  information can be added to the application configuration by adding the following to your
  `config.exs`:

  ```
  config :primer,
    github_link: "owner/name"
  ```

  If the configuration information is missing, a `Primer.Elements.MissingConfigurationError` is
  raised.
  """
  @spec github_link(binary | keyword) :: Phoenix.HTML.safe()
  def github_link(project_or_options \\ [])

  def github_link(project) when is_binary(project), do: github_link(project, [])

  def github_link(options) when is_list(options) do
    url = Application.get_env(Application.get_application(__MODULE__), :github_link)

    unless url, do: raise(MissingConfigurationError, :github_link)

    github_link(url, options)
  end

  @doc """
  Renders a link to the project on GitHub.

  `project` can be either a full URL or the just the GitHub `owner/name` specification.

  ## Options

  * `:tooltip_text` - Description text to display in the tooltip _(default: "View this project on
    GitHub")_

  All other options are passed to the underlying HTML `a` element.
  """
  def github_link(project, options) when is_binary(project) do
    # Prepend the `https://github.com/` if only the name with owner is specified
    url = if project =~ ~r{^[^/]+/[^/]+$}, do: "https://github.com/#{project}", else: project

    link_options =
      Keyword.merge(
        [
          to: url,
          "aria-label": options[:tooltip_text] || "View this project on GitHub",
          class: "link-gray-dark tooltipped tooltipped-n"
        ],
        options
      )

    link(link_options) do
      PhoenixOcticons.octicon("mark-github")
    end
  end
end
