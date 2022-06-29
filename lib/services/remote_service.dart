import 'dart:convert';
import 'package:covid/models/post.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<Welcome> getPosts() async {
    var a = await http.get(Uri.parse('https://api.covid19api.com/summary'));
    var welcome = Welcome.fromJson(jsonDecode(a.body) as Map<String, dynamic>);
    return welcome;
  }
}
