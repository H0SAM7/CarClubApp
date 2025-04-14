import 'package:bloc/bloc.dart';
import 'package:car_club/core/error/firebase_failure.dart';
import 'package:car_club/features/chat/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages = FirebaseFirestore.instance.collection('chat');
    CollectionReference users = FirebaseFirestore.instance.collection('users');

  void sendMEssage({required MessageModel messageModel}) {
    emit(ChatLoading());
    try {
      messages.add({
        'message': messageModel.message,
        'createdAt': messageModel.createdAt,
        'sender': messageModel.sender,
        'receiver': messageModel.receiver,
        'userName': messageModel.userName,
      });
            

      emit(ChatSuccess());
    } catch (e) {
      emit(ChatFailure(
          errMessage: FirebaseFailure.fromFirebaseException(e as Exception)
              .errMessage
              .toString()));
    }
  }

  void getMessages() {
    List<MessageModel> messagesList = [];
    messages
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        messagesList.add(MessageModel.fromJson(doc));
      }
      // emit(ChatSuccess(messageList:messagesList));
    });
  }




}
