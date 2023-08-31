import 'package:cloud_firestore/cloud_firestore.dart';

class ReceivedEmail {
  final String? sender;
  final String content;
  final Timestamp timestamp;
  // bool isRead;
  final String subject;

  ReceivedEmail({
    required this.content,
    // this.isRead = false,
    required this.sender,
    required this.subject,
    required this.timestamp
  });
}