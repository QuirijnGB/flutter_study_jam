import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_study_jam_week_2/TodoEntity.dart';
import 'package:flutter_study_jam_week_2/TodoService.dart';

class FirebaseTodoService extends TodoService {
  @override
  Stream<List<TodoEntity>> get articles => Firestore.instance
      .collection('todos')
      .orderBy('done')
      .snapshots()
      .map((QuerySnapshot snapshot) => snapshot.documents
          .map(
            (docSnapshot) => TodoEntity(
                id: docSnapshot.documentID,
                todo: docSnapshot.data["todo"],
                done: docSnapshot.data["done"]),
          )
          .toList());
}
