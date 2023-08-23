import 'package:character_viewer/common/app_config.dart';
import 'package:flutter/material.dart';

import '../widgets/character_list.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/search_text_field.dart';

class ListingScreen extends StatelessWidget {
  static const name = 'listing';
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: config.appDisplayName, //change this based on flavor
        ),
        body: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SearchTextField(),
              Expanded(
                child: CharacterList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
