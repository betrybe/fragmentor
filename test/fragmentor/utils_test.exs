defmodule Fragmentor.UtilsTest do
  @moduledoc false
  use ExUnit.Case

  alias Fragmentor.Utils

  describe "add_target_blank_on_links/1" do
    test "ensure links have target=\"blank\"" do
      html_content = "<h1>Title<h1><a href=\"www.google.com\">"
      assert Utils.add_target_blank_on_links(html_content) =~ "target=\"_blank\""
    end
  end
end
