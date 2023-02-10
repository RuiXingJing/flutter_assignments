import 'package:flutter/material.dart';
import 'package:flutter_assignments/data/repositories/data_repository.dart';
import 'package:flutter_assignments/todo/todo_item.dart';

import '../constants.dart';
import '../data/model/rich_todo.dart';

class TodoMainPage extends StatefulWidget {
  const TodoMainPage({super.key});

  @override
  State<StatefulWidget> createState() => _TodoMainPageState();
}

class _TodoMainPageState extends State<TodoMainPage> {
  late Future<List<RichToDo>> todoList;
  final DataRepository dataRepo = DataRepository();

  @override
  void initState() {
    super.initState();
    todoList = dataRepo.getRichTodoList(++dataRepo.currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            Strings.pageTitleTodo,
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          child: FutureBuilder<List<RichToDo>>(
              future: todoList,
              builder: (context, snapshot) {
                return RefreshIndicator(
                    onRefresh: _onReload, child: _listView(snapshot));
              }),
        ));
  }

  _listView(AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return TodoItemWidget(toDoItem: snapshot.data[index]);
          });
    } else if (snapshot.hasError) {
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
    } else {
      return const CircularProgressIndicator();
    }
  }

  Future<void> _onReload() async {
    List<RichToDo> result = await dataRepo.getRichTodoList(1);
    setState(() {
      todoList = Future.value(result);
    });
  }
}
