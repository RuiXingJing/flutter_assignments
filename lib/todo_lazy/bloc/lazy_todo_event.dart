part of 'lazy_todo_bloc.dart';

abstract class LazyToDoEvent extends Equatable {
  const LazyToDoEvent();

  @override
  List<Object> get props => [];
}

class LazyToDoFetched extends LazyToDoEvent {}

class LazyToDoReload extends LazyToDoEvent{}
