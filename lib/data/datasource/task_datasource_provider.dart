import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/data/data.dart';

final taskDataSourceProvider = Provider<TaskDatasource>((ref) {
  return TaskDatasource();
});