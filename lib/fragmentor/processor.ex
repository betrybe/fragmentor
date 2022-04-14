defmodule Fragmentor.Processor do
  @moduledoc """
  Internal module responsible for processing parsing operations
  """

  alias Fragmentor.Utils
  alias Fragmentor.Parser.HtmlParser
  alias Fragmentor.Fragment.{Code, Video, Html}

  @spec to_html(binary(), list()) ::
          {:error, list} | {:error, String.t()} | {:ok, binary}

  def to_html(markdown, options \\ [compact_output: true])

  def to_html(nil, _options), do: {:error, "Markdown Empty"}

  def to_html(markdown, options) do
    with {:ok, html_doc, _} <- Earmark.as_html(markdown, options),
         html_sanitized <- Utils.remove_hr_inner_class(html_doc) do
      {:ok, html_sanitized}
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
  end


  ## ToDo Adicionar tratamento de erro aqui
  @spec to_fragments(binary(), list()) ::
          {:ok, [Code.t() | Video.t() | Html.t()]} | {:error, String.t()}
  def to_fragments(html, _options \\ []), do: {:ok, HtmlParser.to_fragments(html)}

  @spec to_fragments!(binary(), list()) :: [Code.t() | Video.t() | Html.t()]
  def to_fragments!(html, _options \\ []), do: HtmlParser.to_fragments(html)

  ## ToDo Add a markdown -> html -> fragment flux
  # def to_fragments(markdown, options \\ []) do
  #   with {:ok, html_content} <- to_html(markdown, options),
  #        fragmented_html <- HtmlParser.to_fragments(html_content) do
  #     {:ok, fragmented_html}
  #   else
  #     {:error, error_message} -> {:error, error_message}
  #   end
  # end
end
