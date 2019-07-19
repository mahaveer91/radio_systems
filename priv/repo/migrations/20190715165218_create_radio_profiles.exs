defmodule RadioSystem.Repo.Migrations.CreateRadioProfiles do
  use Ecto.Migration

  def change do
    create table(:radio_profiles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :radio_id, :integer
      add :alias, :string
      add :allowed_locations, {:array, :string}
      add :location, :string, default: "unknown"

      timestamps()
    end

    create unique_index(:radio_profiles, [:radio_id])
    create index(:radio_profiles, [:alias])
    create index(:radio_profiles, [:location])
  end
end
