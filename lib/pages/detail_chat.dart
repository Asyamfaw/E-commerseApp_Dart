import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String contactName;

  const ChatScreen({super.key, required this.contactName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Penjual',
      'message': 'Segera pesan sebelum barang habis!',
      'IsMe': false,
    },
    {'text': 'You', 'message': 'Terima kasih atas informasinya!', 'IsMe': true},
    {'text': 'Penjual', 'message': 'Sama-sama!', 'IsMe': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.contactName)),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          final isMe = message['IsMe'] == true;
          return ListTile(
            title: Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isMe ? Colors.blue : Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  message['message']!,
                  style: TextStyle(color: isMe ? Colors.white : Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
