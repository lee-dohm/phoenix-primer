defmodule Primer.Avatars do
  @moduledoc """
  Functions for generating
  [Primer Avatars](https://github.com/primer/primer/tree/master/modules/primer-avatars) elements.
  """
  use Phoenix.HTML

  @doc """
  Renders the `avatar` element for the `user`.

  ## Options

  * `:size` - value in pixels to use for both the width and height of the avatar image
  """
  @spec avatar(Primer.user(), Keword.t()) :: Phoenix.HTML.safe()
  def avatar(user, options \\ [])

  def avatar(user, options) do
    size = options[:size] || 35

    class = Primer.append_class("avatar", options[:class])

    tag_options =
      options
      |> Keyword.drop([:size])
      |> Keyword.put(:alt, user.name)
      |> Keyword.put(:class, class)
      |> Keyword.put(:src, Primer.append_query(user.avatar_url, s: size))
      |> Keyword.put(:width, size)
      |> Keyword.put(:height, size)

    tag(:img, tag_options)
  end
end
