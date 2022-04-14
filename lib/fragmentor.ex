defmodule Fragmentor do
  @moduledoc """
  Fragmentor is library made for converting markdown into
  html fragmented by separated types.

  Currently we support only three types of fragments
  * `Code` - Consists of Syntax Highlighting Codes
  * `HTML` - Any kind of HTML code with tags and text
  * `Video` - Consists of video html tags and its atributes
  """

  @doc """
  Converts Markdown text directly to a fragmented HTML
  """
  defdelegate to_fragments(markdown, options \\ []), to: Fragmentor.Processor

  @doc """
  Converts Markdown text directly to a fragmented HTML

   Raises `Error` if the Content object does not exist.
  """
  defdelegate to_fragments!(markdown, options \\ []), to: Fragmentor.Processor

  @doc """
  Convert Markdown text directly to raw HTML

  ## Example
      iex> to_html("*markdown content*", compact_output: true)
      {:ok, "<p><em>markdown content</em></p>"}
  """
  defdelegate to_html(markdown, options \\ []), to: Fragmentor.Processor

  @doc """
  Convert Markdown text directly to raw HTML

  Raises `Error` if the Content object does not exist.

  ## Example
      iex> to_html("*markdown content*", compact_output: true)
      "<p><em>markdown content</em></p>"
  """
  defdelegate to_html!(markdown, options \\ []), to: Fragmentor.Processor
end
