defmodule RadioSystem.RadioSystems do
  @moduledoc """
  The RadioSystems context.
  """

  import Ecto.Query, warn: false
  alias RadioSystem.Repo

  alias RadioSystem.Radio.Profile

  @doc """
  Gets a single profile.

  Raises if the Profile does not exist.

  ## Examples

      iex> get_profile!(123)
      %Profile{}

  """
  def get_profile(id), do: Repo.get_by(Profile, [radio_id: id])

  @doc """
  Creates a profile.

  ## Examples

      iex> create_profile(%{field: value})
      {:ok, %Profile{}}

      iex> create_profile(%{field: bad_value})
      {:error, ...}

  """
  def create_profile(attrs \\ %{}) do
    %Profile{}
    |> Profile.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a profile.

  ## Examples

      iex> update_profile(profile, %{field: new_value})
      {:ok, %Profile{}}

      iex> update_profile(profile, %{field: bad_value})
      {:error, ...}

  """
  def update_profile(attrs) do
    with %Profile{} = profile <- get_profile(attrs["id"]),
         true <- Enum.member?(profile.allowed_locations, attrs["location"]) do
        profile
        |> Ecto.Changeset.change(location: attrs["location"])
        |> Repo.update()
    else
      {:error, changeset} -> {:error, changeset}
      nil -> {:error, :unknown_profile}
      false -> {:error, :invalid_location}
    end
  end
end
