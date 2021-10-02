defmodule SepomexWeb.ZipCodesView do
  use SepomexWeb, :view
  alias SepomexWeb.ZipCodesView

  def render("index.json", %{zip_codes: zip_codes, conn: conn}) do
    %{
      zip_codes: render_many(zip_codes, ZipCodesView, "zip_codes.json"),
      meta: %{
        pagination: %{
          per_page: length(zip_codes.entries),
          total_pages: zip_codes.total_pages,
          total_objects: zip_codes.total_entries,
          links: paginator_helper(zip_codes.total_pages, conn)
        }
      }
    }
  end

  def render("show.json", %{zip_codes: zip_codes}) do
    %{zip_codes: render_many(zip_codes, ZipCodesView, "zip_codes.json")}
  end

  def render("zip_codes.json", %{zip_codes: zip_codes}) do
    %{
      id: zip_codes.id,
      d_codigo: zip_codes.d_codigo,
      d_asenta: zip_codes.d_asenta,
      d_tipo_asenta: zip_codes.d_tipo_asenta,
      d_mnpio: zip_codes.d_mnpio,
      d_estado: zip_codes.d_estado,
      d_ciudad: zip_codes.d_ciudad,
      d_cp: zip_codes.d_cp,
      c_estado: zip_codes.c_estado,
      c_oficina: zip_codes.c_oficina,
      c_cp: zip_codes.c_cp,
      c_tipo_asenta: zip_codes.c_tipo_asenta,
      c_mnpio: zip_codes.c_mnpio,
      id_asenta_cpcons: zip_codes.id_asenta_cpcons,
      d_zona: zip_codes.d_zona,
      c_cve_ciudad: zip_codes.c_cve_ciudad
    }
  end

  defp paginator_helper(total_pages, conn) do
    case Map.to_list(conn.params) do
      [{"page" , page},{key ,value}] -> 
        %{
          first: "/api/v1/zip_codes?page=1",
          last: "/api/v1/zip_codes?page=#{total_pages}&#{key}=#{value}",
          prev: "/api/v1/zip_codes?#{prev_page?(page)}&#{key}=#{value}",
          next: "/api/v1/zip_codes?#{next_page?(page, total_pages)}&#{key}=#{value}"
        }
      [{key, value}, {"page" , page}] -> 
        %{
          first: "/api/v1/zip_codes?page=1",
          last: "/api/v1/zip_codes?page=#{total_pages}&#{key}=#{value}",
          prev: "/api/v1/zip_codes?#{prev_page?(page)}&#{key}=#{value}",
          next: "/api/v1/zip_codes?#{next_page?(page, total_pages)}&#{key}=#{value}"
        }
      [{key, value}] ->
        case key do
          "page" -> 
            %{
              first: "/api/v1/zip_codes?page=1",
              last: "/api/v1/zip_codes?page=#{total_pages}",
              prev: "/api/v1/zip_codes?#{prev_page?(value)}",
              next: "/api/v1/zip_codes?#{next_page?(value, total_pages)}"
            }
          _ -> 
            %{
              first: "/api/v1/zip_codes?#{key}=#{value}",
              last: "/api/v1/zip_codes?page=#{total_pages}&#{key}=#{value}",
              next: "/api/v1/zip_codes?page=2&#{key}=#{value}"
            }
        end 
        [] -> 
        %{
          first: "/api/v1/zip_codes?page=1",
          last: "/api/v1/zip_codes?page=#{total_pages}",
          next: "/api/v1/zip_codes?page=2"
        }
    end
  end

  defp next_page?(page_number, total_pages) do
    case String.to_integer(page_number) != total_pages do
      true -> "page=#{String.to_integer(page_number) + 1}"
      false -> "" 
    end
  end

  defp prev_page?(page_number) do
    case String.to_integer(page_number) == 1 do
      true -> "" 
      false -> "page=#{String.to_integer(page_number) - 1}"
    end
  end
end
