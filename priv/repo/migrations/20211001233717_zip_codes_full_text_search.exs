defmodule Sepomex.Repo.Migrations.ZipCodesFullTextSearch do
  use Ecto.Migration

  def up do
    alter table(:zip_codes) do
      add :search_vector, :tsvector
    end

    execute "
    CREATE EXTENSION pg_trgm;
    "
    execute "
    CREATE INDEX ON zip_codes USING gin
    ((d_codigo || ' ' || d_ciudad || ' ' || d_estado || ' ' || d_asenta) gin_trgm_ops);
    "

    execute "
    CREATE OR REPLACE FUNCTION zip_code_search_trigger() RETURNS trigger AS $$
     begin
         new.search_vector :=
         to_tsvector('simple', coalesce(new.d_codigo,'')) ||
         to_tsvector('simple', coalesce(new.d_ciudad,'')) ||
         to_tsvector('simple', coalesce(new.d_estado,'')) ||
         to_tsvector('simple', coalesce(new.d_asenta,''));
       return new;
     end
     $$ LANGUAGE plpgsql
    "

    execute "
    CREATE TRIGGER zip_code_search_update 
    BEFORE INSERT OR UPDATE OF d_codigo, d_ciudad, d_estado, d_asenta
    ON zip_codes 
    FOR EACH ROW EXECUTE PROCEDURE zip_code_search_trigger()
    "
  end
end
