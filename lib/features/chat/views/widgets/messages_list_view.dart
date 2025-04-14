import 'package:car_club/features/chat/models/message_model.dart';
import 'package:car_club/features/chat/views/widgets/message_view.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView(
      {super.key, required this.controller, required this.messagesList});
  final ScrollController controller;
  final List<MessageModel> messagesList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: messagesList.length,
        controller: controller,
        itemBuilder: (context, index) {
          return messagesList[index].sender ==
                  FirebaseAuth.instance.currentUser!.email!
              ? MyMessage(
                  messageModel: messagesList[index],
                )
              : FriendMessage(
                  messageModel: messagesList[index],
                );
        });
  }
}
