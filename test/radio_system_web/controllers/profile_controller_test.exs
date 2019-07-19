defmodule RadioSystemWeb.ProfileControllerTest do
  use RadioSystemWeb.ConnCase

  alias RadioSystem.RadioSystems
  alias RadioSystem.Radio.Profile

  @create_attrs %{
    "alias" => "INTERNATIONAL FM",
    "allowed_locations" => ["CPH-1", "CPH-2", "CPH-3"]
  }
  @update_attrs %{
    location: "CPH-2"
  }
  @invalid_attrs %{
    location: "CPH-4"
  }

  def fixture(:profile) do
    {:ok, profile} = RadioSystems.create_profile(@create_attrs)
    profile
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create profile" do
    test "renders profile when data is valid", %{conn: conn} do
      conn = post(conn, "/radios/101", @create_attrs)

      assert %{
               "id" => _,
               "radio_id" => _,
               "allowed_locations" => _,
               "alias" => _,
               "location" => _
             } = json_response(conn, 200)["data"]
    end
  end
end
