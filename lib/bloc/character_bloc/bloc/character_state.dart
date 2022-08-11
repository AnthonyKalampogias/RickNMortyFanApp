part of 'character_bloc.dart';

class CharacterState {
  const CharacterState({this.character});

  final Character? character;
  CharacterState setNewCharacter({Character? character}) {
    return CharacterState(character: character ?? this.character);
  }
}
