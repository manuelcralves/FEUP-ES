import 'package:app/Music/Music_Backend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Artist/Artist_Backend.dart';
import '../../Classes/Artist.dart';
import '../../Artist/ArtistPage.dart';
import '../../Templates/Templates.dart';
import '../../Search/Search_Bar/Search_General_Artists.dart';

class Search_General_Artists_Frontend extends StatelessWidget {
  late Future<List<Artist>> artists = Artist_Backend.getAllArtistsFromDatabase();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Templates.AppbarSpotivibes(),
      body: Column(
        children: [
          Templates.Search_Options(context),
          Templates.SubTitle("Artists"),
          ElevatedButton.icon(
            icon: const Icon(Icons.search),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white38,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(60))),
              alignment: Alignment.centerLeft,
              fixedSize: const Size(313,17),
            ),
            label: const Text('Search'),
            onPressed: () {
              showSearch(context: context, delegate: SearchGeneralArtists(artists: artists));

            },
          ),
          Expanded(
            child: FutureBuilder<List<Artist>>(
              future: artists,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<Artist> artistList = snapshot.data!;
                  return ListView.builder(
                    itemCount: artistList.length,
                    itemBuilder: (context, index) {
                      Artist artist = artistList[index];
                      return ListTile(
                        title: Text(artist.getName()),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ArtistPage(artist: artist)),
                          );
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error loading artists');
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Templates.Footer(context),
    );
  }
}
