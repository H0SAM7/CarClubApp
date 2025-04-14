import 'package:car_club/core/utils/assets.dart';
import 'package:flutter/material.dart';

class NoNoitifiView extends StatelessWidget {
  const NoNoitifiView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
  
        Align(
          
          child: Image.asset(Assets.imagesNoNotifi)),
        const SizedBox(height: 20),
        const Text(
          'No notification, yet!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
             const SizedBox(height: 10),
      ],
    );
  }
}
