defmodule JumpstartWeb.ErrorJSONTest do
  use JumpstartWeb.ConnCase, async: true

  test "renders 404" do
    assert JumpstartWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert JumpstartWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
