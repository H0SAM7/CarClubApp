import 'package:car_club/core/Models/car_model.dart';
import 'package:car_club/features/admin/presentation/views/reviews_view.dart';
import 'package:car_club/features/home/presentation/views/widgets/image_product_details.dart';
import 'package:car_club/features/home/presentation/views/widgets/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDetailsBody extends StatefulWidget {
  const ProductDetailsBody({super.key, required this.carModel});

  final CarModel carModel;

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //final S s;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          ImageProductDetails(carModel: widget.carModel),
          const Divider(thickness: .5),
          ProductDetails(carModel: widget.carModel),
        ],
      ),
    );
  }
}
