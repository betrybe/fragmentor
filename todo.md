### processor.ex

- [] ToDo Adicionar tratamento de erro aqui
```elixir
  @spec to_fragments(binary(), list()) ::
          {:ok, [Code.t() | Video.t() | Html.t()]} | {:error, String.t()}
  def to_fragments(html, _options \\ []), do: {:ok, HtmlParser.to_fragments(html)}

  @spec to_fragments!(binary(), list()) :: [Code.t() | Video.t() | Html.t()]
  def to_fragments!(html, _options \\ []), do: HtmlParser.to_fragments(html)
```

- [] ToDo Add a markdown -> html -> fragment flux
```elixir
  def to_fragments(markdown, options \\ []) do
    with {:ok, html_content} <- to_html(markdown, options),
         fragmented_html <- HtmlParser.to_fragments(html_content) do
      {:ok, fragmented_html}
    else
      {:error, error_message} -> {:error, error_message}
    end
  end
```