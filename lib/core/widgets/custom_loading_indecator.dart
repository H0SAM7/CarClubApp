import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key, this.h = 24, this.w = 32});
  final double? h;
  final double? w;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: h,
      width: w,
      child: LoadingIndicator(
        indicatorType: Indicator.lineScalePulseOut,
        colors: [
          Color(0xffCFE2FC),
          Color.fromARGB(255, 0, 0, 0),
   
        ],
      ),
    ));
  }
}
