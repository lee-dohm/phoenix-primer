defmodule Primer.AvatarsTest do
  use Primer.Case

  import Primer.Avatars

  setup do
    user = %{name: "foo", avatar_url: "https://example.com/image.png"}

    {:ok, user: user}
  end

  test "renders correctly without size option", context do
    image =
      context.user
      |> avatar()
      |> render()

    assert find(image, "img.avatar")
    assert attribute(image, "alt") == [context.user.name]
    assert hd(attribute(image, "src")) =~ context.user.avatar_url
  end

  test "renders correctly with size option", context do
    image =
      context.user
      |> avatar(size: 60)
      |> render()

    assert find(image, "img.avatar")
    assert attribute(image, "alt") == [context.user.name]
    assert attribute(image, "width") == ["60"]
    assert attribute(image, "height") == ["60"]
    assert hd(attribute(image, "src")) =~ context.user.avatar_url
  end

  test "passes other options through to the underlying HTML element", context do
    image =
      context.user
      |> avatar(class: "test")
      |> render()

    assert find(image, "img.avatar.test")
  end
end
