import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool disabled;

  const PrimaryButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.disabled = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      child: Text(
        text,
        style: theme.textTheme.bodyMedium
            ?.copyWith(color: theme.colorScheme.onPrimary),
      ),
    );
  }
}
