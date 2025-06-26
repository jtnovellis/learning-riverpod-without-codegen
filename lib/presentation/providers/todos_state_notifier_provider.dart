import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/config/helpers/random_generator.dart';
import 'package:riverpod_app/domain/domain.dart';
import 'package:riverpod_app/presentation/providers/todo_providers.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

final filteredTodosStateNotifierProvider = Provider<List<Todo>>((ref) {
  final selectedFilter = ref.watch(todoFilterProvider);
  final todos = ref.watch(todosStateNotifierProvider);

  switch (selectedFilter) {
    case TodoFilter.all:
      return todos;
    case TodoFilter.completed:
      return todos.where((todo) => todo.completedAt != null).toList();
    case TodoFilter.pending:
      return todos.where((todo) => todo.completedAt == null).toList();
  }
});

final todosStateNotifierProvider =
    StateNotifierProvider<TodosStateNotifier, List<Todo>>((ref) {
  return TodosStateNotifier();
});

class TodosStateNotifier extends StateNotifier<List<Todo>> {
  TodosStateNotifier()
      : super([
          Todo(
            id: _uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: DateTime.now(),
          ),
          Todo(
            id: _uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: null,
          ),
          Todo(
            id: _uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: DateTime.now(),
          ),
          Todo(
            id: _uuid.v4(),
            description: RandomGenerator.getRandomName(),
            completedAt: null,
          ),
        ]);

  void addTodo() {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null,
      ),
    ];
  }

  void toggleTodo(String id) {
    state = state.map((todo) {
      if (todo.id != id) return todo;

      if (todo.done) {
        return todo.copyWith(completedAt: null);
      }

      return todo.copyWith(completedAt: DateTime.now());
    }).toList();
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}
