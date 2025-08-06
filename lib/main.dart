import 'package:flutter/material.dart';

void main() {
  runApp(const DevFestLineUp());
}

class DevFestLineUp extends StatelessWidget {
  const DevFestLineUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devfest LineUp',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Talk> _talksFavorites = [];

  final List<Talk> talks = [
    Talk(
      'titulo 1',
      'Palestrante Silvio',
      '10:00',
      'Palestra',
      TalkCategory.android,
    ),
    Talk(
      "titulo 2",
      'Palestrante Ricardo',
      '10:30',
      'Palestra',
      TalkCategory.ios,
    ),
    Talk(
      'titulo 3',
      'Palestrante Flávia',
      '11:00',
      'Palestra',
      TalkCategory.flutter,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Devfest LineUp")),
      body: ListView.builder(
        itemCount: talks.length,
        itemBuilder: (context, index) {
          final talk = talks[index];
          final isFavorite = _talksFavorites.contains(talk);
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TalkPage(talk: talk)),
              );
            },
            title: Text(talk.title),
            subtitle: Text('${talk.speaker} - ${talk.time}'),
            leading: CircleAvatar(
              backgroundColor: Colors.indigo.shade100,
              child: Icon(
                _getCategoryIcon(talk.category),
                color: Colors.indigo,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  if (isFavorite) {
                    _talksFavorites.add(talk);
                  } else {
                    _talksFavorites.add(talk);
                  }
                });
              },
              icon: isFavorite
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : const Icon(Icons.favorite),
            ),
          );
        },
      ),
    );
  }
}

IconData _getCategoryIcon(TalkCategory category) {
  switch (category) {
    case TalkCategory.android:
      return Icons.android;
    case TalkCategory.ios:
      return Icons.apple;
    case TalkCategory.flutter:
      return Icons.flutter_dash;
  }
}

enum TalkCategory { android, ios, flutter }

class Talk {
  final String title;
  final String speaker;
  final String time;
  final String description;
  final TalkCategory category;

  Talk(this.title, this.speaker, this.time, this.description, this.category);
}

class TalkPage extends StatelessWidget {
  final Talk talk;
  const TalkPage({super.key, required this.talk});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhe da Talk")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              talk.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.indigo.shade100,
                  child: Icon(
                    _getCategoryIcon(talk.category),
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      talk.speaker,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(talk.time),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "Descrição",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(talk.description, style: const TextStyle(fontSize: 14)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text("Voltar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
