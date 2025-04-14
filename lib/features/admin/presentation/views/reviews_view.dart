import 'package:car_club/core/Models/car_model.dart';
import 'package:car_club/core/styles/text_styles.dart';
import 'package:car_club/features/home/presentation/views/car_details.dart';
import 'package:car_club/features/home/presentation/views/widgets/custom_image_procduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewsScreen extends StatefulWidget {
  static String id = 'ReviewsScreen';

  const ReviewsScreen({super.key});

  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: const Text('All Reviews'),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(250, 241, 231, 231),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            _firestore
                .collection('reviews')
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

          return ReviewList(reviews: reviews);
        },
      ),
    );
  }
}

class ReviewList extends StatelessWidget {
  const ReviewList({super.key, required this.reviews});

  final List<QueryDocumentSnapshot<Object?>> reviews;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        // image car
        // car name

        final reviewData = reviews[index].data() as Map<String, dynamic>;
        final reviewText = reviewData['review'] ?? 'No Review';
        final carId = reviewData['carId'] ?? 'Unknown Car';
        final username = reviewData['name'] ?? 'User';
        final carData = reviewData['car'] as Map<String, dynamic>?;
        final car =
            carData != null
                ? CarModel.fromMap(carData)
                : CarModel(
                  code: 'unknown',
                  brand: 'Unknown',
                  name: 'Unknown Car',
                  color: 'Unknown',
                  description: 'No description',
                  price: 0,
                  image: '',
                );

        final timestamp =
            reviewData['timestamp'] != null
                ? (reviewData['timestamp'] as Timestamp)
                    .toDate()
                    .toString()
                    .split(' ')[0]
                : 'No Date';

        return ReviewCard(
          username: username,
          review: reviewText,
          timestamp: timestamp,
          image: car.image,
          carName: car.name,
        );
      },
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.username,
    required this.review,
    required this.timestamp,
    required this.image,
    required this.carName,
  });

  final dynamic username;
  final dynamic review;
  final String timestamp;

  final String image;
  final String carName;
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
            child: CustomImage(image: image),
          ),
          title: Text(username, style: AppStyles.style22(context)),

          subtitle: Text(review, style: AppStyles.style18(context)),
          trailing: Column(
            children: [
              Text('Car Name: $review \n', style: AppStyles.style18(context)),
              Text(timestamp, style: AppStyles.style18(context)),
            ],
          ),
        ),
      ),
    );
  }
}
