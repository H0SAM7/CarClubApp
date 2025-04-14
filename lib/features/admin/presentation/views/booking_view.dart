import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewBookingsScreen extends StatefulWidget {
  static String id = 'ViewBookingsScreen';

  const ViewBookingsScreen({super.key});

  @override
  _ViewBookingsScreenState createState() => _ViewBookingsScreenState();
}

class _ViewBookingsScreenState extends State<ViewBookingsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: const Text('All Bookings'),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(250, 241, 231, 231),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('Booking')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error fetching bookings: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No bookings found.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          final bookings = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index].data() as Map<String, dynamic>;
              final carName = booking['carName'] ?? 'Unknown Car';
              final date = booking['date'] ?? 'No Date';
              final location = booking['location'] ?? 'No Location';
              final time = booking['time'] ?? 'No Time';
              final carImage = booking['carImage'] ?? '';

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Car Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: carImage.isNotEmpty
                            ? Image.network(
                                carImage,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image_not_supported),
                                ),
                              )
                            : Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image_not_supported),
                              ),
                      ),
                      const SizedBox(width: 16),
                      // Booking Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              carName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Date: $date',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Time: $time',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Location: $location',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}