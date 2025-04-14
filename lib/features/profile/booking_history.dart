import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookingHistory extends StatelessWidget {
  const BookingHistory({super.key});
  static String id = 'BookingHistory';

  @override
  Widget build(BuildContext context) {
    // Get the current user's ID
    final String? userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
        backgroundColor: Colors.pink[300],
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(250, 241, 231, 231),
      body: userId == null
          ? const Center(child: Text('Please log in to view your booking history.'))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Booking')
                  .where('userId', isEqualTo: userId)
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
                  return const Center(child: Text('No booking history found.'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var booking = snapshot.data!.docs[index];
                    return BookingCard(booking: booking);
                  },
                );
              },
            ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final QueryDocumentSnapshot booking;

  const BookingCard({super.key, required this.booking});

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
              booking['carName'] ?? 'Unknown Car',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${booking['date'] ?? 'N/A'}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              'Time: ${booking['time'] ?? 'N/A'}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              'Location: ${booking['location'] ?? 'N/A'}',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              'Booking Date: ${_formatTimestamp(booking['timestamp'])}',
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