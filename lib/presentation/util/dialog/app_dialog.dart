import 'package:flutter/material.dart';

class AppDialog {
  static showAppForm({required BuildContext context, required Widget child}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => child,
    );
  }
}
