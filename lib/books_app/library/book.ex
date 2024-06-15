defmodule BooksApp.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :description, :string
    field :title, :string
    field :author, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :description])
    |> validate_required([:title, :author, :description])
  end
end
