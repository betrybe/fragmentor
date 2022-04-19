defmodule Fragmentor.Parser.HtmlParser do
  @moduledoc """
  Modulo
  """
  alias Fragmentor.Fragment.{Code, Html, Video}
  alias Fragmentor.Parser.HtmlParser.{ContentSplitter, FragmentMapper}

  @spec to_fragments(binary) :: list(Code.t() | Html.t() | Video.t())
  def to_fragments(nil), do: []

  def to_fragments(""), do: []

  def to_fragments(html_content) do
    html_content
    |> ContentSplitter.split()
    |> Enum.map(&FragmentMapper.to_struct/1)
  end
end
