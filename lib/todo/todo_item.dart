import 'package:flutter/material.dart';
import 'package:flutter_assignments/data/model/rich_todo.dart';

import '../constants.dart';

class TodoItemWidget extends StatelessWidget {
  TodoItemWidget({required this.toDoItem}) : super(key: ObjectKey(toDoItem));

  final RichToDo toDoItem;

  TextStyle _getTitleStyle(BuildContext context) {
    return const TextStyle(
        color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 16);
  }

  TextStyle _getSubTitleStyle(BuildContext context) {
    return const TextStyle(
        color: Colors.black54, fontWeight: FontWeight.normal, fontSize: 13);
  }

  Color _getColor(BuildContext context) {
    return toDoItem.todo.completed ? Colors.green : Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          backgroundColor: _getColor(context),
          child: NewWidget(toDoItem: toDoItem)),
      title: Text(
        '[Title]: ${toDoItem.todo.title}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: _getTitleStyle(context),
      ),
      subtitle: Text(
        'ID: ${toDoItem.todo.id}  Assignee: ${toDoItem.user.username}  State: ${toDoItem.todo.completed ? Strings.labelCompleted : Strings.labelTodo}',
        style: _getSubTitleStyle(context),
      ),
      // trailing: Text(toDoItem.id.toString()),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
    required this.toDoItem,
  }) : super(key: key);

  final RichToDo toDoItem;

  @override
  Widget build(BuildContext context) {
    return Text(toDoItem.todo.completed ? 'C' : 'T',
        style: const TextStyle(color: Colors.white));
  }
}
