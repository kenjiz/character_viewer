import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../cubit/cubits.dart';
import '../screens/character_screen.dart';

class CharacterList extends StatelessWidget {
  const CharacterList({super.key});

  @override
  Widget build(BuildContext context) {
    final isError = context.watch<CharacterCubit>().state.status.isFailure;
    final isLoading = context.watch<CharacterCubit>().state.status.isLoading;

    return BlocBuilder<FilteredCharacterCubit, FilteredCharacterState>(
      builder: (context, state) {
        if (isError) {
          return const Center(
            child: Text(
              'Some error happens...',
              style: TextStyle(fontSize: 20),
            ),
          );
        }

        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return RefreshIndicator(
          onRefresh: () => context.read<CharacterCubit>().refresh(),
          backgroundColor: Colors.white,
          child: ListView.separated(
            itemBuilder: (context, index) {
              final character = state.filteredCharacters[index];
              return ListTile(
                title: Text(
                  character.name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Device.screenType == ScreenType.tablet
                    ? Text(
                        character.description,
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      )
                    : null,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CharacterScreen(
                        character: character,
                      ),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (_, __) => const Divider(
              color: Colors.black12,
            ),
            itemCount: state.filteredCharacters.length,
          ),
        );
      },
    );
  }
}
