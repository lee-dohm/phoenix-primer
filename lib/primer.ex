defmodule Primer do
  @moduledoc """
  Tools for generating elements that work with GitHub's
  [Primer CSS framework](https://primer.github.io/).

  All functions can be used either within a template or composed together in code. Each function
  should always emit `t:Phoenix.HTML.safe/0` objects or throw an exception.

  The simplest way to use this library is to add the following to your Phoenix view template:

  ```
  use Primer
  ```

  Or, if you only want to include the parts you use, you can import functions individually from the
  various modules.
  """

  defmacro __using__(_options) do
    quote do
      import Primer.Avatars
      import Primer.Elements
      import Primer.Labels
      import Primer.Navigation
    end
  end
end
