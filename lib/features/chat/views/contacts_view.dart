import 'package:car_club/core/styles/text_styles.dart';
import 'package:car_club/core/utils/assets.dart';
import 'package:car_club/features/chat/models/message_model.dart';
import 'package:car_club/features/chat/views/chat_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});
  static String id = 'ContactsScreen';
  Stream<List<MessageModel>> getUniqueUsernames() {
    return FirebaseFirestore.instance
        .collection('chat')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          final uniqueUsernames = <String>{};
          final messageModels = <MessageModel>[];

          for (var doc in snapshot.docs) {
            final message = MessageModel.fromJson(doc.data());
            if (uniqueUsernames.add(message.userName)) {
              messageModels.add(message);
            }
          }

          return messageModels;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chats")),
      body: StreamBuilder<List<MessageModel>>(
        stream: getUniqueUsernames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No contacts found"));
          }

          final messages = snapshot.data!;

          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              // final username = usernames[index];
              final message = messages[index];

              return ContactsItem(messageModel: message);
            },
          );
        },
      ),
    );
  }
}

class ContactsItem extends StatelessWidget {
  const ContactsItem({super.key, required this.messageModel});
  final MessageModel messageModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ChatView.id,
          arguments: messageModel.sender,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color.fromARGB(255, 230, 232, 235),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 199, 180, 180),
              radius: 20,
              child: Icon(Icons.person_2_outlined),
            ),
            title: Text(
              messageModel.userName,
              style: AppStyles.style22(context),
            ),
            // subtitle: Text(
            //   messageModel.message,
            //   style: AppStyles.style18(context),
            // ),
            trailing: Image.asset(Assets.imagesChevronRight),
          ),
        ),
      ),
    );
  }
}
