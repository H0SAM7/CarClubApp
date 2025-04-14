import 'package:car_club/features/general/chat_screen.dart';
import 'package:car_club/core/utils/assets.dart';
import 'package:car_club/features/Notifications/views/notifi_view.dart';
import 'package:car_club/features/admin/presentation/views/admin_profile.dart';
import 'package:car_club/features/auth/screens/user_login.dart';
import 'package:car_club/features/chat/views/chat_view.dart';
import 'package:car_club/features/home/presentation/views/home_view.dart';
import 'package:car_club/features/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});
  static String id = 'BottomNavigator';

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentIndex = 0;

  final List<Widget> _children = [HomeView(), ChatScreen(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Image.asset(Assets.imagesLogo, height: 70),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.chat,color: Colors.blueAccent,),
            onPressed:
                (){
                  Navigator.pushNamed(context, ChatView.id,arguments: 'hoadel2003@gmail.com');
                }
          ),
              IconButton(
            icon: Icon(Icons.notifications,color: Colors.blueAccent,),
            onPressed:
                (){
                  Navigator.pushNamed(context, NotifiView.id);
                }
          ),
          // IconButton(
          //   icon: Icon(Icons.smart_toy),
          //   onPressed:
          //       () => Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => ChatScreen()),
          //       ),
          // ), // AI Chat
   
        ],
      ),
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blueAccent),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Colors.blueAccent),
            label: 'Chat',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.blueAccent),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.blueAccent,
        selectedLabelStyle: TextStyle(color: Colors.blueAccent),
        selectedFontSize: 10,
        showUnselectedLabels: false,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
