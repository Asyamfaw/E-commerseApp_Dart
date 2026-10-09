import 'package:flutter/material.dart';

class ListChatPage extends StatefulWidget {
  const ListChatPage({super.key});

  @override
  State<ListChatPage> createState() => _ListChatPage();
}

class _ListChatPage extends State<ListChatPage> {
  bool _showUnreadOnly = false;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chats = [
      {
        'name': 'Sahlel',
        'lastMessage': 'Segera Pesan sebelum kehabisan',
        'time': '10.30',
        'avatarUrl': 'https://i.pinimg.com/736x/05/40/4d/05404d4d098f3557d57d4e809a25b63b.jpg',
        'isRead': 'false',
      },
      {
        'name': 'Gibran Tetanus',
        'lastMessage': 'Segera Pesan sebelum kehabisan',
        'time': '10.30',
        'avatarUrl': 'https://i.pinimg.com/736x/05/40/4d/05404d4d098f3557d57d4e809a25b63b.jpg',
        'isRead': 'false',
      },
      {
        'name': 'Akbar',
        'lastMessage': 'Segera Pesan sebelum kehabisan',
        'time': '10.30',
        'avatarUrl': 'https://i.pinimg.com/736x/05/40/4d/05404d4d098f3557d57d4e809a25b63b.jpg',
        'isRead': 'false',
      },
      {
        'name': 'Sahlel',
        'lastMessage': 'Segera Pesan sebelum kehabisan',
        'time': '10.30',
        'avatarUrl': 'https://i.pinimg.com/736x/05/40/4d/05404d4d098f3557d57d4e809a25b63b.jpg',
        'isRead': 'True',
      },
      {
        'name': 'Sahlel',
        'lastMessage': 'Segera Pesan sebelum kehabisan',
        'time': '10.30',
        'avatarUrl': 'https://i.pinimg.com/736x/05/40/4d/05404d4d098f3557d57d4e809a25b63b.jpg',
        'isRead': 'false',
      },
      {
        'name': 'Asep',
        'lastMessage': 'Segera Pesan sebelum kehabisan',
        'time': '10.30',
        'avatarUrl': 'https://i.pinimg.com/736x/05/40/4d/05404d4d098f3557d57d4e809a25b63b.jpg',
        'isRead': 'false',
      },
      {
        'name': 'MonyeD',
        'lastMessage': 'Segera Pesan sebelum kehabisan',
        'time': '10.30',
        'avatarUrl': 'https://i.pinimg.com/736x/05/40/4d/05404d4d098f3557d57d4e809a25b63b.jpg',
        'isRead': 'True',
      },
      {
        'name': 'Kucay',
        'lastMessage': 'Segera Pesan sebelum kehabisan',
        'time': '10.30',
        'avatarUrl': 'https://i.pinimg.com/736x/05/40/4d/05404d4d098f3557d57d4e809a25b63b.jpg',
        'isRead': 'True',
      },
    ];

    final visibleChats = _showUnreadOnly
        ? chats.where((chats) => !(chats['isRead'] == false)).toList()
        : chats;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat List',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
            child: Row(
              children: [
                ChoiceChip(
                  label: const Text('Semua'),
                  selected: !_showUnreadOnly,
                  onSelected: (_) => setState(() => _showUnreadOnly = false),
                ),
                const SizedBox(width: 8),
                ChoiceChip(
                  label: const Text('Belum dibaca'),
                  selected: _showUnreadOnly,
                  onSelected: (_) => setState(() => _showUnreadOnly = true),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: visibleChats.length,
              itemBuilder: (context, index) {
                final chat = visibleChats[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(chat['avatarUrl'] as String),
                  ),
                  title: Text(
                    chat['name'] as String,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(chat['lastMessage'] as String),
                  trailing: Text(chat['time'] as String),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
