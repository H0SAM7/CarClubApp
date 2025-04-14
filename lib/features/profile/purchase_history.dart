import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this import
import 'package:flutter/material.dart';

class PurchaseHistory extends StatelessWidget {
  const PurchaseHistory({super.key});
  static String id = 'PurchaseHistory';

  @override
  Widget build(BuildContext context) {
    // Get the current user's ID
    final String? userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase History'),
        backgroundColor: Colors.pink[300],
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(250, 241, 231, 231),
      body: userId == null
          ? const Center(child: Text('Please log in to view your purchase history.'))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Buy')
                  .where('userId', isEqualTo: userId) // Filter by userId
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No purchase history found.'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var purchase = snapshot.data!.docs[index];
                    return PurchaseCard(purchase: purchase);
                  },
                );
              },
            ),
    );
  }
}

class PurchaseCard extends StatelessWidget {
  final QueryDocumentSnapshot purchase;

  const PurchaseCard({super.key, required this.purchase});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              purchase['carName'] ?? 'Unknown Car',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Price: ${purchase['carPrice'] ?? 'N/A'}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              'Buyer: ${purchase['buyerName'] ?? 'N/A'}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              'Phone: ${purchase['phone'] ?? 'N/A'}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              'Email: ${purchase['email'] ?? 'N/A'}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              'Location: ${purchase['location'] ?? 'N/A'}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              'Payment Method: ${purchase['paymentMethod'] ?? 'N/A'}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              'Purchase Date: ${_formatTimestamp(purchase['timestamp'])}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return 'N/A';
    DateTime date = timestamp.toDate();
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }
}