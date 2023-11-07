import 'package:flutter/material.dart';

class ErrorDialog {
  static void showErrorDialog(context, String msg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            content: Text(
              msg,
              style: const TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'OK',
                ),
              ),
            ]);
      },
    );
  }
}
