import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> showConfirmModal(BuildContext context, String message) async {
  var isConfirmed = false;
  await showDialog<void>(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text('確認'),
        content: Text(message),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () {
              isConfirmed = false;
              Navigator.pop(context);
            },
            child: const Text('キャンセル'),
          ),
          CupertinoDialogAction(
            onPressed: () {
              isConfirmed = true;
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
  return isConfirmed;
}
