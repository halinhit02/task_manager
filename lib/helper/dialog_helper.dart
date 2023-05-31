import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  static showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Dialog(
              backgroundColor: Colors.transparent,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }

  static showSnackBar(BuildContext? context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context ?? GlobalKey().currentContext!).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: isError
            ? Colors.red
            : Theme.of(context ?? GlobalKey().currentContext!).primaryColor,
      ),
    );
  }

  static showAlertDialog(
      BuildContext context, String content, Function() onOKClick) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Notification'),
        content: Text(
          content,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
              onOKClick();
            },
          )
        ],
      ),
    );
  }
}
