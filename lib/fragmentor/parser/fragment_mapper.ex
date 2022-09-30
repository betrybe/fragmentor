defmodule Fragmentor.Parser.HtmlParser.FragmentMapper do
  @moduledoc """
  Module responsible for converting html splitted html texts
  into fragments structures
  """
  alias Fragmentor.Fragment.{Code, Html, Video}

  @code_starting "<pre"
  @code_pattern ~r/<pre><code\s+class="(.+)?">([\s\S]+)+?<\/code><\/pre>/

  @iframe_starting "<iframe"
  @video_pattern ~r/http(?:s)?:\/\/(?:www\.)?.+(youtube|vimeo).+\/(?:embed|video)\/(.+?)(?:"|\?)/

  @spec to_struct(String.t()) :: %{
          :__struct__ => Code | Html | Video,
          :fragment_type => String.t(),
          optional(:content) => String.t(),
          optional(:language) => String.t(),
          optional(:provider) => String.t(),
          optional(:url) => String.t(),
          optional(:video_id) => String.t()
        }
  def to_struct(@code_starting <> fragment_ending) do
    regex_match = Regex.run(@code_pattern, @code_starting <> fragment_ending)
    create_code_fragment(regex_match)
  end

  def to_struct(@iframe_starting <> fragment_ending) do
    case Regex.run(@video_pattern, @iframe_starting <> fragment_ending) do
      [url, provider, video_id] ->
        create_video_fragment([url, provider, video_id])

      nil ->
        create_html_fragment(@iframe_starting <> fragment_ending)
    end
  end

  def to_struct(fragment), do: create_html_fragment(fragment)

  defp create_code_fragment(nil), do: to_struct("")

  defp create_code_fragment([_, language, content]) do
    %Code{
      language: language,
      content: content
    }
  end

  defp create_video_fragment([url, provider, video_id]) do
    %Video{
      provider: provider,
      url: url,
      video_id: video_id
    }
  end

  defp create_html_fragment(fragment) do
    %Html{
      content: fragment
    }
  end
end
