import 'dart:math';

import 'package:app/Music/Music_Backend.dart';
import 'package:app/Playlist/Playlist_Backend.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Firebase.initializeApp();
  group('Music_Backend', () {
    test('getMusicById returns music when it exists', () async {
      final musicId = 1;
      final music = await Music_Backend.getMusicById(musicId);

      expect(music, isNotNull);
      expect(music!.getIdMusic(), equals(musicId));
    });

  test('getMusicById returns null when music does not exist', () async {
    final musicId = 999;
    final music = await Music_Backend.getMusicById(musicId);

    expect(music, isNull);
  });

  test('getAllMusicsFromDatabase returns a list of musics', () async {
    final musics = await Music_Backend.getAllMusicsFromDatabase();
    expect(musics, isNotEmpty);
    expect(musics.length, greaterThan(5));
  });

  test('getAllMusicsNotInPlaylist returns musics not in playlist', () async {
    final playlistName = 'My Playlist';
    final musics = await Music_Backend.getAllMusicsNotInPlaylist(playlistName);

    expect(musics, isNotEmpty);
    });
  });
  group('PlaylistBackendClassTest', () {
    test('addPlaylistToFirebase adds playlist to Firebase', () async {
      final playlist = Playlist_Backend('My Playlist', [1, 2, 3]);
      await playlist.addPlaylistToFirebase();

      expect(await Playlist_Backend.getMusicsFromPlaylist('My Playlist'), [1, 2, 3]);
    });

    test('getPlaylistsFromFirebase returns a stream of playlists', () {
      final playlistsStream = Playlist_Backend.getPlaylistsFromFirebase();

    });

    test('getMusicsFromPlaylist returns musics from playlist', () async {
      final playlistName = 'My Playlist';
      final musics = await Playlist_Backend.getMusicsFromPlaylist(playlistName);

    });
  });
  }