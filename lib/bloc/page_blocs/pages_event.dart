part of 'pages_bloc.dart';

abstract class PagesEvent {
  @override
  List<Object> get props => [];
}

class FetchPage extends PagesEvent {}

class PreviousPage extends FetchPage {}

class NextPage extends FetchPage {}
