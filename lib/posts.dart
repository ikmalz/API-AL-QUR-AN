import 'package:flutter/material.dart';
import 'http_services.dart';
import 'post_model.dart';
import 'surah_detail.dart';

class PostsPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Surah Al-qur'an"),
      ),
      body: FutureBuilder<List<Post>>(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            List<Post> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return GestureDetector(
                  onTap: () async {
                    try {
                      final surahDetail =
                          await httpService.getSurahDetail(post.number);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SurahDetail(post: surahDetail),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Gagal memuat detail surah: $e")),
                      );
                    }
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${post.number}. ${post.name} (${post.englishName})",
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8.0),
                          Text("Jumlah ayat: ${post.numberOfAyahs}",
                              style: const TextStyle(fontSize: 16.0)),
                          Text("Tempat turun: ${post.revelationType}",
                              style: const TextStyle(fontSize: 16.0)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
