import 'package:flutter/material.dart';
import 'package:tictactoe/core/design_system/desgin_system.dart';
import 'package:tictactoe/core/design_system/tokens/app_sizes.dart';

class SelectGameModeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final String label;
  final bool isPrimary;
  final IconData? icon;
  final EdgeInsets? margin;

  const SelectGameModeButton(
    this.label, {
    required this.onPressed,
    required this.isPrimary,
    required this.color,
    this.margin,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shadowColor: Colors.transparent,
          minimumSize: Size.fromHeight(AppSpacing.xxl),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: Colors.white,
                size: AppSizes.lg,
              ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
