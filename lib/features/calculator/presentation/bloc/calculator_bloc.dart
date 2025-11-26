
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/calculation_entity.dart';
import '../../domain/repositories/calculator_repository.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final CalculatorRepository calculatorRepository;

  CalculatorBloc({required this.calculatorRepository})
      : super(const CalculatorState()) {
    on<CalculatorButtonPressed>(_onCalculatorButtonPressed);
    on<ClearCalculator>(_onClearCalculator);
    on<DeleteLastCharacter>(_onDeleteLastCharacter);
    on<CalculateResult>(_onCalculateResult);
    on<LoadCalculatorHistory>(_onLoadCalculatorHistory);
    on<ClearHistory>(_onClearHistory);
  }

  void _onCalculatorButtonPressed(
    CalculatorButtonPressed event,
    Emitter<CalculatorState> emit,
  ) {
    final String newExpression = state.expression + event.buttonText;
    emit(state.copyWith(expression: newExpression));
  }

  void _onClearCalculator(
    ClearCalculator event,
    Emitter<CalculatorState> emit,
  ) {
    emit(const CalculatorState());
  }

  void _onDeleteLastCharacter(
    DeleteLastCharacter event,
    Emitter<CalculatorState> emit,
  ) {
    if (state.expression.isNotEmpty) {
      final String newExpression =
          state.expression.substring(0, state.expression.length - 1);
      emit(state.copyWith(expression: newExpression));
    }
  }

  void _onCalculateResult(
    CalculateResult event,
    Emitter<CalculatorState> emit,
  ) {
    try {
      if (state.expression.isEmpty) return;

      final result = calculatorRepository.evaluateExpression(state.expression);
      final calculation = CalculationEntity(
        expression: state.expression,
        result: _formatResult(result),
        timestamp: DateTime.now(),
      );

      calculatorRepository.saveCalculation(calculation);

      emit(state.copyWith(
        expression: _formatResult(result),
        result: _formatResult(result),
        history: [calculation, ...state.history],
      ));
    } catch (e) {
      emit(state.copyWith(error: 'Error: Invalid expression'));
    }
  }

  void _onLoadCalculatorHistory(
    LoadCalculatorHistory event,
    Emitter<CalculatorState> emit,
  ) {
    final history = calculatorRepository.getCalculationHistory();
    emit(state.copyWith(history: history));
  }

  void _onClearHistory(
    ClearHistory event,
    Emitter<CalculatorState> emit,
  ) {
    calculatorRepository.clearHistory();
    emit(state.copyWith(history: []));
  }

  String _formatResult(double result) {
    if (result == result.truncateToDouble()) {
      return result.truncate().toString();
    }
    return result.toStringAsFixed(6).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }
}