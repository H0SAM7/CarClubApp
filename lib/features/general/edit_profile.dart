import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfileScreen extends StatefulWidget {
  static String id='EditProfileScreen';
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
      }
    }
  }

  Future<void> _saveChanges() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'updatedAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Changes saved successfully')),
      );

      Navigator.pop(context); // رجوع للصفحة السابقة
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Failed to save changes: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(250, 241, 231, 231),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey[400],
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Text('PROFILE', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 5),
            buildEditableField('Name', nameController),
            buildEditableField('Email', emailController),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[300],
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: _isLoading ? null : _saveChanges,
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEditableField(String label, TextEditingController controller) {
    return ListTile(
      title: Text(label),
      subtitle: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}
