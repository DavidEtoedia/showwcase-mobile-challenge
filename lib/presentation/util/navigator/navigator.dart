import 'package:flutter/material.dart';

final navigator = Nav();

class Nav {
  /// Navigator state key
  final key = GlobalKey<NavigatorState>();

  /// Navigator's current state
  NavigatorState? get state => key.currentState;

  /// Navigator's current context
  BuildContext get context => state!.context;

  /// Push a named route
  void pushTop(String routeName) {
    // logger.i('Nav: Current Route -> ${(routeName)}');

    state!.pushNamed(routeName);
  }

  /// Push a replacement route
  void replaceTop(
    Widget page, {
    bool isDialog = false,
    bool isTransparent = false,
  }) {
    final route = _materialRoute(
      page,
      isDialog: isDialog,
      isTransparent: isTransparent,
    );
    state!.pushReplacement(route);
  }

  /// Push a  route and replace the root route
  void replaceRoot(
    Widget root, {
    bool isDialog = false,
    bool isTransparent = false,
  }) {
    final route = _materialRoute(
      root,
      isDialog: isDialog,
      isTransparent: isTransparent,
    );
    state?.pushAndRemoveUntil(route, (route) => false);
  }

  /// Push a  route
  void pushTo(Widget page,
      {bool isDialog = false, bool isTransparent = false, String? routeName}) {
    final route = _materialRoute(page,
        isDialog: isDialog, isTransparent: isTransparent, routeName: routeName);
    state!.push(route);
  }

  /// Pop to initial route
  void popToFirst() => state!.popUntil((route) => route.isFirst);

  /// Pop/remove current route
  void popView() => state!.pop();

  /// If ui can pop/remove current route
  bool get canPop => state!.canPop();

  /// Custom material route
  MaterialPageRoute<Object> _materialRoute(
    Widget? widget, {
    String? routeName,
    bool isDialog = false,
    bool isTransparent = false,
  }) {
    // logger.i('Nav: Current Route -> ${(widget.runtimeType)}');

    return MaterialPageRoute(
      fullscreenDialog: isDialog,
      builder: (BuildContext context) => widget!,
      settings: RouteSettings(name: routeName ?? widget.toString()),
    );
  }
}

extension MyNavigator on BuildContext {
  void navigateReplace(
    Widget route, {
    bool isDialog = false,
    bool isTransparent = false,
  }) =>
      navigator.replaceTop(
        route,
        isDialog: isDialog,
        isTransparent: isTransparent,
      );
  void navigateReplaceRoot(
    Widget route, {
    bool isDialog = false,
    bool isTransparent = false,
  }) =>
      navigator.replaceRoot(
        route,
        isDialog: isDialog,
        isTransparent: isTransparent,
      );

  void navigate(Widget route,
          {bool isDialog = false,
          bool isTransparent = false,
          String? routeName}) =>
      navigator.pushTo(route,
          isDialog: isDialog,
          isTransparent: isTransparent,
          routeName: routeName);

  void popToFirst() => navigator.popToFirst();

  void popView() => navigator.popView();

  bool get canPop => navigator.canPop;
}
