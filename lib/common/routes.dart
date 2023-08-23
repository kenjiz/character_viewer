import 'package:flutter/material.dart';
import '../models/character.dart';
import '../screens/screens.dart';

class AppRoutes {
  const AppRoutes._();

  static Route<dynamic>? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case ListingScreen.name:
        return _navigateTo(const ListingScreen());
      case CharacterScreen.name:
        final character = settings.arguments as Character;
        return _navigateTo(CharacterScreen(character: character));
      default:
        return _navigateTo(const NotFoundScreen());
    }
  }

  static MaterialPageRoute _navigateTo(
    Widget child, {
    RouteSettings? settings,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return WrapperScreen(child: child);
      },
      settings: settings,
    );
  }
}
