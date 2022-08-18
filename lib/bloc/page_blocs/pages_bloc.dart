import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:http/http.dart' as http;
import 'package:rick_n_morty_fan_app/Models/ApiPage.dart';
import 'package:rick_n_morty_fan_app/Models/Character.dart';
import 'package:rick_n_morty_fan_app/Models/StatusEnum.dart';
import 'package:stream_transform/stream_transform.dart';
part 'pages_event.dart';
part 'pages_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PageBloc extends Bloc<PagesEvent, PageState> {
  PageBloc({required this.httpClient}) : super(PageState()) {
    on<PreviousPage>(_fetchPreviousPage,
        transformer: throttleDroppable(throttleDuration));
    on<NextPage>(_fetchNextPage,
        transformer: throttleDroppable(throttleDuration));
    on<GoToFirstPage>(_getFirstPage,
        transformer: throttleDroppable(throttleDuration));
  }

  final http.Client httpClient;

  Future<void> _fetchPreviousPage(
      FetchPage event, Emitter<PageState> emit) async {
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

      emit(state.newPageInfo(
          status: Status.success,
          pageInfo: newPage.info,
          characters: newPage.results!,
          hasReachedMax: newPage.info?.count == requestedPage ? true : false,
          currentPage: requestedPage));
    } catch (e) {
      emit(state.newPageInfo(status: Status.failure));
    }
  }

  Future<void> _fetchNextPage(FetchPage event, Emitter<PageState> emit) async {
    try {
      // if there is no data in the state, request the first page
      if (state.pageInfo == null || state.status == Status.initial) {
        final newPage = await _fetchPage(1);
        return emit(
          state.newPageInfo(
              status: Status.success,
              pageInfo: newPage.info,
              characters: newPage.results!,
              hasReachedMax: false,
              currentPage: 1),
        );
      }

      var requestedPage = _getLinkPage(state.pageInfo!.next!);

      final newPage = await _fetchPage(requestedPage);

      emit(state.newPageInfo(
          status: Status.success,
          pageInfo: newPage.info,
          characters: newPage.results!,
          hasReachedMax: newPage.info?.count == requestedPage ? true : false,
          currentPage: requestedPage));
    } catch (e) {
      emit(state.newPageInfo(status: Status.failure));
    }
  }

  Future<void> _getFirstPage(FetchPage event, Emitter<PageState> emit) async {
    state.status = Status.initial;
    // set the status to initial so the fetch next page method asks for the first page
    await _fetchNextPage(event, emit);
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

  /// Helper method to extract the int of the page from the URL
  /// https://rickandmortyapi.com/api/character/?page= -> 19 <-
  int _getLinkPage(String link) {
    return int.parse(Uri.dataFromString(link).queryParameters['page']!);
  }
}
