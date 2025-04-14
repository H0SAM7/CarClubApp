import 'dart:developer';

import 'package:car_club/features/auth/screens/user_login.dart';
import 'package:car_club/features/home/presentation/views/widgets/custom_image_procduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class BuyCarScreen extends StatefulWidget {
  final String carName;
  final String carPrice;
  final String carImage;

  const BuyCarScreen({
    required this.carName,
    required this.carPrice,
    required this.carImage,
  });

  @override
  _BuyCarScreenState createState() => _BuyCarScreenState();
}

class _BuyCarScreenState extends State<BuyCarScreen> {
  // Controllers for buyer details
  final TextEditingController buyerNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  // Controllers for credit card details
  final TextEditingController cardHolderController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  // Payment method state; default to Cash
  String _paymentMethod = "Cash";
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> bayCar({required Map<String, dynamic> purchaseData}) async {
    if (purchaseData.isNotEmpty) {
      try {
        await firestore.collection('Buy').add(purchaseData);
        log('Review added successfully');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Review added successfully!")));
        purchaseData.clear();
      } catch (e) {
        log('Error adding review: $e');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to add review: $e")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please write a review before submitting.")),
      );
    }
  }

  // Function to confirm the purchase
  void confirmPurchase() async {
    String buyerName = buyerNameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String location = locationController.text.trim();
    String? userId = FirebaseAuth.instance.currentUser?.uid; // Get user ID
    Map<String, dynamic> purchaseData = {
      'carName': widget.carName,
      'carPrice': widget.carPrice,
      'buyerName': buyerName,
      'phone': phone,
      'email': email,
      'location': location,
      'userId': userId, // Add userId for PurchaseHistory
      'paymentMethod': _paymentMethod,
      'timestamp': FieldValue.serverTimestamp(), // Add timestamp for record
    };
    if (buyerName.isEmpty ||
        phone.isEmpty ||
        email.isEmpty ||
        location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all your details.")),
      );
      return;
    }

    if (_paymentMethod == "Credit Card") {
      String cardHolder = cardHolderController.text.trim();
      String cardNumber = cardNumberController.text.trim();
      String expiry = expiryController.text.trim();
      String cvv = cvvController.text.trim();

      if (cardHolder.isEmpty ||
          cardNumber.isEmpty ||
          expiry.isEmpty ||
          cvv.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill in all credit card details.")),
        );
        return;
      }
      // credit card payment.
      developer.log("Payment Method: Credit Card");
      developer.log(
        "Card Holder: $cardHolder, Card Number: $cardNumber, Expiry: $expiry, CVV: $cvv",
      );
    } else {
      // For Cash payments
      developer.log("Payment Method: Cash");
    }

    developer.log("Car Purchased: ${widget.carName}");
    developer.log(
      "Buyer: $buyerName, Phone: $phone, Email: $email, Location: $location",
    );
    try {
      await bayCar(purchaseData: purchaseData);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Purchase Confirmed!")));
      Navigator.pop(context);
    } catch (e) {
      // Error already handled in bayCar, no need to show another SnackBar
    }

    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(SnackBar(content: Text("Purchase Confirmed!")));
    // Navigator.pop(context);
  }

  @override
  void initState() {
    final user = FirebaseAuth.instance.currentUser;
if (user == null) {
    // Redirect to login screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, LoginScreen.id); 
    });
  } else {
    emailController.text = user.email ?? '';
  }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Car'),
        backgroundColor: Colors.pink[300],
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(250, 241, 231, 231),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Car details section
            CustomImage(image: widget.carImage),
            SizedBox(height: 10),
            Text(
              widget.carName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "Price: ${widget.carPrice}",
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            // Buyer details input fields
            TextField(
              controller: buyerNameController,
              decoration: InputDecoration(
                labelText: 'Your Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 20),
            // Payment method radio buttons
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Payment Method",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text("Credit Card"),
              leading: Radio<String>(
                value: "Credit Card",
                groupValue: _paymentMethod,
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: Text("Cash"),
              leading: Radio<String>(
                value: "Cash",
                groupValue: _paymentMethod,
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
              ),
            ),
            // If Credit Card is selected, show separate fields for card details
            if (_paymentMethod == "Credit Card") ...[
              SizedBox(height: 10),
              TextField(
                controller: cardHolderController,
                decoration: InputDecoration(
                  labelText: 'Card Holder Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: cardNumberController,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: expiryController,
                decoration: InputDecoration(
                  labelText: 'Expiry Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: cvvController,
                decoration: InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                keyboardType: TextInputType.number,
              ),
            ],
            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[300],
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: confirmPurchase,
                child: Text(
                  'Confirm Purchase',
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
    );
  }
}
