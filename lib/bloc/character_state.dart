part of 'character_bloc.dart';

enum Status { initial, success, failure }

class CharacterState {
  const CharacterState({
    this.status = Status.initial,
    this.pageInfo,
    this.characters = const <Character>[],
    this.hasReachedMax = false,
  });

  final Status status;
  final List<Character> characters;
  final Info? pageInfo;
  final bool hasReachedMax;

  CharacterState newPageInfo({
    Status? status,
    List<Character>? characters,
    Info? pageInfo,
    bool? hasReachedMax,
  }) {
    return CharacterState(
      status: status ?? this.status,
      pageInfo: pageInfo ?? this.pageInfo,
      characters: characters ?? this.characters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, hasReachedMax];
}
