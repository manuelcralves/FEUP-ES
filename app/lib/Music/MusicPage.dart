import 'package:flutter/material.dart';

import '../Classes/Music.dart';
import '../Templates/Templates.dart';

class MusicPage extends StatefulWidget {
  final Music music;

  MusicPage({required this.music});

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  bool _isCommentSectionExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Templates.AppbarSpotivibes(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.music.getName(),
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
                    widget.music.getArtist(),
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
                    widget.music.getAlbum().toString(),
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
                    widget.music.getLyrics(),
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isCommentSectionExpanded = !_isCommentSectionExpanded;
              });
            },
            child: Container(
              height: 50,
              color: Colors.grey[200],
              child: ListTile(
                title: Text('Comentários'),
                trailing: Icon(_isCommentSectionExpanded
                    ? Icons.expand_less
                    : Icons.expand_more),
              ),
            ),
          ),
          if (_isCommentSectionExpanded)
            Container(
              color: Colors.grey[300],
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Text('Espaço para Comentários'),
              ),
            ),
        ],
      ),
    );
  }
}
