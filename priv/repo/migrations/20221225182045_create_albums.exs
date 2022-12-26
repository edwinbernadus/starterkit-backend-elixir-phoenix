defmodule Hello.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :title, :string
      add :subtitle, :string
      add :privacy, :string

      timestamps()
    end
  end
end
