part of 'character_bloc.dart';

abstract class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class FetchCharacter extends CharacterEvent {
  const FetchCharacter(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
