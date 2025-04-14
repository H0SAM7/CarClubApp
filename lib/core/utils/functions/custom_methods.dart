import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

bool isArabic(BuildContext context) {
  return Localizations.localeOf(context).languageCode == 'ar';
}

Future<void> launchUrlMethod(Uri uri) async {
  //const url = 'https://www.facebook.com/funnybabysohag';

  if (!await canLaunchUrl(uri)) {
    final bool launched =
        await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched) {
      log('Could not launch $uri');
    }
  } else {
    log('Cannot launch URL: $uri');
  }
}

String discount(String price, double discount) {
  double discountPrice =
      double.parse(price) - (double.parse(price) * discount / 100);
  return discountPrice.toString();
}
