import 'dart:async';

import 'package:flutter_study_jam_week_2/TodoEntity.dart';
import 'package:flutter_study_jam_week_2/TodoService.dart';
import 'package:rxdart/rxdart.dart';

class TodoBloc {
  final TodoService _service;

  final _todosSubject = BehaviorSubject<List<TodoEntity>>();

  TodoBloc(this._service) {
    this._service.articles.pipe(_todosSubject);
  }

  Stream<List<TodoEntity>> get todos => _todosSubject.stream;

  Future<void> addArticle(TodoEntity todo) => _service.addArticle(todo);

  Future<void> updateTodo(TodoEntity todo) => _service.updateArticle(todo);

  Future<void> deleteTodo(String id) => _service.deleteArticle(id);
}
