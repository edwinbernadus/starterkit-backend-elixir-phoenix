defmodule Hello.AlbumModuleFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hello.AlbumModule` context.
  """

  @doc """
  Generate a album.
  """
  def album_fixture(attrs \\ %{}) do
    {:ok, album} =
      attrs
      |> Enum.into(%{
        privacy: "some privacy",
        subtitle: "some subtitle",
        title: "some title"
      })
      |> Hello.AlbumModule.create_album()

    album
  end
end
