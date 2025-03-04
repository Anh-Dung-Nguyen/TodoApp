import 'package:flutter/material.dart';
import 'package:todoapp/widgets/common_text_field.dart';
import 'package:todoapp/widgets/display_white_text.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';

class CreateTaskScreen extends StatelessWidget {
  static CreateTaskScreen builder(BuildContext context, GoRouterState state) => const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DisplayWhiteText(text: 'Add New Task'),
      ),
      body: const SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            CommonTextField(
              title: 'Task Title',
              hintText: 'Task Title',
            ),
            const Gap(16.0),
            Row(
              children: [
                Expanded(
                  child: CommonTextField(
                    title: 'Date',
                    hintText: 'March, 04',
                  ),
                ),
                const Gap(10.0),
                Expanded(
                  child: CommonTextField(
                    title: 'Time',
                    hintText: '23:45',
                  ),
                ),
              ],
            ),
            const Gap(16),
            CommonTextField(
              title: 'Note',
              hintText: 'Task note',
              maxLines: 6,
            ),
          ],
        ),
      ),
    );
  }
}