import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void showCustomAlert({
  required BuildContext context,
  required AlertType type,
  required String title,
  required String description,
  required VoidCallback onPressed,
  required String actionTitle,
  Function? closeFunction,
  
}

) {

  Alert(
    context: context,
    type: type,
    title: title,
    desc: description,
    onWillPopActive: true,
    closeFunction: closeFunction,
    style: const AlertStyle(
      backgroundColor: Colors.black,
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      descStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
    ),
    buttons: [
      DialogButton(
        onPressed: onPressed,
        width: 120,
        color: Color.fromARGB(255, 249, 57, 166),
        child: Text(
          actionTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
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
