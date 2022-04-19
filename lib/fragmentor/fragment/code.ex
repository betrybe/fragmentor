defmodule Fragmentor.Fragment.Code do
  @moduledoc """
  Module that contains represents the structure of a Fragment
  of type Code
  """
  @type t :: %__MODULE__{
          fragment_type: String.t(),
          language: String.t(),
          content: String.t()
        }
  @derive Jason.Encoder

  @enforce_keys [:language, :content]
  defstruct fragment_type: "code", language: nil, content: nil
end
