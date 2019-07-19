defmodule RadioSystemWeb.ProfileController do
  use RadioSystemWeb, :controller

  alias RadioSystem.RadioSystems
  alias RadioSystem.Radio.Profile
  alias RadioSystemWeb.ErrorHelpers

  action_fallback RadioSystemWeb.FallbackController

  @doc """
  To create a New Radio Profile, send the id in url path and other params as JSON body
  """
  def new_radio(conn, %{"id" => id} = params) do
    {int_id, _} = Integer.parse(id)
    params =
      params
      |> Map.put("radio_id", int_id)

    with {:ok, %Profile{} = profile} <- RadioSystems.create_profile(params) do
      conn
      |> put_status(200)
      |> render("show.json", profile: profile)
    else
      {:error, changeset} ->
        conn
        |> put_status(:bad_request)
        |> put_view(RadioSystemWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end

  @doc """
  To set the location of a particular radio, send the id in URL path and Location as JSON body
  """
  def set_location(conn, %{"id" => id} = params) do
    with {:ok, %Profile{} = profile} <- RadioSystems.update_profile(params) do
      conn
      |> put_status(200)
      |> render("message.json", message: "Location set successfully")
    else
      {:error, :unknown_profile} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", message: "Radio Profile is not present!")
      {:error, :invalid_location} ->
        conn
        |> put_status(:forbidden)
        |> render("error.json", message: "Invalid Location")
      {:error, changeset} ->
        conn
        |> put_status(:bad_request)
        |> put_view(RadioSystemWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end

  @doc """
  To get the location of a particular Radio Profile
  """
  def get_location(conn, %{"id" => id} = params) do
    with %Profile{} = profile <- RadioSystems.get_profile(id),
         true <- profile.location != "unknown" do
      conn
      |> put_status(200)
      |> render("location.json", location: profile.location)
    else
      false ->
        conn
        |> put_status(404)
        |> render("error.json", message: "NOT FOUND")
      nil ->
        conn
        |> put_status(404)
        |> render("error.json", message: "Radio Profile is not Present!")
    end
  end
end
