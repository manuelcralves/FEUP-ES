import 'package:flutter/material.dart';

import '../Classes/Music.dart';

class MusicPage extends StatelessWidget {
  final Music music;

  MusicPage({required this.music});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Page'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              music.getName(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Artist:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              music.getArtist(),
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Album:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              music.getAlbum().toString(),
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Lyrics:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              music.getLyrics(),
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
