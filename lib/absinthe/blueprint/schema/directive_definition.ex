defmodule Absinthe.Blueprint.Schema.DirectiveDefinition do
  @moduledoc false

  alias Absinthe.Blueprint

  @enforce_keys [:name]
  defstruct [
    :name,
    :module,
    :identifier,
    description: nil,
    directives: [],
    arguments: [],
    locations: [],
    expand: nil,
    errors: [],
    __reference__: nil,
    __private__: []
  ]

  @type t :: %__MODULE__{
          name: String.t(),
          description: nil,
          arguments: [Blueprint.Schema.InputValueDefinition.t()],
          locations: [String.t()],
          errors: [Absinthe.Phase.Error.t()]
        }

  def build(type_def, _schema) do
    %Absinthe.Type.Directive{
      name: type_def.name,
      identifier: type_def.identifier,
      description: type_def.description,
      args: Blueprint.Schema.ObjectTypeDefinition.build_args(type_def),
      locations: type_def.locations |> Enum.sort(),
      definition: type_def.module
    }
  end
end
