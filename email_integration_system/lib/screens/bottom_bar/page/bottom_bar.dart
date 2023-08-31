import 'package:email_integration_system/core/enums/bottom_bar.dart';
import 'package:email_integration_system/screens/bottom_bar/bloc/bottm_bar_bloc.dart';
import 'package:email_integration_system/screens/home/home_page.dart';
import 'package:email_integration_system/screens/onboarding/page/onboarding.dart';
import 'package:email_integration_system/screens/received/email_received.dart';
import 'package:email_integration_system/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<BottomBarCubit, BottomBarState>(
        builder: (context, state) {
          return BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.purple,
            currentIndex: state.index,
            items: const [
              BottomNavigationBarItem(
              icon: Icon(Icons.email), label: 'Sent'
              ),
              BottomNavigationBarItem(icon: Icon(Icons.mark_email_unread), label: 'Received'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
              ],
              onTap: (int index) {
                if(index ==0) {
                  BlocProvider.of<BottomBarCubit>(context)
                  .getBottomBarItem(BottomBarItem.home);
                } else {
                  if(index ==1) {
                  BlocProvider.of<BottomBarCubit>(context)
                  .getBottomBarItem(BottomBarItem.received);
                  } else {
                    if(index==2) {
                      BlocProvider.of<BottomBarCubit>(context)
                  .getBottomBarItem(BottomBarItem.settings);
                    }
                  }
                }
              },
            );
        },
      ),
      body: BlocBuilder<BottomBarCubit, BottomBarState> (
        builder: (context, state) {
          if(state.bottomBarItem == BottomBarItem.home) {
            return const HomePage();
          } else if(state.bottomBarItem == BottomBarItem.received) {
            return const EmailRecieved();
          } else if(state.bottomBarItem == BottomBarItem.settings){
            return const SettingsPage();
          }
          return const OnboardingPage();
        },
      ),
    );
  }
}