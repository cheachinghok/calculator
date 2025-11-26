import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOperator;
  final bool isSpecial;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOperator = false,
    this.isSpecial = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: _getButtonColor(context),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: _getTextColor(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getButtonColor(BuildContext context) {
    if (isSpecial) {
      return Theme.of(context).colorScheme.onPrimaryContainer;
    } else if (isOperator) {
      return Theme.of(context).colorScheme.secondary;
    } else {
      return Theme.of(context).colorScheme.surfaceContainerHighest;
    }
  }

  Color _getTextColor(BuildContext context) {
    if (isSpecial || isOperator) {
      return Theme.of(context).colorScheme.onSecondary;
    } else {
      return Theme.of(context).colorScheme.onSurface;
    }
  }
}