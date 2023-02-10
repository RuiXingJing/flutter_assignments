import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_assignments/data/model/rich_todo.dart';
import 'package:flutter_assignments/data/repositories/data_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'lazy_todo_event.dart';

part 'lazy_todo_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class LazyToDoBloc extends Bloc<LazyToDoEvent, LazyToDoState> {
  LazyToDoBloc() : super(const LazyToDoState()) {
    on<LazyToDoFetched>(_onLazyTodoFetched,
        transformer: throttleDroppable(throttleDuration));

    on<LazyToDoReload>(_onLazyTodoReload,
        transformer: throttleDroppable(throttleDuration));
  }

  final DataRepository dataRepository = DataRepository();

  Future<void> _onLazyTodoFetched(
      LazyToDoFetched event, Emitter<LazyToDoState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == LazyTodoStatus.initial) {
        final todos = await dataRepository.getRichTodoList(isPaging: true);
        return emit(state.copyWith(
            status: LazyTodoStatus.success,
            lazyTodos: todos,
            hasReachedMax: false));
      }

      final todos = await dataRepository.getRichTodoList(
          startIndex: state.lazyTodos.length, isPaging: true);
      emit(todos.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: LazyTodoStatus.success,
              lazyTodos: List.of(state.lazyTodos)..addAll(todos),
              hasReachedMax: false));
    } catch (e) {
      emit(state.copyWith(status: LazyTodoStatus.failure));
    }
  }

  Future<void> _onLazyTodoReload(
      LazyToDoReload event, Emitter<LazyToDoState> emit) async {
    emit(state.copyWith(
        status: LazyTodoStatus.initial, lazyTodos: [], hasReachedMax: false));
  }
}
