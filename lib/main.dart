import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo_app_stream/models/todo_model.dart';
import 'package:todo_app_stream/services/todo_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TodoService todoService = TodoService(initialValue : todosData);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: StreamBuilder(
              stream: todoService.todos,
              builder: (context, AsyncSnapshot<List<TodosModel>> snapshot) {
                if (snapshot.hasError) {
                  return const Text("Something went wrong");
                }
                if (snapshot.hasData) {
                  final todos = snapshot.data;

                  return (todos ?? []).isEmpty
                      ? const Text("No todos found")
                      : ListView.builder(
                          itemCount: todos != null ? todos.length : 0,
                          itemBuilder: (context, index) {
                            final todo = (todos ?? [])[index];
                            return Card(
                              margin: const EdgeInsets.all(16.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Checkbox(
                                        value: todo.isComplete,
                                        onChanged: (value) => todoService.updateTodo(todo.id)),
                                    Text(todo.title),
                                    IconButton(
                                        onPressed: () =>
                                            todoService.removeTodo(todo.id),
                                        icon: const Icon(Icons.delete))
                                  ],
                                ),
                              ),
                            );
                          });
                }
                return const CircularProgressIndicator();
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => todoService.addTodo(TodosModel(
              id: UniqueKey().toString(),
              title: "Learn css",
              isComplete: false)),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
