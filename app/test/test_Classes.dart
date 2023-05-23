import 'package:app/Classes/Album.dart';
import 'package:app/Classes/Artist.dart';
import 'package:app/Classes/Comment.dart';
import 'package:app/Classes/Music.dart';
import 'package:app/Classes/Playlist.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("AlbumClassTest", ()
  {
    test('Album getters and setters', () {
      // Arrange
      final album = Album(1, 'Album Name', 'Artist Name');

      // Act
      final idAlbum = album.getIdAlbum();
      final artist = album.getArtist();
      final name = album.getName();

      // Assert
      expect(idAlbum, 1);
      expect(artist, 'Artist Name');
      expect(name, 'Album Name');
    });

    test('Album setters', () {
      // Arrange
      final album = Album(1, 'Album Name', 'Artist Name');

      // Act
      album.setIdAlbum(2);
      album.setArtist('New Artist');
      album.setName('New Album');

      // Assert
      expect(album.getIdAlbum(), 2);
      expect(album.getArtist(), 'New Artist');
      expect(album.getName(), 'New Album');
    });
  });
  group('ArtistClassTest', () {
    test('Artist getters and setters', () {
      final musics = [1, 2, 3];
      final artist = Artist('Artist Name', musics);

      final name = artist.getName();
      final artistMusics = artist.getMusics();

      expect(name, 'Artist Name');
      expect(artistMusics, musics);
    });

    test('Artist setters', () {
      final musics = [1, 2, 3];
      final artist = Artist('Artist Name', musics);

      final newMusics = [4, 5, 6];
      artist.setName('New Artist');
      artist.setMusics(newMusics);

      expect(artist.getName(), 'New Artist');
      expect(artist.getMusics(), newMusics);
    });
  });
  group('PlaylistClassTest', () {
    test('Playlist getters and setters', () {
      final musics = [1, 2, 3];
      final playlist = Playlist('Playlist Title', musics);

      final title = playlist.getTitle();
      final playlistMusics = playlist.getMusics();

      expect(title, 'Playlist Title');
      expect(playlistMusics, musics);
    });

    test('Playlist setters', () {
      final musics = [1, 2, 3];
      final playlist = Playlist('Playlist Title', musics);

      final newMusics = [4, 5, 6];
      playlist.setTitle('New Playlist');
      playlist.setMusics(newMusics);

      expect(playlist.getTitle(), 'New Playlist');
      expect(playlist.getMusics(), newMusics);
    });
  });
  group('MusicClassTest', () {
    test('Music getters and setters', () {
      final music = Music(1, 'Music Name', 'Artist Name', 1, 'Lyrics');

      final idMusic = music.getIdMusic();
      final name = music.getName();
      final artist = music.getArtist();
      final album = music.getAlbum();
      final lyrics = music.getLyrics();

      expect(idMusic, 1);
      expect(name, 'Music Name');
      expect(artist, 'Artist Name');
      expect(album, 1);
      expect(lyrics, 'Lyrics');
    });

    test('Music setters', () {
      final music = Music(1, 'Music Name', 'Artist Name', 1, 'Lyrics');

      music.setIdMusic(2);
      music.setName('New Music');
      music.setArtist('New Artist');
      music.setAlbum(2);
      music.setLyrics('New Lyrics');

      expect(music.getIdMusic(), 2);
      expect(music.getName(), 'New Music');
      expect(music.getArtist(), 'New Artist');
      expect(music.getAlbum(), 2);
      expect(music.getLyrics(), 'New Lyrics');
    });
  });
  group('CommentClassTest', () {
    test('Comment getters and setters', () {
      final comment = Comment('email@example.com', 'This is a comment');

      final email = comment.getEmail();
      final commentText = comment.getComment();

      expect(email, 'email@example.com');
      expect(commentText, 'This is a comment');
    });

    test('Comment setters', () {
      final comment = Comment('email@example.com', 'This is a comment');

      comment.setUser('newemail@example.com');
      comment.setArtist('New comment');

      expect(comment.getEmail(), 'newemail@example.com');
      expect(comment.getComment(), 'New comment');
    });
  });
}