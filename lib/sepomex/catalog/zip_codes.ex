defmodule Sepomex.Catalog.ZipCodes do
  use Ecto.Schema

  schema "zip_codes" do
    field :d_codigo, :string
    field :d_asenta, :string
    field :d_tipo_asenta, :string
    field :d_mnpio, :string
    field :d_estado, :string
    field :d_ciudad
    field :d_cp, :string
    field :c_estado, :string
    field :c_oficina, :string
    field :c_cp
    field :c_tipo_asenta, :string
    field :c_mnpio, :string
    field :id_asenta_cpcons, :string
    field :d_zona, :string
    field :c_cve_ciudad
  end
end
