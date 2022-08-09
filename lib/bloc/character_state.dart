part of 'character_bloc.dart';

enum Status { initial, success, failure }

class CharacterState extends Equatable {
  const CharacterState({
    this.status = Status.initial,
    this.pageInfo,
    this.hasReachedMax = false,
  });

  final Status status;
  final ApiPage? pageInfo;
  final bool hasReachedMax;

  CharacterState newPageInfo({
    Status? status,
    ApiPage? pageInfo,
    bool? hasReachedMax,
  }) {
    return CharacterState(
      status: status ?? this.status,
      pageInfo: pageInfo ?? this.pageInfo,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, pageInfo!, hasReachedMax];
}
