import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> fetchAlbums() async {
  const String apiKey = 'd991440835mshf17f92a25c1e4c0p1460d0jsn9b091a54a1f9';

  final response = await http.get(
    Uri.parse('https://glavier-spotify23.p.rapidapi.com/albums'),
    headers: {
      'X-RapidAPI-Key': apiKey,
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return jsonResponse['albums'];
  } else {
    throw Exception('Failed to fetch albums :(');
  }

  //Function to call albums
  /*void main() async {
  try {
    final albums = await fetchAlbums();
    // Handle the album information here
    for (var album in albums) {
      print(album['name']);
    }
  } catch (e) {
    print('Error: $e');
  }
}*/
}
