part of 'pages_bloc.dart';

class PageState {
  PageState({
    this.status = Status.initial,
    this.pageInfo,
    this.characters = const <Character>[],
    this.hasReachedMax = false,
    this.currentPage,
  });

  Status status;
  final List<Character> characters;
  final Info? pageInfo;
  final bool hasReachedMax;
  final int? currentPage;

  PageState newPageInfo({
    Status? status,
    List<Character>? characters,
    Info? pageInfo,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return PageState(
      status: status ?? this.status,
      pageInfo: pageInfo ?? this.pageInfo,
      characters: characters ?? this.characters,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  List<Object> get props => [status, hasReachedMax];
}
