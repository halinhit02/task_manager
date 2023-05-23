import 'package:flutter/material.dart';

class DialogHelper {
  static showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => const Dialog(
              backgroundColor: Colors.transparent,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }

  static showSnackBar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: isError ? Colors.red : Theme.of(context).primaryColor,
      ),
    );
  }

  static showLoadingDialogcon(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => const Dialog(
              backgroundColor: Colors.transparent,
              child: Center(child: Text('aidjfjd')),
            ));
  }
}
