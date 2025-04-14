import 'dart:developer';
import 'package:car_club/features/home/presentation/views/widgets/custom_image_procduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this import
import 'package:flutter/material.dart';

class BookTestDriveScreen extends StatefulWidget {
  static String id = 'BookTestDriveScreen';
  final String carName;
  final String carImage;

  const BookTestDriveScreen({
    super.key,
    required this.carName,
    required this.carImage,
  });

  @override
  _BookTestDriveScreenState createState() => _BookTestDriveScreenState();
}

class _BookTestDriveScreenState extends State<BookTestDriveScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  // Dummy data for available dates, replace with actual database call
  List<DateTime> availableDates = [
    DateTime(2025, 3, 25),
    DateTime(2025, 3, 26),
    DateTime(2025, 3, 27),
  ];

  // Function to show the date picker and set selected date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025, 12, 31),
    );

    if (selectedDate != null) {
      setState(() {
        _dateController.text = selectedDate.toLocal().toString().split(' ')[0];
      });
    }
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> bookCar({required Map<String, dynamic> purchaseData}) async {
    if (purchaseData.isNotEmpty) {
      try {
        await firestore.collection('Booking').add(purchaseData);
        log('Booking added successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Test Drive Booked Successfully!")),
        );
      } catch (e) {
        log('Error adding booking: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to book test drive: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all required fields.")),
      );
    }
  }

  // Validate input fields
  bool _validateInputs() {
    if (_dateController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all required fields.")),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: const Text('Book Test Drive'),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(250, 241, 231, 231),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomImage(image: widget.carImage),
              const SizedBox(height: 10),
              Text(
                'You are booking ${widget.carName} for a test drive',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Select Date',
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Time',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[300],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    if (_validateInputs()) {
                      // Prepare booking data
                      final Map<String, dynamic> bookingData = {
                        'carName': widget.carName,
                        'carImage': widget.carImage,
                        'date': _dateController.text,
                        'location': _locationController.text,
                        'time': _timeController.text,
                        'userId': FirebaseAuth.instance.currentUser?.uid, // Add userId
                        'timestamp': FieldValue.serverTimestamp(),
                      };

                      // Call bookCar to upload data
                      bookCar(purchaseData: bookingData).then((_) {
                        // Optionally clear fields after successful booking
                        _dateController.clear();
                        _locationController.clear();
                        _timeController.clear();
                      });
                    }
                  },
                  child: const Text(
                    'Book it now',
                    style: TextStyle(
                      fontSize: 18,
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

  @override
  void dispose() {
    _dateController.dispose();
    _locationController.dispose();
    _timeController.dispose();
    super.dispose();
  }
}