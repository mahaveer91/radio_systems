defmodule RadioSystem.RadioSystemsTest do
  use RadioSystem.DataCase

  alias RadioSystem.RadioSystems

  describe "profiles" do
    alias RadioSystem.Radio.Profile

    @valid_attrs %{
      id: Ecto.UUID.generate(),
      alias: "INTERNATIONAL FM",
      allowed_locations: ["CPH-1", "CPH-2", "CPH-3"],
      radio_id: 100,
      location: nil
    }
    @update_attrs %{
      radio_id: 100,
      location: "CPH-1"
    }
    @invalid_attrs %{
      radio_id: 100,
      location: "CPH-4"
    }

    def profile_fixture(attrs \\ %{}) do
      {:ok, profile} =
        attrs
        |> Enum.into(@valid_attrs)
        |> RadioSystems.create_profile()

      profile
      |> Map.put(:location, "unknown")
    end

    test "get_profile!/1 returns the profile with given id" do
      profile = profile_fixture()
      assert RadioSystems.get_profile(profile.radio_id) == profile
    end

    test "create_profile/1 with valid data creates a profile" do
      assert {:ok, %Profile{} = profile} = RadioSystems.create_profile(@valid_attrs)
    end

    test "create_profile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = RadioSystems.create_profile(@invalid_attrs)
    end
  end
end
