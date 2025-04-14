import 'dart:developer';

import 'package:car_club/features/profile/booking_history.dart';
import 'package:car_club/features/profile/purchase_history.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../general/edit_profile.dart';
import '../auth/screens/user_login.dart'; // صفحة تسجيل الدخول بعد تسجيل الخروج

class Profile extends StatefulWidget {
  static String id = 'Profile';

  const Profile({super.key});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isPushNotificationsEnabled = true;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        setState(() {
          userData = doc.data();
        });
      }
    }
  }

  Future<void> _signOut() async {
    IconButton(
      icon: Icon(Icons.logout),
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully signed out')),
        );
        log('Log out');
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = userData?['name'] ?? '...';
    final email = userData?['email'] ?? '...';

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.pink[300],
      //   title: Text('Account Information'),
      //   centerTitle: true,
      // ),
      backgroundColor: const Color.fromARGB(250, 241, 231, 231),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            userData == null
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey[400],
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('PROFILE', style: TextStyle(color: Colors.grey)),
                      buildInfoTile(name, Icons.person, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ),
                        );
                      }),
                      buildInfoTile(email, Icons.email, null),
                      SizedBox(height: 20),
                      Text('ACCOUNT', style: TextStyle(color: Colors.grey)),
                      // buildInfoTile('Drive Test', Icons.directions_car, null,
                      //     trailing: '1'),
                      //  buildInfoTile('Chat', Icons.chat, null),
                      buildInfoTile('Purchase History', Icons.price_check, () {
                        Navigator.pushNamed(context, PurchaseHistory.id);
                      }),
                      buildInfoTile('Booking History', Icons.shopping_cart, () {
                        Navigator.pushNamed(context, BookingHistory.id);
                      }),
                      // buildInfoTile('Favorite Cars', Icons.favorite, null,
                      //     trailing: '5'),
                      SizedBox(height: 20),

                      // Text('SETTING', style: TextStyle(color: Colors.grey)),

                      // SwitchListTile(
                      //   title: Text('Push Notifications'),
                      //   value: isPushNotificationsEnabled,
                      //   onChanged: (bool value) {
                      //     setState(() {
                      //       isPushNotificationsEnabled = value;
                      //     });
                      //   },
                      // ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink[300],
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Successfully signed out'),
                              ),
                            );
                            log('Log out');
                            Navigator.pushReplacementNamed(
                              context,
                              LoginScreen.id,
                            );
                          },
                          child: Text(
                            'Sign Out',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }

  Widget buildInfoTile(
    String title,
    IconData icon,
    VoidCallback? onTap, {
    String? trailing,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        title: Text(title),
        leading: Icon(icon, color: Colors.pink[300]),
        trailing:
            trailing != null
                ? Text(trailing, style: TextStyle(color: Colors.black54))
                : Icon(Icons.chevron_right),
      ),
    );
  }
}
