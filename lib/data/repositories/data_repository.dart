import 'package:flutter_assignments/data/model/rich_todo.dart';
import 'package:flutter_assignments/data/model/todo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/user.dart';

class DataRepository {
  static const String authority = 'jsonplaceholder.typicode.com';
  static const String todoList = 'todos';
  static const String userList = 'users';
  static const int pageSize = 200;
  List<User> users = [];
  int currentPage = 0;

  Future<List<RichToDo>> getRichTodoList(int page) async {
    currentPage = page;
    List<RichToDo> result = [];

    if (users.isEmpty) {
      await Future.wait([getTodoList(page), getUserList()]).then((value) {
        final todos = value[0] as List<ToDo>;
        users = value[1] as List<User>;
        result = _getRichToDo(todos, users);
      }, onError: (err) {
        return Future.error(
            "Error Info", StackTrace.fromString("StackTrace Error message"));
      });
    } else {
      final todos = await getTodoList(page);
      result = _getRichToDo(todos, users);
    }

    return result;
  }

  Future<List<ToDo>> getTodoList(int page) async {
    currentPage = page;
    List<ToDo> result = [];
    try {
      var url = Uri.https(authority, todoList, <String, String>{
        '_start': '${(page - 1) * pageSize}',
        '_limit': '$pageSize'
      });
      var todoResponse = await http.get(url);
      if (todoResponse.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(todoResponse.body) as List<dynamic>;
        result = jsonResponse.map((i) => ToDo.fromJson(i)).toList();
      } else {
        return Future.error("Error ${todoResponse.statusCode}",
            StackTrace.fromString("StackTrace Error message"));
      }
    } catch (e) {
      return Future.error(
          "Error Info", StackTrace.fromString("StackTrace Error message"));
    }
    return result;
  }

  Future<List<User>> getUserList() async {
    List<User> users = [];
    try {
      var url = Uri.https(authority, userList);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
        users = jsonResponse.map((e) => User.fromJson(e)).toList();
      } else {
        return Future.error("Error ${response.statusCode}",
            StackTrace.fromString("StackTrace Error message"));
      }
    } catch (e) {
      return Future.error(
          "Error Info", StackTrace.fromString("StackTrace Error message"));
    }
    return users;
  }

  List<RichToDo> _getRichToDo(List<ToDo> todos, List<User> users) {
    List<RichToDo> result = [];
    for (var todo in todos) {
      var userIterable = users.where((user) => user.id == todo.userId);
      result.add(RichToDo(todo, userIterable.first));
    }
    return result;
  }
}
