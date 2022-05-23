
import 'package:flutter/material.dart';

import 'models/replace_model.dart';

class ReplaceInherited extends InheritedNotifier<ReplaceModel> {
  final ReplaceModel model;

  const ReplaceInherited({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child, notifier: model);

  static ReplaceModel of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<ReplaceInherited>()!.model;
    return result;
  }
}
