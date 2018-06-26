defmodule Primer.Labels do
  @moduledoc """
  Functions for generating
  [Primer Labels](https://github.com/primer/primer/tree/master/modules/primer-labels) elements.
  """
  use Phoenix.HTML

  @doc """
  Renders a `Counter` element.
  """
  @spec counter(non_neg_integer()) :: Phoenix.HTML.safe()
  def counter(count) do
    content_tag(:span, Integer.to_string(count), class: "Counter")
  end
end
