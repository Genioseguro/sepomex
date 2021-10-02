defmodule Sepomex.Repo.Migrations.CreateSearchVectorIndex do
  use Ecto.Migration

  def change do
    create index("zip_codes", ["search_vector"], using: :gin)
  end
end
