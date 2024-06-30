import 'package:flutter/material.dart';
import 'package:sharepact_app/chat.dart';

class GroupsScreen extends StatelessWidget {
  final List<Map<String, String>> groupsData = [
    {
      'icon': 'assets/netflix.png',
      'title': 'Netflix Family',
      'subtitle': 'JaneDoe1: How\'s it going guys?..',
      'badge': '10'
    },
    {
      'icon': 'assets/spotify.png',
      'title': 'Spotify Family',
      'subtitle': 'JaneDoe1: How\'s it going guys?..',
      'badge': '10'
    },
    {
      'icon': 'assets/netflix.png',
      'title': 'ChatGPT Family',
      'subtitle': 'JaneDoe1: How\'s it going guys?..',
      'badge': '10'
    },
    {
      'icon': 'assets/primevideo.png',
      'title': 'Amazon Prime Family',
      'subtitle': 'JaneDoe1: How\'s it going guys?..',
      'badge': '10'
    },
    {
      'icon': 'assets/netflix.png',
      'title': 'Canva Family',
      'subtitle': 'JaneDoe1: How\'s it going guys?..',
      'badge': '10'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Groups'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: groupsData.length,
          itemBuilder: (context, index) {
            final group = groupsData[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()),
                );
              },
              child: Container(
                width: double.infinity,
                height: 77,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(group['icon']!),
                      radius: 24,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            group['title']!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            group['subtitle']!,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 13,
                      child: Text(
                        group['badge']!,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
