import 'package:flutter/material.dart';

showSnachBar(context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 25),
      action: SnackBarAction(label: 'Close', onPressed: () {})));
}
