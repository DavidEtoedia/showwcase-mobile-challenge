import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onTextEntered;
  const SearchBox({Key? key, this.hintText = "Search", this.onTextEntered})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        cursorColor: Colors.black,
        onChanged: onTextEntered,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.grey.shade200,
            hintText: hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.grey),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            prefixIcon: const Icon(
              Icons.search,
              size: 24,
              color: Colors.grey,
            )));
  }
}
