import 'package:flutter/material.dart';

import 'common/app_config.dart';
import 'main_common.dart';
import 'models/character_type.dart';

void main() {
  var configureApp = const AppConfig(
    CharacterType.simpsons,
    'Simpsons Viewer',
    MyApp(),
  );

  mainCommon();
  runApp(configureApp);
}
