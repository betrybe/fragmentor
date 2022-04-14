defmodule Fragmentor.Fragment.Video do
  @moduledoc """
  Module that contains represents the structure of a Fragment
  of type Video
  """
  @type t :: %__MODULE__{
          fragment_type: String.t(),
          provider: String.t(),
          url: String.t(),
          video_id: String.t()
        }
  @derive Jason.Encoder
  @enforce_keys [:provider, :url, :video_id]
  defstruct fragment_type: "video", provider: nil, url: nil, video_id: nil
end
