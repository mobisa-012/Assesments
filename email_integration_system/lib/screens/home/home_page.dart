import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_integration_system/screens/received/email_received.dart';
import 'package:email_integration_system/screens/templates/email_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final String? userEmail = user!.email;
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const EmailTemplate())
          );
        },
        child: const Icon(Icons.email,
        color: Colors.purple,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text('Sent Emails'),
          elevation: 2,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            }, 
            icon: const Icon(Icons.menu)
            ),
        ),
        drawer:  Drawer(
          backgroundColor: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAccountsDrawerHeader(  
                decoration: const BoxDecoration(
                  color: Colors.white
                ),              
                accountName: const Text('Hello',
                style: TextStyle(
                  color: Colors.black
                ),), 
                accountEmail: Text(userEmail!,
                style: const TextStyle(
                  color: Colors.black
                ),),
                currentAccountPicture: const CircleAvatar(
                  child: Icon(Icons.account_circle,
                  color: Colors.purple,),
                ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
                  },
                  leading: const Icon(Icons.mark_email_unread,
                  color: Colors.purple,),
                  title: const Text('Important'),
                ),
                const Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).
                    push(MaterialPageRoute(builder: (_) => const EmailRecieved()));
                  },
                  leading: const Icon(Icons.email_rounded,
                  color: Colors.purple,),
                  title: const Text('Received'),
                ),
                const Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),                
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('sent_emails').snapshots(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if(snapshot.hasError){
                return Text('Error: ${snapshot.error}');
              }
              final documents = snapshot.data!.docs;
              if(documents.isEmpty) {
                return const Center(
                  child: Text(
                    'No emails sent yet',
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final document = documents[index];
                  final recipient = document['recipient'];
                  final subject = document['subject'];
                  final content = document['content'];
                  final timestamp = document['timestamp'];
                  return ListTile(
                    title: Text(
                      '$recipient',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600
                    ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Subject: $subject'
                        ),
                        Text(
                          'Content: $content'
                        ),
                        Text(
                          'Time: $timestamp'
                        ),
                      ],
                    ),
                  );
                }
                );
            },
          ),
        )),
    );
  }
}