defmodule Sepomex.Catalog do
  @similarity 0.5
  @moduledoc """
  The Catalog context.
  """

  import Ecto.Query, warn: false
  alias Sepomex.Repo

  alias Sepomex.Catalog.ZipCodes

  @doc """
  Returns the list of zip_codes.

  ## Examples

      iex> list_zip_codes()
      [%ZipCodes{}, ...]

  """
  def list_zip_codes do
    Repo.all(ZipCodes)
  end

  def find_by_d_codigo(term) do
    select(ZipCodes, %{
      id: fragment("id"),
      d_codigo: fragment("d_codigo"),
      d_asenta: fragment("d_asenta"),
      d_tipo_asenta: fragment("d_tipo_asenta"),
      d_mnpio: fragment("d_mnpio"),
      d_estado: fragment("d_estado"),
      d_ciudad: fragment("d_ciudad"),
      d_cp: fragment("d_cp"),
      c_estado: fragment("c_estado"),
      c_oficina: fragment("c_oficina"),
      c_cp: fragment("c_cp"),
      c_tipo_asenta: fragment("c_tipo_asenta"),
      c_mnpio: fragment("c_mnpio"),
      id_asenta_cpcons: fragment("id_asenta_cpcons"),
      d_zona: fragment("d_zona"),
      c_cve_ciudad: fragment("c_cve_ciudad"),
    })
    |> where(fragment("d_codigo = ?", ^term))
    |> order_by(fragment("(d_codigo) <-> ?", ^term))
  end

  def find_by_d_ciudad(term) do
    select(ZipCodes, %{
      id: fragment("id"),
      d_codigo: fragment("d_codigo"),
      d_asenta: fragment("d_asenta"),
      d_tipo_asenta: fragment("d_tipo_asenta"),
      d_mnpio: fragment("d_mnpio"),
      d_estado: fragment("d_estado"),
      d_ciudad: fragment("d_ciudad"),
      d_cp: fragment("d_cp"),
      c_estado: fragment("c_estado"),
      c_oficina: fragment("c_oficina"),
      c_cp: fragment("c_cp"),
      c_tipo_asenta: fragment("c_tipo_asenta"),
      c_mnpio: fragment("c_mnpio"),
      id_asenta_cpcons: fragment("id_asenta_cpcons"),
      d_zona: fragment("d_zona"),
      c_cve_ciudad: fragment("c_cve_ciudad"),
    })
    |> where(fragment("similarity(d_ciudad, ?) > ?", ^term, ^@similarity))
    |> order_by(fragment("(d_ciudad) <-> ?", ^term))
  end

  def find_by_d_estado(term) do
    select(ZipCodes, %{
      id: fragment("id"),
      d_codigo: fragment("d_codigo"),
      d_asenta: fragment("d_asenta"),
      d_tipo_asenta: fragment("d_tipo_asenta"),
      d_mnpio: fragment("d_mnpio"),
      d_estado: fragment("d_estado"),
      d_ciudad: fragment("d_ciudad"),
      d_cp: fragment("d_cp"),
      c_estado: fragment("c_estado"),
      c_oficina: fragment("c_oficina"),
      c_cp: fragment("c_cp"),
      c_tipo_asenta: fragment("c_tipo_asenta"),
      c_mnpio: fragment("c_mnpio"),
      id_asenta_cpcons: fragment("id_asenta_cpcons"),
      d_zona: fragment("d_zona"),
      c_cve_ciudad: fragment("c_cve_ciudad"),
    })
    |> where(fragment("similarity(d_estado, ?) > ?", ^term, ^@similarity))
    |> order_by(fragment("(d_estado) <-> ?", ^term))
  end

  def find_by_d_asenta(term) do
    select(ZipCodes, %{
      id: fragment("id"),
      d_codigo: fragment("d_codigo"),
      d_asenta: fragment("d_asenta"),
      d_tipo_asenta: fragment("d_tipo_asenta"),
      d_mnpio: fragment("d_mnpio"),
      d_estado: fragment("d_estado"),
      d_ciudad: fragment("d_ciudad"),
      d_cp: fragment("d_cp"),
      c_estado: fragment("c_estado"),
      c_oficina: fragment("c_oficina"),
      c_cp: fragment("c_cp"),
      c_tipo_asenta: fragment("c_tipo_asenta"),
      c_mnpio: fragment("c_mnpio"),
      id_asenta_cpcons: fragment("id_asenta_cpcons"),
      d_zona: fragment("d_zona"),
      c_cve_ciudad: fragment("c_cve_ciudad"),
    })
    |> where(fragment("similarity(d_asenta, ?) > ?", ^term, ^@similarity))
    |> order_by(fragment("(d_asenta) <-> ?", ^term))
  end

  @doc """
  Gets a single zip_codes.

  Raises `Ecto.NoResultsError` if the Zip codes does not exist.

  ## Examples

      iex> get_zip_codes!(123)
      %ZipCodes{}

      iex> get_zip_codes!(456)
      ** (Ecto.NoResultsError)

  """
  def get_zip_codes!(id), do: Repo.get!(ZipCodes, id)
  def get_zip_codes_by_zip_code(zip_code) do
    query = from z in ZipCodes, where: z.d_codigo == ^zip_code
    Repo.all(query)
  end
end

