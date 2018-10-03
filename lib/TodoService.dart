import 'dart:async';

import 'package:flutter_study_jam_week_2/TodoEntity.dart';

abstract class TodoService {
  Stream<List<TodoEntity>> get articles;

  Future<void> addArticle(TodoEntity todo);

  Future<void> deleteArticle(String id);

  Future<void> updateArticle(TodoEntity todo);
}
