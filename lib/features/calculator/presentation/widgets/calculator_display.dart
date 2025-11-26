import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/calculator_bloc.dart';

class CalculatorDisplay extends StatelessWidget {
  const CalculatorDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (context, state) {
        return Container(
          key: const Key('calculator_display'),
          padding: const EdgeInsets.all(20),
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Expression Display
              SingleChildScrollView(
                key: const Key('expression_scroll'),
                scrollDirection: Axis.horizontal,
                child: Text(
                  state.expression.isEmpty ? '0' : state.expression,
                  key: const Key('expression_text'), // Add key
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Result Display
              SingleChildScrollView(
                key: const Key('result_scroll'),
                scrollDirection: Axis.horizontal,
                child: Text(
                  state.result.isEmpty ? '0' : state.result,
                  key: const Key('result_text'), // Add key
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              // Error Display
              if (state.error.isNotEmpty)
                Text(
                  state.error,
                  key: const Key('error_text'),
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}