defmodule Hello.AlbumModuleTest do
  use Hello.DataCase

  alias Hello.AlbumModule

  describe "albums" do
    alias Hello.AlbumModule.Album

    import Hello.AlbumModuleFixtures

    @invalid_attrs %{privacy: nil, subtitle: nil, title: nil}

    test "list_albums/0 returns all albums" do
      album = album_fixture()
      assert AlbumModule.list_albums() == [album]
    end

    test "get_album!/1 returns the album with given id" do
      album = album_fixture()
      assert AlbumModule.get_album!(album.id) == album
    end

    test "create_album/1 with valid data creates a album" do
      valid_attrs = %{privacy: "some privacy", subtitle: "some subtitle", title: "some title"}

      assert {:ok, %Album{} = album} = AlbumModule.create_album(valid_attrs)
      assert album.privacy == "some privacy"
      assert album.subtitle == "some subtitle"
      assert album.title == "some title"
    end

    test "create_album/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AlbumModule.create_album(@invalid_attrs)
    end

    test "update_album/2 with valid data updates the album" do
      album = album_fixture()
      update_attrs = %{privacy: "some updated privacy", subtitle: "some updated subtitle", title: "some updated title"}

      assert {:ok, %Album{} = album} = AlbumModule.update_album(album, update_attrs)
      assert album.privacy == "some updated privacy"
      assert album.subtitle == "some updated subtitle"
      assert album.title == "some updated title"
    end

    test "update_album/2 with invalid data returns error changeset" do
      album = album_fixture()
      assert {:error, %Ecto.Changeset{}} = AlbumModule.update_album(album, @invalid_attrs)
      assert album == AlbumModule.get_album!(album.id)
    end

    test "delete_album/1 deletes the album" do
      album = album_fixture()
      assert {:ok, %Album{}} = AlbumModule.delete_album(album)
      assert_raise Ecto.NoResultsError, fn -> AlbumModule.get_album!(album.id) end
    end

    test "change_album/1 returns a album changeset" do
      album = album_fixture()
      assert %Ecto.Changeset{} = AlbumModule.change_album(album)
    end
  end
end
