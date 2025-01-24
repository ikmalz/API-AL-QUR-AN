import 'package:flutter/material.dart';
import 'post_model.dart';

class SurahDetail extends StatelessWidget {
  final Post post;

  const SurahDetail({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<int, List<Ayat>> ayatByPage = {};
    for (var ayat in post.ayahs) {
      ayatByPage.putIfAbsent(ayat.page, () => []).add(ayat);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(post.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${post.number}. ${post.name} (${post.englishName})",
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text("Jumlah Ayat: ${post.numberOfAyahs}", style: const TextStyle(fontSize: 16.0)),
            Text("Tempat Turun: ${post.revelationType}", style: const TextStyle(fontSize: 16.0)),
            Text("Arti: ${post.englishNameTranslation}", style: const TextStyle(fontSize: 16.0)),
            const SizedBox(height: 16.0),
            const Text(
              "Ayat-ayat:",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView(
                children: ayatByPage.entries.map((entry) {
                  final page = entry.key;
                  final ayats = entry.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Page: $page",
                        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      ...ayats.map((ayat) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            "ayat: ${ayat.numberInSurah}. ${ayat.text}",
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 16.0),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
