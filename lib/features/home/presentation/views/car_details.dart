import 'dart:developer';

import 'package:car_club/core/Models/car_model.dart';
import 'package:car_club/core/styles/text_styles.dart';
import 'package:car_club/features/admin/data/admins_repo/admins_repo.dart';
import 'package:car_club/features/admin/presentation/views/add_car_view.dart';
import 'package:car_club/features/admin/presentation/views/reviews_view.dart';
import 'package:car_club/features/home/presentation/views/widgets/custom_image_procduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../general/book_car.dart';
import 'buy_car.dart';
import 'dart:developer' as developer;

class CarPage extends StatefulWidget {
  final CarModel carModel;
  static const id = 'CarPage';
  const CarPage({super.key, required this.carModel});

  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController reviewController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();

  Future<void> _loadUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        nameController.text = data['name'] ?? 'User';
      }
    }
  }

  void _addReview() async {
    String review = reviewController.text.trim();
    if (review.isNotEmpty) {
      String username = nameController.text;
      try {
        await firestore.collection('reviews').add({
          'review': review,
          'Car': widget.carModel.toMap(),
          'name': username,
         

          'timestamp': FieldValue.serverTimestamp(),
        });
        log('Review added successfully');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Review added successfully!")));
        reviewController.clear();
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

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    nameController.dispose();
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carModel.name),
        backgroundColor: Color.fromARGB(207, 221, 199, 199),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: CustomImage(image: widget.carModel.image)),
                  SizedBox(height: 16),
                  Text(
                    widget.carModel.name,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Price: ${widget.carModel.price}",
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: reviewController,
                    decoration: InputDecoration(
                      hintText: "Write your review...",
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: _addReview,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[300],
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        "Add Review",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => BookTestDriveScreen(
                                    carName: widget.carModel.name,
                                    carImage: widget.carModel.image,
                                  ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[300],
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          "Book Test Drive",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => BuyCarScreen(
                                    carName: widget.carModel.name,
                                    carPrice: widget.carModel.price.toString(),
                                    carImage: widget.carModel.image,
                                  ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink[300],
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        child: Text(
                          "Buy Car",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Reviews:', style: AppStyles.style22(context)),
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ReviewsSection(firestore: _firestore, widget: widget),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewsSection extends StatelessWidget {
  const ReviewsSection({
    super.key,
    required FirebaseFirestore firestore,
    required this.widget,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;
  final CarPage widget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore
              .collection('reviews')
              .where(
                'Car.code',
                isEqualTo: widget.carModel.code,
              ) // Filter by car code
              .orderBy('timestamp', descending: true)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error fetching reviews: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No reviews found.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        final reviews = snapshot.data!.docs;

        return CarsReviews(reviews: reviews);
      },
    );
  }
}

class CarsReviews extends StatelessWidget {
  final List<QueryDocumentSnapshot> reviews;
  const CarsReviews({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final reviewData = reviews[index].data() as Map<String, dynamic>;
        final reviewText = reviewData['review'] ?? 'No review text';
        final username = reviewData['name'] ?? 'User';
        final timestamp =
            reviewData['timestamp'] != null
                ? (reviewData['timestamp'] as Timestamp)
                    .toDate()
                    .toString()
                    .split(' ')[0]
                : 'No Date';
        return CustomReviewCard(
          username: username,
          review: reviewText,
          timestamp: timestamp,
        );
      },
    );
  }
}


class CustomReviewCard extends StatelessWidget {
  const CustomReviewCard({
    super.key,
    required this.username,
    required this.review,
    required this.timestamp,
  });

  final dynamic username;
  final dynamic review;
  final String timestamp;
   


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 230, 232, 235),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 255, 253, 253),
            radius: 20,
            child: Icon(Icons.person_2_outlined),
          ),
          title: Text(username, style: AppStyles.style22(context)),

          subtitle: Text(review, style: AppStyles.style18(context)),
          trailing: Text(timestamp, style: AppStyles.style18(context)),
        ),
      ),
    );
  }
}
