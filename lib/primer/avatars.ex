defmodule Primer.Avatars do
  @moduledoc """
  Functions for generating
  [Primer Avatars](https://github.com/primer/primer/tree/master/modules/primer-avatars) elements.
  """
  use Phoenix.HTML

  alias Primer.Utility

  @typedoc """
  A generic user record.
  """
  @type user :: %{user: binary, avatar_url: binary}

  @doc """
  Renders the `avatar` element for the `user`.

  ## Options

  * `:size` - value in pixels to use for both the width and height of the avatar image
  """
  @spec avatar(user, Keword.t()) :: Phoenix.HTML.safe()
  def avatar(user, options \\ [])

  def avatar(user, options) do
    size = options[:size]

    class = Utility.append_class("avatar", options[:class])
    src = add_size_to_url(user.avatar_url, size)

    tag_options =
      options
      |> Keyword.drop([:size])
      |> Keyword.put(:alt, user.name)
      |> Keyword.put(:class, class)
      |> Keyword.put(:src, src)
      |> Keyword.put(:width, size)
      |> Keyword.put(:height, size)

    tag(:img, tag_options)
  end

  defp add_size_to_url(url, nil), do: url
  defp add_size_to_url(url, size), do: Utility.append_query(url, s: size)
end
