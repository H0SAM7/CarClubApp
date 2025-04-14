import 'package:car_club/features/home/presentation/views/car_details.dart';
import 'package:car_club/core/Models/car_model.dart';
import 'package:car_club/core/styles/text_styles.dart';
import 'package:car_club/features/home/presentation/views/widgets/custom_image_procduct.dart';
import 'package:flutter/material.dart';

class CustomProductItem extends StatelessWidget {
  const CustomProductItem({super.key, required this.carModel});

  final CarModel carModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CarPage.id, arguments: carModel);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        elevation: 4,

        child: ListTile(
          leading: CustomImage(image: carModel.image),
          title: Text(carModel.name,style: AppStyles.style22(context),),
          subtitle: Text(carModel.description,style: AppStyles.style18(context),),
        ),

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //                   mainAxisSize: MainAxisSize.min,

        //   children: [
        //     ClipRRect(
        //       borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        //       child: CustomImage(
        //         image: carModel.image,

        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(12.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           Text(
        //             _truncateText(carModel.name, 4),
        //             style: AppStyles.style32(context,Colors.black),
        //             maxLines: 1,
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //           const SizedBox(height: 4),
        //           Text(
        //            carModel.description,
        //             style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        //             maxLines: 2,
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //           const SizedBox(height: 8),
        //           Text(
        //             "Free",
        //             style: const TextStyle(
        //                 fontSize: 16, fontWeight: FontWeight.bold),
        //           ),

        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  String _truncateText(String text, int maxWords) {
    final words = text.split(' ');
    if (words.length <= maxWords) {
      return text;
    } else {
      return '${words.take(maxWords).join(' ')}...';
    }
  }
}
