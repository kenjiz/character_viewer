import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/character.dart';
import '../../repositories/character_repository.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository _characterRepository;

  CharacterCubit(this._characterRepository) : super(CharacterState.initial());

  Future<void> fetchCharacters() async {
    emit(state.copyWith(status: CharacterStatus.loading));

    try {
      final characters = await _characterRepository.getCharacters();

      emit(
        state.copyWith(
          characters: characters,
          status: CharacterStatus.success,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: CharacterStatus.failure));
    }
  }

  Future<void> refresh() async {
    if (state.status == CharacterStatus.success) return;
    try {
      final characters = await _characterRepository.getCharacters();

      emit(state.copyWith(
        characters: characters,
        status: CharacterStatus.success,
      ));
    } catch (_) {
      emit(state);
    }
  }
}
