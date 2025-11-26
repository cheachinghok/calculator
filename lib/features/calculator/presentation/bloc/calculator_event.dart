part of 'calculator_bloc.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

class CalculatorButtonPressed extends CalculatorEvent {
  final String buttonText;

  const CalculatorButtonPressed(this.buttonText);

  @override
  List<Object> get props => [buttonText];
}

class ClearCalculator extends CalculatorEvent {}

class DeleteLastCharacter extends CalculatorEvent {}

class CalculateResult extends CalculatorEvent {}

class LoadCalculatorHistory extends CalculatorEvent {}

class ClearHistory extends CalculatorEvent {}