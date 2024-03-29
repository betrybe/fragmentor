defmodule Fragmentor.Utils do
  @moduledoc """
  Contains util functions for sanitizing markdown and html strings
  """

  @doc """
  Removes html double quotes after being parsed
  """
  @spec sanitize_html_initial_double_quotes(binary()) :: binary()
  def sanitize_html_initial_double_quotes(html_content) do
    Regex.replace(~r/(^"|"$)/, html_content, "")
  end

  @doc """
  Add html target="_blank" on links being parsed
  """
  @spec add_target_blank_on_links(binary()) :: binary()
  def add_target_blank_on_links(html_content) do
    String.replace(html_content, "<a", "<a target=\"_blank\"")
  end

  @doc """
  Removes html hr tag class values
  """
  @spec remove_hr_inner_class(binary()) :: binary()
  def remove_hr_inner_class(html_content) do
    String.replace(html_content, "<hr class=\"medium\" />", "<hr />")
    |> String.replace("<hr class=\"thin\" />", "<hr />")
    |> String.replace("<hr class=\"thick\" />", "<hr />")
  end
end
