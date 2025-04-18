import 'package:flutter/material.dart';

extension NavigationHelper on BuildContext {
  Future<T?>? pushNamed<T extends Object?>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }
  Future<T?>? pushNamedAndRemoveUntil<T extends Object?>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamedAndRemoveUntil(routeName, (route) => false, arguments: arguments);
  }
  Future<T?>? pushReplacementNamed<T extends Object?>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }
  void pop() => Navigator.of(this).pop();

}