defmodule Primer.LabelsTest do
  use Primer.Case

  import Primer.Labels

  describe "counter" do
    test "renders the element", _context do
      counter = render(counter(11))

      assert find(counter, "span.Counter")
      assert text(counter) == "11"
    end
  end
end
