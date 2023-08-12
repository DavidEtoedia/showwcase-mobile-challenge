import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poke_mon/utils.dart';

class TextFormInput extends StatelessWidget {
  const TextFormInput(
      {Key? key,
      this.controller,
      this.autovalidateMode,
      this.validator,
      this.labelText,
      this.inputFormatters,
      this.obscureText = false,
      this.suffixIcon,
      this.prefixIcon,
      this.onChanged,
      this.focusNode,
      this.keyboardType})
      : super(key: key);

  final String? labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters ??
          [
            FilteringTextInputFormatter.deny(RegExp('[ ]')),
            FilteringTextInputFormatter(RegExp(r'[a-zA-Z-@]'), allow: true),
          ],
      obscureText: obscureText,
      style: Theme.of(context)
          .textTheme
          .labelSmall
          ?.copyWith(fontWeight: AppFontWeight.medium, fontSize: 14),
      textInputAction: TextInputAction.done,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        iconColor: Colors.grey,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: labelText,
        hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 14,
              fontWeight: AppFontWeight.light,
            ),
      ),
      validator: validator,
    );
  }
}
