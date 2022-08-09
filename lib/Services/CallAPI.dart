import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_n_morty_fan_app/Models/Characters.dart';
import 'package:rick_n_morty_fan_app/Models/Page.dart';

String _url = "https://rickandmortyapi.com/api/";

Future<Character?> fetchChar(int id) async {
  try {
    var response = await http.get(Uri.parse("$_url/characters/$id"));

    // Check if status code anything but 200 (OK)
    if (response.statusCode != 200) {
      print("Couldn't get API Response ??");
      return null;
    }
    // else parse JSON to the Character class
    return Character.fromJson(jsonDecode(response.body));
  } catch (e) {
    print(e);
    return null;
  }
}

Future<Page?> fetchPage(int page) async {
  try {
    var response = await http.get(Uri.parse("$_url/character/?page=$page"));

    // Check if status code anything but 200 (OK)
    if (response.statusCode != 200) {
      print("Couldn't get API Response ??");
      return null;
    }
    // else parse JSON to the Character class
    return Page.fromJson(jsonDecode(response.body));
  } catch (e) {
    print(e);
    return null;
  }
}
