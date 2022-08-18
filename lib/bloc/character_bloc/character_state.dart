part of 'character_bloc.dart';

class CharacterState {
  const CharacterState({this.status, this.character});

  final Character? character;
  final Status? status;
  CharacterState setNewCharacter({Character? character, Status? status}) {
    return CharacterState(
      character: character ?? this.character,
      status: status ?? this.status,
    );
  }
}
