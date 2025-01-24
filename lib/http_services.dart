import 'dart:convert';
import 'package:http/http.dart';
import 'post_model.dart';

class HttpService {
  final String surahURL = "http://api.alquran.cloud/v1/surah";

  Future<List<Post>> getPosts() async {
    try {
      Response res = await get(Uri.parse(surahURL));
      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);
        List<Post> posts = (data['data'] as List).map((item) => Post.fromJson(item)).toList();
        return posts;
      } else {
        print("Error: ${res.statusCode}, ${res.body}");
        throw "Tidak dapat mengambil data surah";
      }
    } catch (e) {
      print("kesalahan saat mengambil data: $e");
      throw e;
    }
  }

  Future<Post> getSurahDetail(int surahNumber) async {
    try {
      final String url = "$surahURL/$surahNumber";
      Response res = await get(Uri.parse(url));
      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);
        return Post.fromJson(data['data']);
      } else {
        print("Error: ${res.statusCode}, ${res.body}");
        throw "Tidak dapat mengambil detail surah";
      }
    } catch (e) {
      print("kesalahan saat mengambil detail: $e");
      throw e;
    }
  }
}
