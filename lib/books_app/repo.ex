defmodule BooksApp.Repo do
  use Ecto.Repo,
    otp_app: :books_app,
    adapter: Ecto.Adapters.Postgres
end
