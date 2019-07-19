defmodule RadioSystem.Radio.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, only: [:id, :alias, :allowed_locations, :radio_id, :location]}
  schema "radio_profiles" do
    field :alias, :string
    field :allowed_locations, {:array, :string}
    field :radio_id, :integer
    field :location, :string

    timestamps()
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:radio_id, :alias, :allowed_locations])
    |> validate_required([:radio_id, :alias, :allowed_locations])
    |> unique_constraint(:radio_id)
  end
end
