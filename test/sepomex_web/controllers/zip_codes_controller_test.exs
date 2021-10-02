defmodule SepomexWeb.ZipCodesControllerTest do
  use SepomexWeb.ConnCase
  alias SepomexWeb.Router.Helpers
  alias SepomexWeb.Endpoint

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all zip_codes", %{conn: conn} do
      response = conn 
             |> get(Routes.zip_codes_path(conn, :index))
             |> Map.get(:resp_body) 
             |> Poison.decode!

      assert response["zip_codes"] |> length == 50
      assert response["meta"]["pagination"]["total_objects"] == 146934
      assert response["meta"]["pagination"]["total_pages"] == 2939
    end

    test "lists all zip_codes with the same zip_code", %{conn: conn} do
      response = conn
             |> get(Helpers.zip_codes_path(Endpoint, :index, zip_code: 57460))
             |> Map.get(:resp_body)
             |> Poison.decode!

      [address] = response["zip_codes"]
      assert address["d_codigo"] == "57460"
      assert address["d_ciudad"] == "Ciudad Nezahualcóyotl"
      assert response["zip_codes"] |> length == 1
    end

    test "return a list empty when zip_code not exist", %{conn: conn} do
      response = conn
             |> get(Helpers.zip_codes_path(Endpoint, :index, zip_code: 00000))
             |> Map.get(:resp_body)
             |> Poison.decode!
      assert response["zip_codes"] |> Enum.empty? == true
    end

    test "lists all address with the colony similarity", %{conn: conn} do
      response = conn
             |> get(Helpers.zip_codes_path(Endpoint, :index, colony: "cuauhtemoc"))
             |> Map.get(:resp_body)
             |> Poison.decode!
      assert response["zip_codes"] |> length == 50
    end

    test "lists all address with same state", %{conn: conn} do
      response = conn
             |> get(Helpers.zip_codes_path(Endpoint, :index, state: "ciudad de mexico"))
             |> Map.get(:resp_body)
             |> Poison.decode!
      assert response["zip_codes"] |> length == 50
    end

    test "lists all address with city", %{conn: conn} do
      response = conn
             |> get(Helpers.zip_codes_path(Endpoint, :index, city: "aguascaliente"))
             |> Map.get(:resp_body)
             |> Poison.decode!
      assert response["zip_codes"] |> length == 50
    end
  end
end
