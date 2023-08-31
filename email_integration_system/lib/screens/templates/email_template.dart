// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_integration_system/core/const/margins.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailTemplate extends StatefulWidget {
  const EmailTemplate({super.key});

  @override
  State<EmailTemplate> createState() => _EmailTemplateState();
}

class _EmailTemplateState extends State<EmailTemplate> {
  final subjectController = TextEditingController();
  final contentController = TextEditingController();
  final recipientController = TextEditingController();

  bool validateEmailFields () {
    return recipientController.text.isEmpty &&
    subjectController.text.isEmpty &&
    contentController.text.isEmpty;
  }
  
void sendEmail() async {
   if(validateEmailFields()) {
    showDialog(
      context: context, 
      builder: (context) {
        return const AlertDialog(
          title: Text('Empty fields'),
          content: Text('Please fill all fields'),
        );
      }
      );
      return ;
   }
   User? user = FirebaseAuth.instance.currentUser;
   String? email = user!.email;
   String password = "jemf igvf gqhl dyck";
  //  create an app password for the gmail account from goggle settings
   final timestamp = DateTime.now();
   final formattedDate = DateFormat('d MMM y, HH:mm').format(timestamp);

  final smtpServer = gmail(email!, password);
  final message = Message()
  ..from =  const Address('mobisakwamboka@gmail.com')
  // try and have email and see if logged in email works
  ..recipients.add(recipientController.text)
  ..subject = subjectController.text
  ..text = contentController.text;

  try {
    final sendReport = await send(message, smtpServer);
    await FirebaseFirestore.instance.collection('sent_emails').add({
      'recipient': recipientController.text,
      'subject': subjectController.text,
      'content': contentController.text,
      'timestamp': formattedDate
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Email status'),
          content: Text('Email sent: $sendReport'),
        );
      }
      );
      Navigator.of(context).pop();
  } on MailerException catch (e) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Email status'),
          content: Text('Error sending email: $e'),
        );
      }
      );
      print('Error: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Create email'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  TextFormField(
                    controller: recipientController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Recipient',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    validator: (value) {
                      if(value == null) {
                        return 'Please recipient\'s address';
                      }
                      return null;
                    },
                  ),
                  YMargin(y: 15),
                  TextFormField(
                    controller: subjectController,
                    decoration: InputDecoration(
                      labelText: 'Subject',                    
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),                    
                    ),
                    maxLines: 1,
                    validator: (value) {
                      if(value == null) {
                        return 'Please enter email subject';
                      }
                      return null;
                    },
                  ),
                   YMargin(y: 15),
                   TextFormField(
                    controller: contentController,
                    decoration: InputDecoration(
                      labelText: 'Email body',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    maxLength: 1000,
                    maxLines: 10,
                    validator: (value) {
                      if(value == null) {
                        return 'Please enter email content';
                      }
                      return null;
                    },
                  ),
                  YMargin(y: 200),
                  ElevatedButton(
                    onPressed: () {
                      sendEmail();
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    minimumSize: Size(MediaQuery.of(context).size.width /1.5, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    elevation: 2
                  ),
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )
                  )
                ],
              ),
              ),
          ),
      );
  }
}