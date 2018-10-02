import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GDG Flutter Sydney',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        accentColor: Colors.amberAccent,
      ),
      home: MyHomePage(title: 'GDG Flutter Sydney'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final newTodoController = TextEditingController();

  List<TodoEntity> todos = [];

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  void _loadData() {
    Firestore.instance.collection('todos').snapshots().listen((snapshot) {
      List<TodoEntity> entities = snapshot.documents.map((docSnapshot) {
        print(docSnapshot.data);
        return TodoEntity(
          todo: docSnapshot.data['todo'],
          done: docSnapshot.data['done'],
        );
      }).toList();
      setState(() {
        this.todos = entities;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextFormField(
                      controller: newTodoController,
                      decoration:
                          InputDecoration(labelText: "What needs to be done?"),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print(newTodoController.text);
                    setState(() {
                      todos.add(TodoEntity(
                          todo: newTodoController.text, done: false));
                    });
                    newTodoController.clear();
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: todos.map((todo) => TodoListItem(todo: todo)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    newTodoController.dispose();
    super.dispose();
  }
}

class TodoListItem extends StatelessWidget {
  final todo;

  const TodoListItem({
    Key key,
    this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(todo.todo),
        ),
      ),
    );
  }
}

class TodoEntity {
  String todo;
  bool done;

  TodoEntity({
    @required this.todo,
    @required this.done,
  });
}
