import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_club/core/Models/car_model.dart';
import 'package:flutter/material.dart';

class ImageProductDetails extends StatelessWidget {
  const ImageProductDetails({
    super.key,
    required this.carModel,
  });

  final CarModel carModel;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: carModel.image,
      fit: BoxFit.contain,
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
