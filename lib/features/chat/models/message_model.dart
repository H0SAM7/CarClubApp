import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
   final DateTime createdAt;
  final String message;
  final String receiver;
  final String sender;
  final String userName;

  MessageModel({
    required this.createdAt,
    required this.message,
    required this.receiver,
    required this.sender,
    required this.userName,
  });


  factory MessageModel.fromJson( json) {
    
    return MessageModel(
      createdAt: json['createdAt'] is Timestamp
        ? (json['createdAt'] as Timestamp).toDate()
        : DateTime.parse(json['createdAt'] as String),
      message: json['message'] as String,
      receiver: json['receiver'] as String,
      sender: json['sender'] as String,
      userName: json['userName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
     'createdAt': createdAt,
      'message': message,
      'receiver': receiver,
      'sender': sender,
      'userName': userName,
    };
  }
}
