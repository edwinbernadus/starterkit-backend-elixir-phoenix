defmodule Hello.AlbumModule.Album do
  use Ecto.Schema
  import Ecto.Changeset

  schema "albums" do
    field :privacy, :string
    field :subtitle, :string
    field :title, :string

    timestamps()
  end


  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:title, :subtitle, :privacy])
    |> validate_required([:title, :subtitle, :privacy])
  end
end
