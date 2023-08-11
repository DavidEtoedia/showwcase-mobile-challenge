import 'package:flutter/material.dart';

class InnerPageLoadingIndicator extends StatelessWidget {
  final bool loading;
  const InnerPageLoadingIndicator({required this.loading, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    //
    return loading
        ? const LinearProgressIndicator(
            minHeight: 5,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green))
        : const SizedBox(height: 0.5);
  }
}
