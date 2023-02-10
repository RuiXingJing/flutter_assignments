part of 'lazy_todo_bloc.dart';

enum LazyTodoStatus { initial, success, failure }

class LazyToDoState extends Equatable {
  const LazyToDoState(
      {this.status = LazyTodoStatus.initial,
      this.lazyTodos = const <RichToDo>[],
      this.hasReachedMax = false});

  final LazyTodoStatus status;
  final List<RichToDo> lazyTodos;
  final bool hasReachedMax;

  LazyToDoState copyWith({
    LazyTodoStatus? status,
    List<RichToDo>? lazyTodos,
    bool? hasReachedMax,
  }) {
    return LazyToDoState(
        status: status ?? this.status,
        lazyTodos: lazyTodos ?? this.lazyTodos,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  String toString() {
    return 'LazyToDoState { status: $status, hasReachedMax: $hasReachedMax, lazyTodos: ${lazyTodos.length}}';
  }

  @override
  List<Object> get props => [status, lazyTodos, hasReachedMax];
}
