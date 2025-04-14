import 'package:car_club/core/styles/text_styles.dart';
import 'package:car_club/core/utils/assets.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title, this.widget, this.onTap});
  final String title;
  final Widget? widget;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          GestureDetector(
            onTap:
                onTap ??
                () {
                  Navigator.pop(context);
                },
            child: Icon(Icons.arrow_back_ios_new_sharp),
          ),
          const SizedBox(width: 20),
          Text(title, style: AppStyles.style18(context)),
          const Spacer(),
          widget ?? const SizedBox(),
        ],
      ),
    );
  }
}
