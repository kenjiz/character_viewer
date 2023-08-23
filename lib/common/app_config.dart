// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../models/character_type.dart';

class AppConfig extends InheritedWidget {
  final CharacterType characterType;
  final String appDisplayName;

  const AppConfig(this.characterType, this.appDisplayName, Widget child,
      {super.key})
      : super(child: child);

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
