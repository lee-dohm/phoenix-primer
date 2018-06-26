defmodule Primer.Utility do
  @moduledoc false

  @doc false
  def append_class(base, nil), do: base
  def append_class(base, ""), do: base
  def append_class(base, class) when is_binary(class), do: base <> " " <> class

  def append_class(base, classes) when is_list(classes),
    do: append_class(base, Enum.join(classes, " "))

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
