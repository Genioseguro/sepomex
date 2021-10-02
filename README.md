# Sepomex

Sepomex is a REST API build in elixir that maps all the data from the current zip codes in Mexico. You can get the CSV or Excel files from the [official site](https://www.correosdemexico.gob.mx/SSLServicios/ConsultaCP/CodigoPostal_Exportar.aspx)

We build this API in order to provide a way to developers query the zip codes, states and municipalities across the country.

## Table of contents

- [Quick start](#quick-start)
- [Querying the API](#querying-the-api)
- [About pagination](#about-pagination)


## Quick start

The base URI to start consuming the JSON response is under:

```bash
http://localhost:4000/api/v1/zip_codes
```

There are currently `146,934` records on the database which were extracted from the CSV file included in the project.

Records are paginated with **50** records per page.

### Running the project
#### 1. Install libraries
```bash
mix deps.get
```
#### 2. Configure Database `config/dev.exs`
```elixir
config :sepomex, Sepomex.Repo,
  username: "USERNAME",
  password: "PASSWORD",
  database: "sepomex_dev",
  hostname: "localhost",
  ...
```
#### 3. Create Database and migrations
```bash
mix ecto.setup
```
#### 4. Start server
```bash
mix phx.server
```

## Querying the API

We currently provide 1 kind of resources:

- **Zip Codes**: [http://localhost:4000/zip_codes](http://localhost:4000/api/v1/zip_codes)
### ZipCodes

In order to provide more flexibility to search a zip code, whether is by city, colony, state or zip code you can now send multiple parameters to make the appropiate search. You can fetch the:

#### all

```bash
curl -X GET http://localhost:4000/api/v1/zip_codes 
```

##### Response

```json
{
  "zip_codes": [
    {
      "id": 1,
      "d_codigo": "01000",
      "d_asenta": "San Ángel",
      "d_tipo_asenta": "Colonia",
      "d_mnpio": "Álvaro Obregón",
      "d_estado": "Ciudad de México",
      "d_ciudad": "Ciudad de México",
      "d_cp": "01001",
      "c_estado": "09",
      "c_oficina": "01001",
      "c_cp": null,
      "c_tipo_asenta": "09",
      "c_mnpio": "010",
      "id_asenta_cpcons": "0001",
      "d_zona": "Urbano",
      "c_cve_ciudad": "01"
    },
    ... 
  ],
  "meta": {
    "pagination": {
      "per_page": 15,
      "total_pages": 9728,
      "total_objects": 145906,
      "links": {
        "first": "/zip_code?page=1",
        "last": "/zip_code?page=9728",
        "next": "/zip_code?page=2"
      }
    }
  }
}
```

#### by city

```bash
curl -X GET http://localhost:4000/api/v1/zip_codes?city=monterrey
```

#### by state

```bash
curl -X GET http://localhost:4000/api/v1/zip_codes?state=nuevo%20leon
```

#### by colony

```bash
curl -X GET http://localhost:4000/api/v1/zip_codes?colony=punta%20contry
```

#### by cp

```bash
curl -X GET http://localhost:4000/api/v1/zip_codes?zip_code=67173
```
**Where:**

- ``per_page`` is the amount of elements per page.
- ``total_pages`` is the total number of pages.
- ``total_objects`` is the total objects of all pages.
- ``links`` contains links for pages.
  - ``first``is the url for the first page.
  - ``last`` is the url for the last page.
  - ``prev`` is the url for the previous page.
  - ``next`` is the url for the next page.
