import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_n_morty_fan_app/Models/Character.dart';
import 'package:http/http.dart' as http;
import 'package:rick_n_morty_fan_app/Models/StatusEnum.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc() : super(const CharacterState()) {
    on<FetchCharacter>(_fetchSelectedCharacter);
  }

  final http.Client httpClient = http.Client();

  void _fetchSelectedCharacter(
    FetchCharacter event,
    Emitter<CharacterState> emit,
  ) async {
    try {
      if (event.id <= 0) {
        emit(state.setNewCharacter(status: Status.failure));
      }
      var char = await _fetchCharacter(event.id);
      emit(state.setNewCharacter(character: char));
    } catch (e) {
      print(e);
      emit(state.setNewCharacter(status: Status.failure));
    }
  }

  Future<Character> _fetchCharacter(int charID) async {
    try {
      var response = await http
          .get(Uri.parse("http://rickandmortyapi.com/api/character/$charID"));

      // Check if status code anything but 200 (OK)
      if (response.statusCode != 200) {
        throw Exception('error fetching newPage');
      }
      // else parse JSON to the Character class
      return Character.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('error fetching newPage');
    }
  }
}
