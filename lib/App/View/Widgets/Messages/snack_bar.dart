import 'package:flutter/material.dart';

showMessage(context, {required String title, Color color = Colors.red}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      backgroundColor: color,
    ),
  );
}
