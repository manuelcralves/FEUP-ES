import 'package:flutter/material.dart';
import '../../Artist/ArtistPage.dart';
import '../../Classes/Artist.dart';

class SearchGeneralArtists extends SearchDelegate<Artist> {
  Future<List<Artist>> artists;

  SearchGeneralArtists({required this.artists});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, Artist("", []));
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Artist>>(
      future: artists,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Artist> artistList = snapshot.data!;
          final List<Artist> filteredList = artistList
              .where((artist) =>
              artist.getName().toLowerCase().contains(query.toLowerCase()))
              .toList();

          return ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final Artist artist = filteredList[index];
              return ListTile(
                title: Text(artist.getName()),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArtistPage(artist: artist),
                    ),
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Artist>>(
      future: artists,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<Artist> artistList = snapshot.data!;
          final List<Artist> filteredList = artistList
              .where((artist) =>
              artist.getName().toLowerCase().contains(query.toLowerCase()))
              .toList();

          return ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final Artist artist = filteredList[index];
              return ListTile(
                title: Text(artist.getName()),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArtistPage(artist: artist),
                    ),
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
    );
  }
}
