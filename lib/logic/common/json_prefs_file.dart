import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class JsonPrefsFile {
  JsonPrefsFile(this.name);
  final String name;

  Future<Map<String, dynamic>> load() async {
    final p = (await SharedPreferences.getInstance()).getString(name);
    //print('loaded: $p');
    return Map<String, dynamic>.from(jsonDecode(p ?? '{}'));
  }

  Future<void> save(Map<String, dynamic> data) async {
    //print('saving $data');
    await (await SharedPreferences.getInstance()).setString(name, jsonEncode(data));
  }
}
