import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_integration_system/core/data/recive_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmailRecieved extends StatefulWidget {
  const EmailRecieved({super.key});

  @override
  State<EmailRecieved> createState() => _EmailRecievedState();
}

class _EmailRecievedState extends State<EmailRecieved> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    if(user!=null) {
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Received emails'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('sent_emails').snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator.adaptive();
            }
            if(!snapshot.hasData){
              return const Text('No emails received yet');
            }
            final emailDocs = snapshot.data!.docs;
            final receivedEmails = emailDocs.map((doc) {
              final data = doc.data();
              final timestampString = data ['timestamp'] as String;               
              final parsedTimestamp = DateFormat("dd MMM yyyy, HH:mm").parse(timestampString);
              final timestamp = Timestamp.fromDate(parsedTimestamp);
              return ReceivedEmail(
                content: data['content'], 
                sender: data['recipient'], 
                subject: data['subject'], 
                timestamp: timestamp,
                // isRead: data['isRead']
                );
            } ).toList();
            return ListView.builder(
              itemCount: receivedEmails.length,
              itemBuilder: (context, index) {
                final email = receivedEmails[index];
                final formattedTimestamp = (email.timestamp).toDate().toString();
                return ListTile(
                  title: Text(email.subject,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600
                  ),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(email.sender!),
                      Text(formattedTimestamp)
                    ],
                  ),
                  onTap: () {},
                );
              }
              );
           },
        ),
      ),
    );
  }
}