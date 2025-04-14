import 'package:flutter/material.dart';

class AdminProfileScreen extends StatelessWidget {
  static String id='AdminProfileScreen';

  const AdminProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: Text('Account'),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(250, 241, 231, 231),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[400],
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text('Annie Larson',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('PROFILE', style: TextStyle(color: Colors.grey)),
            buildInfoTile('Admin name', 'annielarson'),
            buildInfoTile('Email', 'annie.larson@gmail.com'),
            SizedBox(height: 20),
            Text('ACCOUNT', style: TextStyle(color: Colors.grey)),
            buildAccountTile('Change password'),
            buildAccountTile('Blocked users'),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[300],
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Navigator.pop(context);
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
    );
  }

  Widget buildInfoTile(String title, String value) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value, style: TextStyle(color: Colors.black54)),
    );
  }

  Widget buildAccountTile(String title) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}