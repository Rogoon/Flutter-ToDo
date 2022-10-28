
import 'package:flutter/material.dart';
import 'model/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'My ToDos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Todo> todos = [];
  String newTodoText = "";
  final TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New Todo'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  newTodoText = value;
                });
              },
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: "\"Walk the dog\""),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () {
                  setState(() {
                    newTodoText = "";
                    _textFieldController.clear();
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  setState(() {
                    todos.add(Todo(newTodoText));
                    newTodoText = "";
                    _textFieldController.clear();
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  _toggleTodo(int index, bool value){
    setState(() {
      todos[index].isDone = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text(todos[index].text),
                trailing: Checkbox(
                  value: todos[index].isDone,
                  onChanged: (bool? value) {
                    _toggleTodo(index, value??false);
                  },
                ),
              );
            }
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayTextInputDialog(context),
        tooltip: 'New Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
