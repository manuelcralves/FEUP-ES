import 'package:flutter/material.dart';
import '../Classes/Artist.dart';
import '../Classes/Music.dart';
import '../Artist/Artist_Backend.dart';

class ArtistPage extends StatelessWidget {
  final Artist artist;

  ArtistPage({required this.artist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artist.getName()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              artist.getName(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            FutureBuilder<List<Music>>(
              future: Artist_Backend.getArtistMusics(artist.getMusics()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error loading musics');
                } else if (snapshot.hasData) {
                  final musics = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: musics.length,
                    itemBuilder: (context, index) {
                      final music = musics[index];
                      return ListTile(
                        title: Text(
                          music.getName(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(music.getAlbum().toString()),
                        onTap: () {
                          // Handle music selection or navigate to music details page
                          // Example: Navigator.pushNamed(context, '/music_details', arguments: music);
                        },
                      );
                    },
                  );
                } else {
                  return Text('No musics found');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
