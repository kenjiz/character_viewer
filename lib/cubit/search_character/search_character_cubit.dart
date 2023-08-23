import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_character_state.dart';

class SearchCharacterCubit extends Cubit<SearchCharacterState> {
  SearchCharacterCubit() : super(SearchCharacterState.initial());

  void setSearchTerm(String newSearchTerm) {
    emit(state.copyWith(searchTerm: newSearchTerm));
  }
}
