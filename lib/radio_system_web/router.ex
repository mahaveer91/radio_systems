defmodule RadioSystemWeb.Router do
  use RadioSystemWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RadioSystemWeb do
    pipe_through :api

    post "/radios/:id", ProfileController, :new_radio
    post "/radios/:id/location", ProfileController, :set_location
    get "/radios/:id/location", ProfileController, :get_location
  end
end
