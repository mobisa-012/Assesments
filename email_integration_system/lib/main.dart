import 'package:email_integration_system/core/services/auth_service.dart';
import 'package:email_integration_system/screens/bottom_bar/bloc/bottm_bar_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomBarCubit>(
      create: (context) => BottomBarCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Email Intergration App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: EmailAuthService().handleAuthState()
      ),
    );
  }
}