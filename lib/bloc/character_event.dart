part of 'character_bloc.dart';

abstract class CharacterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPage extends CharacterEvent {}

class PreviousPage extends FetchPage {}

class NextPage extends FetchPage {}
