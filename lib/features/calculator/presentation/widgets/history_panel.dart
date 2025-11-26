import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/calculator_bloc.dart';

class HistoryPanel extends StatelessWidget {
  const HistoryPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculatorBloc, CalculatorState>(
      builder: (context, state) {
        if (state.history.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'No calculation history',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return Container(
          height: 200,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'History',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      context.read<CalculatorBloc>().add(ClearHistory());
                    },
                    child: const Text('Clear'),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.history.length,
                  itemBuilder: (context, index) {
                    final calculation = state.history[index];
                    return ListTile(
                      title: Text(calculation.expression),
                      subtitle: Text(
                        DateFormat('MMM dd, HH:mm').format(calculation.timestamp),
                      ),
                      trailing: Text(
                        calculation.result,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        context.read<CalculatorBloc>().add(
                          CalculatorButtonPressed(calculation.expression),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}