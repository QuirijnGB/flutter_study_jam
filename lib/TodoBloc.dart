import 'dart:async';

import 'package:flutter_study_jam_week_2/TodoEntity.dart';
import 'package:flutter_study_jam_week_2/TodoService.dart';
import 'package:rxdart/rxdart.dart';

class TodoBloc {
  final TodoService service;

  final _todosSubject = BehaviorSubject<List<TodoEntity>>();

  TodoBloc(this.service) {
    this.service.articles.pipe(_todosSubject);
  }

  Stream<List<TodoEntity>> get todos => _todosSubject.stream;
}
