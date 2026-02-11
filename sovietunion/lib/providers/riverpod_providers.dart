import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Simple counter using Riverpod StateProvider
/// This is the most basic form of state management in Riverpod
final counterProvider = StateProvider<int>((ref) => 0);

/// Model for a task item
class Task {
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
  });

  Task copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

/// StateNotifier for managing a list of tasks
/// This demonstrates more complex state management with Riverpod
class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]);

  void addTask(String title) {
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      createdAt: DateTime.now(),
    );
    state = [...state, task]; // Immutable update pattern
  }

  void toggleTask(String id) {
    state = [
      for (final task in state)
        if (task.id == id)
          task.copyWith(isCompleted: !task.isCompleted)
        else
          task,
    ];
  }

  void removeTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }

  void clearCompleted() {
    state = state.where((task) => !task.isCompleted).toList();
  }

  void clearAll() {
    state = [];
  }
}

/// Provider for tasks state
final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});

/// Derived provider - counts completed tasks
final completedTasksCountProvider = Provider<int>((ref) {
  final tasks = ref.watch(tasksProvider);
  return tasks.where((task) => task.isCompleted).length;
});

/// Derived provider - counts pending tasks
final pendingTasksCountProvider = Provider<int>((ref) {
  final tasks = ref.watch(tasksProvider);
  return tasks.where((task) => !task.isCompleted).length;
});

/// Theme mode provider - demonstrates simple settings management
final themeModeProvider = StateProvider<bool>((ref) => false); // false = light, true = dark
