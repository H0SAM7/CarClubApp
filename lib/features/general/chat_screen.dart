import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:dart_openai/dart_openai.dart';
import 'dart:developer' as developer;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> messages = [];
  final ChatUser user = ChatUser(id: "1", firstName: "User");
  final ChatUser ai = ChatUser(id: "2", firstName: "AI");
  void sendMessage(ChatMessage message) async {
    setState(() {
      messages.insert(0, message);
    });

    try {
      final response = await OpenAI.instance.chat.create(
        model: "gpt-3.5-turbo",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.user,
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                  message.text) // ✅ Fix applied here
            ],
          ),
        ],
      );

      ChatMessage aiMessage = ChatMessage(
        text:
            response.choices.first.message.content?.first.text ?? "No response",
        user: ai,
        createdAt: DateTime.now(),
      );

      setState(() {
        messages.insert(0, aiMessage);
      });
    } catch (e) {
      developer.log("⚠️ Error sending message: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          title: Text("Chat with AI"), backgroundColor: Colors.pink[300]),
      body: DashChat(
        currentUser: user,
        onSend: sendMessage,
        messages: messages,
      ),
    );
  }
}
