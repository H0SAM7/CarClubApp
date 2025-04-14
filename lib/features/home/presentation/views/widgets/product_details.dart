import 'dart:developer';
import 'package:car_club/core/Models/car_model.dart';
import 'package:car_club/core/styles/text_styles.dart';
import 'package:car_club/core/widgets/show_custom_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
    required this.carModel,
  });

  final CarModel carModel;
  //final S s;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: buildSectionTitle(carModel.name),
            ),
            const SizedBox(
              height: 5,
            ),
            Text('• ${carModel.description}',
                style: AppStyles.style18(context, )),
            
            const SizedBox(
              height: 5,
            ),
           
            const SizedBox(
              height: 5,
            ),
            buildSectionTitle('Price'),
            Text('• Free', style: AppStyles.style18(context)),
            // Center(
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 30.0),
            //     child: Container(
            //       width: 200,
            //       decoration: BoxDecoration(
            //         color: Colors.blueAccent,
            //         borderRadius: BorderRadius.circular(14),
            //       ),
            //       child: FittedBox(
            //         fit: BoxFit.scaleDown,
            //         child: Align(
            //           alignment: Alignment.bottomCenter,
            //           child: TextButton(
            //             child: const AddToCartWidget(),
            //             onPressed: () async {
            //               // String url =
            //               //     'https://wa.me/+201065103026?text=${CarModel.parcode} كود المنتج';
            //               // final Uri uri = Uri.parse(url);
            //               // await launchUrlMethod(uri);
            //               // await BlocProvider.of<CartCubit>(context)
            //               //     .addItem(CarModel);
            //               showCustomAlert(
            //                 context: context,
            //                 type: AlertType.success,
            //                 title: '',
            //                 description: 'Add To cart Done ',
            //                 onPressed: () {
            //                   Navigator.pop(context);
            //                   Navigator.pop(context);
            //                 },
            //                 actionTitle: 'Ok',
            //               );
            //               // showDialog(
            //               //     context: context,
            //               //     builder: (context) {
            //               //       return ConfirmationDialog2(
            //               //           title: '',
            //               //           content: "Add To cart Done",
            //               //           onConfirm: () {
            //               //          Navigator.pop(context);
            //               //          Navigator.pop(context);
            //               //           },
            //               //           action: 'OK');
            //               //     });
            //               log('add item to cart done');
            //             },
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

Widget buildSectionTitle(String title) {
  return Text(
    title,
    style: TextStyle(
      fontSize: 22,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  );
}

class ConfirmationDialog2 extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final String action;
  const ConfirmationDialog2({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: Text(action),
          onPressed: () {
            onConfirm();
          },
        ),
        // TextButton(
        //   child: Text('5555'),
        //   onPressed: () {
        //     onConfirm();
        //   },
        // ),
      ],
    );
  }
}
