defmodule Fragmentor.Fragment.Html do
  @moduledoc """
  Module that contains represents the structure of a Fragment
  of type Html
  """
  @type t :: %__MODULE__{
          fragment_type: String.t(),
          content: String.t()
        }

  @derive Jason.Encoder

  @enforce_keys [:content]
  defstruct fragment_type: "html", content: nil
end
