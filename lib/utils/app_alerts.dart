import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapp/utils/utils.dart';

class AppAlerts {
  AppAlerts._();

  static displaySnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.surface,
          ),
        ),
        backgroundColor: context.colorScheme.primary,
      ),
    );
  }
}