import 'package:flutter/widgets.dart';

class TodoEntity {
  String id;
  String todo;
  bool done;

  TodoEntity({
    this.id,
    @required this.todo,
    @required this.done,
  });

  Map<String, dynamic> toJSON() {
    return {
      "todo": this.todo,
      "done": this.done,
    };
  }
}
