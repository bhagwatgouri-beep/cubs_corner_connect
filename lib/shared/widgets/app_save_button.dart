import 'package:flutter/material.dart';

class AppSaveButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData icon;
  final bool isLoading;

  const AppSaveButton({
    super.key,
    this.text = 'Save',
    required this.onPressed,
    this.icon = Icons.save,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? const SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        )
            : Icon(icon),
        label: Text(text),
      ),
    );
  }
}