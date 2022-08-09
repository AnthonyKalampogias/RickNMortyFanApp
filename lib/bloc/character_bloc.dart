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
    on<CharacterFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final http.Client httpClient;

  Future<void> _onPostFetched(
      CharacterFetched event, Emitter<CharacterState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == Status.initial) {
        final apiPage = await _fetchPage(0);
        return emit(
          state.newPageInfo(
            status: Status.success,
            pageInfo: apiPage,
            hasReachedMax: false,
          ),
        );
      }
      final newPage = await _fetchPage(state.pageInfo!.results!.length);
      newPage.info?.next ==
              null // if the page info says there is no next page, set hasReachedMax to true
          ? emit(state.newPageInfo(hasReachedMax: true))
          : emit(
              state.newPageInfo(
                status: Status.success,
                pageInfo: newPage,
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.newPageInfo(status: Status.failure));
    }
  }

  Future<ApiPage> _fetchPage(int page) async {
    try {
      var response = await httpClient.get(
        Uri.https(
          'https://rickandmortyapi.com',
          '/api/character',
          <String, int>{'page': page},
        ),
      );
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
}
