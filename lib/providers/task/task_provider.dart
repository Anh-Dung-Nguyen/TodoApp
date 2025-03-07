import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/data/data.dart';
import 'package:todoapp/providers/providers.dart';
import 'package:todoapp/providers/task/task_notifier.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, TaskState> ((ref) {
  final respository = ref.watch(taskRepositoryProvider);

  return TaskNotifier(respository);
});