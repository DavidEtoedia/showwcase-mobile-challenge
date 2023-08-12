import 'package:flutter/material.dart';
import 'package:poke_mon/utils.dart';

class RetryButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool isLoading;
  const RetryButton(
      {super.key, required this.text, this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        const Space(20),
        isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              )
            : TextButton(
                onPressed: onPressed,
                child: const Text(
                  "Retry",
                  style: TextStyle(fontSize: 18),
                ))
      ],
    );
  }
}
