defmodule Fragmentor.Processor do
  @moduledoc """
  Internal module responsible for processing parsing operations
  """

  alias Fragmentor.Utils
  alias Fragmentor.Parser.HtmlParser
  alias Fragmentor.Fragment.{Code, Video, Html}

  @spec to_html(String.t(), list()) ::
          {:error, list} | {:error, String.t()} | {:ok, binary}

  def to_html(markdown, options \\ [])

  def to_html(nil, _options), do: {:error, "Markdown Empty"}

  def to_html(markdown, options) do
    with {:ok, html_doc, _} <- Earmark.as_html(markdown, options),
         html_sanitized <- Utils.remove_hr_inner_class(html_doc) do
      {:ok, html_sanitized}
    else
      {:error, _html_doc, error_messages} -> {:error, error_messages}
    end
  end

  @spec to_fragments(binary(), list()) :: [Code.t() | Video.t() | Html.t()]
  def to_fragments(markdown, options \\ []) do
    {:ok, html} = to_html(markdown, options)

    build_fragments(html)
  end

  defp build_fragments(markdown) when is_binary(markdown) do
    {:ok, html_content} = to_html(markdown)
    HtmlParser.to_fragments(html_content)
  end
end
