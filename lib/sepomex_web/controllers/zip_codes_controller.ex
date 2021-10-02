defmodule SepomexWeb.ZipCodesController do
  import Ecto.Query, warn: false
  use SepomexWeb, :controller

  alias Sepomex.Catalog.ZipCodes
  alias Sepomex.Catalog

  action_fallback SepomexWeb.FallbackController

  def index(conn, params) do
    zip_codes = case params do
      %{"zip_code" => zip_code, } -> Catalog.find_by_d_codigo(zip_code)
      %{"city" => city} -> Catalog.find_by_d_ciudad(city)
      %{"state" => state} -> Catalog.find_by_d_estado(state)
      %{"colony" => colony} -> Catalog.find_by_d_asenta(colony)
      _ -> ZipCodes
    end
    |> Sepomex.Repo.paginate(params)

    render(conn, "index.json", %{zip_codes: zip_codes, conn: conn})
  end
end
