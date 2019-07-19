defmodule RadioSystemWeb.ProfileView do
  use RadioSystemWeb, :view
  alias RadioSystemWeb.ProfileView

  def render("index.json", %{profiles: profiles}) do
    %{data: render_many(profiles, ProfileView, "profile.json")}
  end

  def render("show.json", %{profile: profile}) do
    %{data: render_one(profile, ProfileView, "profile.json")}
  end

  def render("profile.json", %{profile: profile}) do
    profile
  end

  def render("message.json", %{message: message}) do
    message
  end

  def render("location.json", %{location: location}) do
    %{location: location}
  end

  def render("error.json", %{message: message}) do
    message
  end
end
