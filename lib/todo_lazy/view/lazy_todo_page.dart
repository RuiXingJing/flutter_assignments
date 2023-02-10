import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignments/todo_lazy/bloc/lazy_todo_bloc.dart';
import 'package:flutter_assignments/todo_lazy/view/lazy_todo_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';

class LazyToDoPage extends StatelessWidget {
  const LazyToDoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.pageTitleLazyTodo),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) {
          return LazyToDoBloc()..add(LazyToDoFetched());
        },
        child: const LazyTodoList(),
      ),
    );
  }
}
