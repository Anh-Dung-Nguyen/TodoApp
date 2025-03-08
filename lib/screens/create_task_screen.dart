import 'package:flutter/material.dart';
import 'package:todoapp/config/routes/routes.dart';
import 'package:todoapp/data/models/models.dart';
import 'package:todoapp/providers/date_provider.dart';
import 'package:todoapp/providers/providers.dart';
import 'package:todoapp/utils/app_alerts.dart';
import 'package:todoapp/utils/helpers.dart';
import 'package:todoapp/widgets/common_text_field.dart';
import 'package:todoapp/widgets/display_white_text.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/widgets/select_category.dart';
import 'package:todoapp/widgets/select_date_time.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(BuildContext context, GoRouterState state) => const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DisplayWhiteText(text: 'Add New Task'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                title: 'Task Title',
                hintText: 'Task Title',
                controller: _titleController,
              ),
              const Gap(16.0),
              const SelectCategory(),
              const Gap(16.0),
              const SelectDateTime(),
              const Gap(16),
              CommonTextField(
                title: 'Note',
                hintText: 'Task note',
                maxLines: 6,
                controller: _noteController,
              ),
              const Gap(60),
              ElevatedButton(
                onPressed: _createTask, 
                child: const DisplayWhiteText(
                  text: 'Save'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);
    final category = ref.watch(categoryProvider);

    if (title.isNotEmpty) {
      final task = Task(
        title: title, 
        note: note, 
        time: Helpers.timeToString(time), 
        date: DateFormat.yMMMd().format(date), 
        category: category, 
        isCompleted: false,
      );

      await ref.read(taskProvider.notifier).createTask(task).then((value) {
        AppAlerts.displaySnackbar(
          context,
          'Task created successfully',
        );

        context.go(RouteLocation.home);
      });
    } else {
      AppAlerts.displaySnackbar(
        context,
        'Task title cannot be empty',
      );
    }
  }
}