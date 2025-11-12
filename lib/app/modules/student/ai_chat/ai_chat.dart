import 'package:flutter/material.dart';

class AiChatScreen extends StatefulWidget {
  static const routeName = "/ai-chat";
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Chat"),
      ),
      body: const Column(
        children: [
          Text("AI Chat"),
        ],
      ),
    );
  }
}
