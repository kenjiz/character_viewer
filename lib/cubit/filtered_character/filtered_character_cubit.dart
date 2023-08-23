// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:character_viewer/cubit/character/character_cubit.dart';
import 'package:character_viewer/cubit/search_character/search_character_cubit.dart';

import '../../models/character.dart';

part 'filtered_character_state.dart';

class FilteredCharacterCubit extends Cubit<FilteredCharacterState> {
  final CharacterCubit characterCubit;
  final SearchCharacterCubit searchCharacterCubit;
  // final List<Character> initialCharacters;

  late StreamSubscription characterSubscription;
  late StreamSubscription searchSubscription;

  FilteredCharacterCubit({
    required this.characterCubit,
    required this.searchCharacterCubit,
    // required this.initialCharacters,
  }) : super(FilteredCharacterState.initial()) {
    characterSubscription = characterCubit.stream.listen((_) {
      setFilteredCharacters();
    });
    searchSubscription = searchCharacterCubit.stream.listen((_) {
      setFilteredCharacters();
    });
  }

  void setFilteredCharacters() {
    List<Character> filteredCharacters;
    final searchTerm = searchCharacterCubit.state.searchTerm;

    filteredCharacters = characterCubit.state.characters;

    /// search within character name and description.
    if (searchCharacterCubit.state.searchTerm.isNotEmpty) {
      filteredCharacters = filteredCharacters.where((character) {
        return character.name.toLowerCase().contains(searchTerm) ||
            character.description.toLowerCase().contains(searchTerm);
      }).toList();
    }

    emit(state.copyWith(filteredCharacters: filteredCharacters));
  }

  /// Cancel the subscriptions on cubit disposed.
  @override
  Future<void> close() {
    characterSubscription.cancel();
    searchSubscription.cancel();
    return super.close();
  }
}
