import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/data/data.dart';

final taskRepositoryProvider = Provider<TaskRepositories>((ref) {
  final datasource = ref.watch(taskDataSourceProvider);

  return TaskRepositoryImplement(datasource);
});