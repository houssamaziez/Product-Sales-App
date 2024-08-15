import 'package:flutter/material.dart';

Future<bool> showExitConfirmationDialog(BuildContext context) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('خروج من التطبيق'),
          content: Text('هل تريد حقًا الخروج من التطبيق؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Stay in the app
              },
              child: Text('لا'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Exit the app
              },
              child: Text('نعم'),
            ),
          ],
        ),
      ) ??
      false; // Return false if the dialog is dismissed
}
