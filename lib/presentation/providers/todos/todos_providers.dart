import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_app/config/helpers/random_generator.dart';
import 'package:riverpod_app/domain/entities/todo.dart';
import 'package:uuid/uuid.dart';

part 'todos_providers.g.dart';

const uuid = Uuid();

enum FilterType { all, completed, pending }

@Riverpod(keepAlive: true)
class TodoCurrentFilter extends _$TodoCurrentFilter {
  @override
  FilterType build() {
    return FilterType.all;
  }

  void changeFilter(FilterType filter) {
    state = filter;
  }
}

@Riverpod(keepAlive: true)
class Todos extends _$Todos {
  @override
  List<Todo> build() {
    return [
      Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null,
      ),
      Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: DateTime.now(),
      ),
      Todo(
        id: uuid.v4(),
        description: RandomGenerator.getRandomName(),
        completedAt: null,
      ),
    ];
  }

  void addTodo() {
    state = [
      ...state,
      Todo(
        id: uuid.v4(),
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
}

@Riverpod(keepAlive: true)
List<Todo> filteredTodos(Ref ref) {
  final filter = ref.watch(todoCurrentFilterProvider);
  final todos = ref.watch(todosProvider);

  switch (filter) {
    case FilterType.all:
      return todos;
    case FilterType.completed:
      return todos.where((todo) => todo.done).toList();
    case FilterType.pending:
      return todos.where((todo) => !todo.done).toList();
  }
}
