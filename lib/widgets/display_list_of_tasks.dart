import 'package:flutter/material.dart';
import 'package:todoapp/utils/extensions.dart';
import 'package:todoapp/widgets/common_container.dart';
import 'package:todoapp/widgets/widgets.dart';
import '../data/data.dart' show Task;

class DisplayListOfTasks extends StatelessWidget {
  const DisplayListOfTasks({
    super.key,
    required this.tasks,
    this.isCompletedTasks = false,
    });

  final List<Task> tasks;
  final bool isCompletedTasks;

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final height = isCompletedTasks ? deviceSize.height * 0.25 : deviceSize.height * 0.3;
    final emptyTasksMessage = isCompletedTasks ? 'There is no completed task yet' : 'There is no task to do!';

    return CommonContainer(
      height: height,
      child: tasks.isEmpty 
        ? Center(
          child: Text(
            emptyTasksMessage,
            style: context.textTheme.headlineSmall,
          ),
        ) 
        : ListView.separated(
          shrinkWrap: true,
          itemCount: tasks.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskTile(task: task);
          }, 
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(thickness: 1.5);
          },
        ),
    );
  }
}