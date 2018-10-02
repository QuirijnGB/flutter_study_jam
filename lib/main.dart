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
          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('todos').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');

                List<TodoListItem> listItems = snapshot.data.documents
                    .map((docSnapshot) => TodoEntity.fromJSON(docSnapshot.data))
                    .map((todo) => TodoListItem(todo: todo))
                    .toList();

                return Expanded(
                  child: ListView(
                    children: listItems,
                  ),
                );
              })
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

  factory TodoEntity.fromJSON(Map<String, dynamic> json) {
    return TodoEntity(todo: json['todo'], done: json['done']);
  }
}
