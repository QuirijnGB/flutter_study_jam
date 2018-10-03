import 'dart:async';

import 'package:flutter_study_jam_week_2/TodoEntity.dart';

abstract class TodoService {
  Stream<List<TodoEntity>> get articles;
}
