defmodule Sepomex.Repo.Migrations.ZipCodes do
  use Ecto.Migration

  def change do
    create table(:zip_codes) do
      add :d_codigo, :string
      add :d_asenta, :string
      add :d_tipo_asenta, :string
      add :d_mnpio, :string
      add :d_estado, :string
      add :d_ciudad, :string
      add :d_cp, :string
      add :c_estado, :string
      add :c_oficina, :string
      add :c_cp, :string
      add :c_tipo_asenta, :string
      add :c_mnpio, :string
      add :id_asenta_cpcons, :string
      add :d_zona, :string
      add :c_cve_ciudad, :string
    end
    create index("zip_codes", [:d_codigo])
    create index("zip_codes", [:d_ciudad])
    create index("zip_codes", [:d_estado])
    create index("zip_codes", [:d_asenta])
  end
end
