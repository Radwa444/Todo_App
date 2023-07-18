import 'package:flutter/material.dart';

class dialog {
  static void dialogAwiat(BuildContext context, String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  width: 5,
                ),
                Text(text)
              ],
            ),
          );
        },
        barrierDismissible: false);
  }

  static void hidedialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMassage(BuildContext context, String massage,
      {String? positiveAction, String? negativeAction,VoidCallback? postive,VoidCallback? negative}) {
    showDialog(
      context: context,
      builder: (context) {
        List<Widget> actions = [];
        if (positiveAction != null) {
          actions.add(TextButton(
              onPressed: () {
                Navigator.pop(context);
                postive?.call();
              },
              child: Text(positiveAction)));
        }
        if (negativeAction != null) {
          actions.add(TextButton(
              onPressed: () {
                Navigator.pop(context);
                negative?.call();
              },
              child: Text(negativeAction)));
        }
        return AlertDialog(
          content: Text(massage),
          actions: actions,
        );
      },
    );
  }
}
