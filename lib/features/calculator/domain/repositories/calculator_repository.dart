import '../entities/calculation_entity.dart';

abstract class CalculatorRepository {
  double evaluateExpression(String expression);
  List<CalculationEntity> getCalculationHistory();
  void saveCalculation(CalculationEntity calculation);
  void clearHistory();
}