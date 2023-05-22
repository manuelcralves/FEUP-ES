import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> fetchArtist(String artistId) async {
  const String apiKey = 'd991440835mshf17f92a25c1e4c0p1460d0jsn9b091a54a1f9';
  final String apiUrl = 'https://spotify23.p.rapidapi.com/artists/$artistId';

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': 'spotify23.p.rapidapi.com',
    },
  );

  if (response.statusCode == 200) {
    // Request successful, pass the response
    final jsonData = jsonDecode(response.body);
    return jsonData;
  } else {
    // Request failed :(
    throw Exception('Failed to load artist :(');
  }

  //function to call Artists
  /*void main() async {
  try {
    final artistId = 'ARTIST_ID'; // Replace with the artist ID you want to fetch
    final artistInfo = await fetchArtist(artistId);
    // Handle the artist information here
    print(artistInfo['name']);
    print(artistInfo['followers']['total']);
    print(artistInfo['genres']);
  } catch (e) {
    print('Error: $e');
  }
}*/
}
