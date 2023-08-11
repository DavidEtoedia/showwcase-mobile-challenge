import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget(
      {super.key,
      required this.value,
      required this.data,
      required this.error,
      required this.loading});
  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget Function(Object, StackTrace) error;
  final Widget Function() loading;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: error,
      loading: loading,
    );
  }
}
