import 'package:flutter/material.dart';

class TranslationInherited extends InheritedWidget {
  List<dynamic>? translation;
  TranslationInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  static TranslationInherited of(BuildContext context) {
    final TranslationInherited result = context.dependOnInheritedWidgetOfExactType<TranslationInherited>()!;
    return result;
  }

  @override
  bool updateShouldNotify(TranslationInherited old) {
    return translation != null && translation != old.translation;
  }
}