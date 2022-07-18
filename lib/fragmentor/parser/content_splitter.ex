defmodule Fragmentor.Parser.HtmlParser.ContentSplitter do
  @moduledoc """
  Module responsible for splitting html texts into a list
  whenever there is a code or video tag
  """
  @delimiter "(353d9062\-7872\-4d64\-91b7\-f3959a0bf49d)"
  @starting_pattern ~r/(<pre|<iframe)/
  @ending_pattern ~r/(<\/pre>|<\/iframe>)/

  @spec split(String.t()) :: list(String.t())
  def split(html_content) do
    html_content = Regex.replace(@starting_pattern, html_content, "#{@delimiter}\\1")

    Regex.replace(@ending_pattern, html_content, "\\1#{@delimiter}")
    |> String.split(@delimiter)
    |> Enum.filter(&not_empty_string?/1)
  end

  defp not_empty_string?(string) do
    string != nil and String.trim(string) != ""
  end
end
