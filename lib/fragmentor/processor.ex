defmodule Fragmentor.Processor do
  @moduledoc """
  Internal module responsible for processing parsing operations
  """

  alias Fragmentor.Fragment.{Code, Html, Video}
  alias Fragmentor.Parser.HtmlParser
  alias Fragmentor.Utils

  @spec to_html(binary(), list()) :: {:error, list} | {:error, String.t()} | {:ok, binary}
  def to_html(markdown, options \\ [compact_output: true])
  def to_html(nil, _options), do: {:error, "Markdown Empty"}

  def to_html(markdown, options) do
    with {:ok, html_doc, _} <- Earmark.as_html(markdown, options),
         html_sanitized <- Utils.remove_hr_inner_class(html_doc),
         html_with_target_blank_links <- Utils.add_target_blank_on_links(html_sanitized) do
      {:ok, html_with_target_blank_links}
    else
      {:error, _html_doc, error_messages} -> {:error, error_messages}
    end
  end

  @spec to_html!(binary(), list()) :: binary()
  def to_html!(markdown, options \\ [compact_output: true])
  def to_html!(nil, _options), do: {:error, "Markdown Empty"}

  def to_html!(markdown, options) do
    markdown
    |> Earmark.as_html!(options)
    |> Utils.remove_hr_inner_class()
    |> Utils.add_target_blank_on_links()
  end

  @spec to_fragments(binary(), list()) ::
          {:ok, [Code.t() | Video.t() | Html.t()]} | {:error, String.t()}
  def to_fragments(html, _options \\ []), do: {:ok, HtmlParser.to_fragments(html)}

  @spec to_fragments!(binary(), list()) :: [Code.t() | Video.t() | Html.t()]
  def to_fragments!(html, _options \\ []), do: HtmlParser.to_fragments(html)
end
