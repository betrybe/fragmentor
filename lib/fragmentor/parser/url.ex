defmodule Fragmentor.Parser.Url do
  @moduledoc """
  Module responsible for managing links and images urls
  inside markdown strings.
  """

  @doc """
  Returns a list of images found inside a markdown file
  considering the following types png, jpg, jpeg e gif.

  ## Example

      iex> markdown_with_images =
        \"\"\"
        content [image](https://url-to-image.com/image.jpg)
        content [ignored_image](https://url-to-image.com/image)
        link [link](https://url-to-link.com/link)
        \"\"\"

      iex> Fragmentor.Parser.Url.find_images_marks(markdown_with_images)
      [%{name: "image", url: "https://url-to-image.com/image.jpg"}]
  """
  @spec find_images_marks(nil | binary) :: list(map())
  def find_images_marks(nil), do: []

  def find_images_marks(markdown_content) do
    ~r/!\[(.+?)\]\((.+?)\)/
    |> Regex.scan(markdown_content)
    |> Enum.map(&name_captures/1)
  end

  defp name_captures([_, name, url]), do: %{name: name, url: url}

  @doc """
  Replaces urls from markdown content
  """
  @spec replace_markdown_url(binary(), list() | binary() | nil) :: binary()
  def replace_markdown_url(markdown_content, nil), do: markdown_content

  def replace_markdown_url(markdown_content, urls_list) when is_list(urls_list) do
    Enum.reduce(urls_list, markdown_content, fn url, acc ->
      case extract_link_from_markdown(url, acc) do
        %{"alt" => _alt, "link" => link} -> String.replace(acc, link, url)
        nil -> acc
      end
    end)
  end

  def replace_markdown_url(markdown_content, url) do
    case extract_link_from_markdown(url, markdown_content) do
      %{"alt" => _alt, "link" => link} -> String.replace(markdown_content, link, url)
      nil -> markdown_content
    end
  end

  defp extract_link_from_markdown(link_name, markdown) do
    regex = ~r/!(?<alt>\[#{link_name}\])\((?<link>.+?)\)/s
    Regex.named_captures(regex, markdown)
  end
end
