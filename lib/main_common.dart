import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'common/app_config.dart';
import 'common/routes.dart';
import 'models/character_type.dart';
import 'repositories/character_repository.dart';

void mainCommon() {
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppConfig? config = AppConfig.of(context);

    return RepositoryProvider<CharacterRepository>(
      create: (context) => CharacterRepository(
        characterType: config.characterType,
      ), // change this on flavor
      child: ResponsiveSizer(
        builder: (context, _, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: config.appDisplayName,
          theme: theme(config),
          onGenerateRoute: (settings) => AppRoutes.generateRoutes(settings),
        ),
      ),
    );
  }

  ThemeData theme(AppConfig? config) {
    return config?.characterType == CharacterType.simpsons
        ? ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.yellowAccent,
                background: Colors.yellow,
                primary: Colors.black),
            useMaterial3: true,
          )
        : ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                background: Colors.black,
                brightness: Brightness.dark),
          );
  }
}
