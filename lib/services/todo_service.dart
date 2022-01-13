import 'package:rxdart/rxdart.dart';
import 'package:todo_app_stream/models/todo_model.dart';

class TodoService {
  final List<TodosModel> _initialValue;

  TodoService({required List<TodosModel> initialValue})
      : _initialValue = initialValue {
    init();
  }

  final _todosList = BehaviorSubject.seeded(<TodosModel>[]);

  ValueStream<List<TodosModel>> get todos => _todosList.stream;

  void init() {
    _todosList.add(_initialValue);
  }

  addTodo(TodosModel newTodo) {
    final currentTodos = _todosList.value;
    currentTodos.add(newTodo);
    _todosList.add(currentTodos);
  }

  removeTodo(String todoId) {
    final currentTodos = _todosList.value;
    currentTodos.removeWhere((item) => item.id == todoId);
    _todosList.add(currentTodos);
  }

  updateTodo(String todoId) {
    List<TodosModel> currentTodos = _todosList.value;
    currentTodos = currentTodos.map((item) {
      if (item.id == todoId) {
        item.isComplete = !item.isComplete;
      }
      return item;
    }).toList();
    _todosList.add(currentTodos);
  }
}
