import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_n_morty_fan_app/Models/Character.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(const CharacterState()) {
    on<FetchCharacter>(_fetchSelectedCharacter);
  }

  void _fetchSelectedCharacter(
    FetchCharacter event,
    Emitter<CharacterState> emit,
  ) async {
    try {
      var idFromEvent = event.id;
      print(idFromEvent);
    } catch (e) {
      print(e);
    }
  }
}
