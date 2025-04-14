import 'package:car_club/core/utils/get_formated_date.dart';
import 'package:car_club/features/chat/models/message_model.dart';
import 'package:flutter/material.dart';

class MyMessage extends StatelessWidget {
  final MessageModel messageModel;
  const MyMessage({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration:  BoxDecoration(
                  color: const Color.fromARGB(255, 14, 93, 157),
                  borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(16),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
                ),
                child: Text(
                  messageModel.message,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
               Text(
                 getFormattedDateTime(createdAt: messageModel.createdAt).toString(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class FriendMessage extends StatelessWidget {
  final MessageModel messageModel;
  const FriendMessage({super.key, required this.messageModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 77, 157, 222),
           borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16))
                ),
                child: Text(
                  messageModel.message,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
               Text(
                getFormattedDateTime(createdAt: messageModel.createdAt).toString(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
