import 'package:flutter/material.dart';
import '../cubit/cubits.dart';
import '../repositories/character_repository.dart';

class WrapperScreen extends StatelessWidget {
  final Widget child;

  const WrapperScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharacterCubit>(
          create: (context) => CharacterCubit(
            context.read<CharacterRepository>(),
          ),
        ),
        BlocProvider<SearchCharacterCubit>(
          create: (context) => SearchCharacterCubit(),
        ),
        BlocProvider<FilteredCharacterCubit>(
          create: (context) => FilteredCharacterCubit(
            characterCubit: context.read<CharacterCubit>()..fetchCharacters(),
            searchCharacterCubit: context.read<SearchCharacterCubit>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
