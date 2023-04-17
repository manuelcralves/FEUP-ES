

import 'package:app/HomePage/HomePage.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group('PlaylistAdd',(){
    test('list should start empty',(){
      expect(HomePage().playlist_list.length==0, true);
    });
    test('Added playlist to my list that is not empty',(){
      HomePage home = HomePage();
      home.playlist_add("dnahdheh");
      expect(home.playlist_list.length, 1);
    });
    test('Added playlist to my list that empty',(){
      HomePage home = HomePage();
      home.playlist_add("");
      expect(home.playlist_list.length, 0);
    });
    test('Added and trying remove playlist, first with a name that is not on the list and then with a name on the list',(){
      HomePage home = HomePage();
      home.playlist_add("abcde");
      expect(home.playlist_list.length, 1);
      home.playlist_remove("abcdfgahsbhd");
      expect(home.playlist_list.length, 1);
      home.playlist_remove("abcde");
      expect(home.playlist_list.length, 0);
    });
  });
}