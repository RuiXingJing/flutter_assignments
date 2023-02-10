import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignments/todo/todo_item.dart';
import 'package:flutter_assignments/todo_lazy/bloc/lazy_todo_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import 'bottom_loader.dart';

class LazyTodoList extends StatefulWidget {
  const LazyTodoList({super.key});

  @override
  State<StatefulWidget> createState() => _LazyTodoListState();
}

class _LazyTodoListState extends State<LazyTodoList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  _bodyContent(LazyToDoState state) {
    switch (state.status) {
      case LazyTodoStatus.failure:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: Text(
                Strings.labelSomethingWentWrong,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: Text(Strings.labelGiveItAnotherTry,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
            ),
            TextButton(
                onPressed: _onReload,
                child: const Text(Strings.buttonTextReload,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.blue)))
          ],
        );
      case LazyTodoStatus.success:
        if (state.lazyTodos.isEmpty) {
          return const Center(child: Text('no todos'));
        }
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return index >= state.lazyTodos.length
                ? const BottomLoader()
                : TodoItemWidget(toDoItem: state.lazyTodos[index]);
          },
          itemCount: state.hasReachedMax
              ? state.lazyTodos.length
              : state.lazyTodos.length + 1,
          controller: _scrollController,
        );
      case LazyTodoStatus.initial:
        return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LazyToDoBloc, LazyToDoState>(builder: (context, state) {
      return RefreshIndicator(
          onRefresh: _onReload, child: Center(child: _bodyContent(state)));
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<LazyToDoBloc>().add(LazyToDoFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Future<void> _onReload() async {
    context.read<LazyToDoBloc>().add(LazyToDoReload());
    context.read<LazyToDoBloc>().add(LazyToDoFetched());
  }
}
