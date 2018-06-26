defmodule Primer do
  @moduledoc """
  Tools for generating elements that work with GitHub's
  [Primer CSS framework](https://primer.github.io/).

  All functions can be used either within a template or composed together in code. Each function
  should always emit `t:Phoenix.HTML.safe/0` objects or throw an exception.

  ## Primer components

  ### Avatars

  Functions for displaying
  [avatar elements](https://github.com/primer/primer/tree/master/modules/primer-avatars).

  * `avatar/2`

  ### Labels

  Functions for displaying
  [label elements](https://github.com/primer/primer/tree/master/modules/primer-labels).

  * `counter/1`

  ### Navigation

  Functions for displaying
  [navigation elements](https://github.com/primer/primer/tree/master/modules/primer-navigation).

  * `menu/1`
  * `menu_item/3`
  * `underline_nav/2`
  * `underline_nav_item/3`

  ## Standard GitHub-style features

  These are functions for adding features that are typically present on GitHub-authored web
  properties that aren't part of the Primer CSS framework.

  * `code_with_heart/3`
  * `github_link/2`
  """

  @type user :: %{user: binary, avatar_url: binary}

  @doc false
  def append_class(base, nil), do: base
  def append_class(base, ""), do: base
  def append_class(base, class) when is_binary(class), do: base <> " " <> class

  @doc false
  def append_query(url, options) do
    map = Enum.into(options, %{})
    uri = URI.parse(url)

    new_query =
      uri.query ||
        ""
        |> URI.decode_query(map)
        |> URI.encode_query()

    uri
    |> Map.put(:query, new_query)
    |> to_string()
  end
end
