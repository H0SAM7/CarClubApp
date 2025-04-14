
import 'package:car_club/features/chat/manager/cubit_cubit/chat_cubit.dart';
import 'package:car_club/features/chat/views/widgets/chat_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
   const ChatView({super.key, required this.contactEmail, });
  static const String id = 'ChatView';
  final String contactEmail;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child:  Scaffold(
             appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Chat with expert'),
            Text(
              'Typically replies within 5 minutes',
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
      ),
        body: ChatViewBody(contactEmail: contactEmail,),
      ),
    );
  }
}
