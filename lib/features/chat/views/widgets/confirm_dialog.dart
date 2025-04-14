import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void confiemDialog({
  required BuildContext context,
  required AlertType type,
  required String title,
  required String description,
  required VoidCallback cancelOnPressed,
    required VoidCallback okOnPressed,

  Function? closeFunction,
}) {
  Alert(
    context: context,
    type: type,
    title: title,
    desc: description,
    onWillPopActive: true,
    closeFunction: closeFunction,
    style: const AlertStyle(
        titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    buttons: [
      DialogButton(
        onPressed: cancelOnPressed,
        width: 120,
        child: const Text(
          'cancel',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
            DialogButton(
        onPressed: okOnPressed,
        width: 120,
        child: const Text(
          'ok',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
   
    ],
  ).show();
}

// void showErrorAlert(BuildContext context) {
//   Alert(
//     context: context,
//     type: AlertType.error,
//     title: "Error",
//     desc: "Flutter is more awesome with RFlutter Alert.",
//     buttons: [
//       DialogButton(
//         child: Text(
//           "COOL",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         onPressed: () => Navigator.pop(context),
//         width: 120,
//       ),
//     ],
//   ).show();
// }
