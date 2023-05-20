import 'package:flutter/material.dart';

class PlaylistPage extends StatelessWidget {
  final String title;
  final String creator;

  PlaylistPage({required this.title, required this.creator});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Playlist created by: $creator'),
      ),
    );
  }
}
