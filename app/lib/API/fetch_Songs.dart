import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> fetchSongs() async {
  const String apiKey = 'd991440835mshf17f92a25c1e4c0p1460d0jsn9b091a54a1f9';
  const String apiUrl = 'https://spotify23.p.rapidapi.com/songs';

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
    throw Exception('Failed to load songs :(');
  }
}
