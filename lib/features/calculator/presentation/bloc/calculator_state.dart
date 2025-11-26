part of 'calculator_bloc.dart';

class CalculatorState extends Equatable {
  final String expression;
  final String result;
  final String error;
  final List<CalculationEntity> history;

  const CalculatorState({
    this.expression = '',
    this.result = '',
    this.error = '',
    this.history = const [],
  });

  CalculatorState copyWith({
    String? expression,
    String? result,
    String? error,
    List<CalculationEntity>? history,
  }) {
    return CalculatorState(
      expression: expression ?? this.expression,
      result: result ?? this.result,
      error: error ?? this.error,
      history: history ?? this.history,
    );
  }

  @override
  List<Object> get props => [expression, result, error, history];
}