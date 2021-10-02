# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Sepomex.Repo.insert!(%Sepomex.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
#
#

#res = File.stream!("./priv/repo/zip_codes_catalog.csv")
#|> Enum.map(fn row -> Codepagex.to_string!(row, :iso_8859_1) end)

#File.write!("./priv/repo/zip_codes_catalog_utf8.csv", res)


{:ok, pid} = :sepomex
             |> Application.get_env(Sepomex.Repo)
             |> Postgrex.start_link()

Postgrex.transaction(pid, fn conn ->
  pg_copy = Postgrex.stream(conn, "COPY zip_codes(
           d_codigo,
           d_asenta,
           d_tipo_asenta,
           d_mnpio,
           d_estado,
           d_ciudad,
           d_cp,
           c_estado,
           c_oficina,
           c_cp,
           c_tipo_asenta,
           c_mnpio,
           id_asenta_cpcons,
           d_zona,
           c_cve_ciudad
          ) FROM STDIN DELIMITER '|'", [])
  "./priv/repo/zip_codes_catalog_utf8.csv" 
  |> File.stream!()
  |> Enum.into(pg_copy)
end, [timeout: 1_000_000])
