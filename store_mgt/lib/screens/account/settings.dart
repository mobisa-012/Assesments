import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store_mgt/core/cont/margins.dart';
import 'package:store_mgt/core/services/auth_service.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final email = user?.email;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My profile'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 2,
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Center(
                      child: Icon(Icons.account_circle,
                      color: Colors.purpleAccent,
                      size: 60,),
                    )
                  ],
                ),
                YMargin(y: 20),
                Text(
                  email!,
                  style: const TextStyle(
                    fontSize: 18
                  ),
                ),
                YMargin(y: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    minimumSize: Size(MediaQuery.of(context).size.width/1.5, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    )
                  ),
                  onPressed: () {
                  EmailAuthService().signOut();
                }, child: const Text('Sign out',
                style: TextStyle(color: Colors.white),))
              ],
            ),
          ),
        ),
      )
    );
  }
}