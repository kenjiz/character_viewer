import 'package:character_viewer/common/app_config.dart';
import 'package:character_viewer/models/character_type.dart';
import 'package:character_viewer/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../models/character.dart';

class CharacterScreen extends StatelessWidget {
  static const name = 'character';

  final Character character;
  const CharacterScreen({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: character.name,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
                child: Column(
              children: [
                CharacterImage(
                  imageUrl: character.imageUrl,
                ),
                const SizedBox(height: 30),
                Text(
                  character.name,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  character.description,
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}

class CharacterImage extends StatelessWidget {
  final String imageUrl;
  const CharacterImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.of(context);
    return imageUrl.isNotEmpty
        ? Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: 40.h,
          )
        : Image.asset(
            config.characterType == CharacterType.simpsons
                ? 'assets/images/simpsons/simpson_placeholder.png'
                : 'assets/images/the_wire/the_wire_placeholder.jpg',
            fit: BoxFit.cover,
            height: 40.h,
          );
  }
}
