defmodule Primer.Case do
  @moduledoc """
  Basic test case module.
  """
  use ExUnit.CaseTemplate

  using do
    quote do
      import Floki, only: [attribute: 2, find: 2, text: 1], warn: false

      import Support.HTML
    end
  end
end
