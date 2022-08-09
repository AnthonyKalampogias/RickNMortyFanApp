import 'dart:async';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:http/http.dart' as http;
import 'package:rick_n_morty_fan_app/Models/ApiPage.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:rick_n_morty_fan_app/Models/Character.dart';
part 'character_event.dart';
part 'character_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc({required this.httpClient}) : super(const CharacterState()) {
    on<PreviousPage>(_fetchPreviousPage,
        transformer: throttleDroppable(throttleDuration));
    on<NextPage>(_fetchNextPage,
        transformer: throttleDroppable(throttleDuration));
  }

  final http.Client httpClient;

  void _fetchPreviousPage(FetchPage event, Emitter<CharacterState> emit) async {
    try {
      var page = state.pageInfo;

      if (page == null) {
        final newPage = await _fetchPage(1);
        return emit(
          state.newPageInfo(
            status: Status.success,
            pageInfo: newPage.info,
            characters: List.of(state.characters)..addAll(newPage.results!),
            hasReachedMax: false,
          ),
        );
      }

      var requestedPage = _getLinkPage(page.prev!);

      final newPage = await _fetchPage(requestedPage);

      var newState = state.newPageInfo(
        status: Status.success,
        pageInfo: newPage.info,
        characters: newPage.results!,
        hasReachedMax: false,
      );

      newPage.info?.next == null
          ? emit(state.newPageInfo(hasReachedMax: true))
          : emit(newState);
    } catch (e) {
      emit(state.newPageInfo(status: Status.failure));
    }
  }

  void _fetchNextPage(FetchPage event, Emitter<CharacterState> emit) async {
    try {
      var page = state.pageInfo;

      if (page == null) {
        final newPage = await _fetchPage(1);
        return emit(
          state.newPageInfo(
            status: Status.success,
            pageInfo: newPage.info,
            characters: List.of(state.characters)..addAll(newPage.results!),
            hasReachedMax: false,
          ),
        );
      }

      var requestedPage = _getLinkPage(page.next!);

      final newPage = await _fetchPage(requestedPage);

      var newState = state.newPageInfo(
        status: Status.success,
        pageInfo: newPage.info,
        characters: newPage.results!,
        hasReachedMax: false,
      );

      (newPage.info?.next == null)
          ? emit(state.newPageInfo(hasReachedMax: true))
          : emit(newState);
    } catch (e) {
      emit(state.newPageInfo(status: Status.failure));
    }
  }

  Future<ApiPage> _fetchPage(int page) async {
    try {
      var response = await http.get(
          Uri.parse("https://rickandmortyapi.com/api/character/?page=$page"));
      // Check if status code anything but 200 (OK)
      if (response.statusCode != 200) {
        throw Exception('error fetching newPage');
      }
      // else parse JSON to the Character class
      return ApiPage.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('error fetching newPage');
    }
  }

  Future<Character> _fetchCharacter(int charID) async {
    try {
      var response = await httpClient.get(
        Uri.https(
          'https://rickandmortyapi.com',
          '/api/character/$charID',
        ),
      );
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

  /// Helper method to extract the int of the page from the URL
  /// https://rickandmortyapi.com/api/character/?page= -> 19 <-
  int _getLinkPage(String link) {
    return int.parse(Uri.dataFromString(link).queryParameters['page']!);
  }
}
