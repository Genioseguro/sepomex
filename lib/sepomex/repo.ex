defmodule Sepomex.Repo do
  use Ecto.Repo,
    otp_app: :sepomex,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 50 
end
