import 'package:calculator/features/calculator/domain/entities/calculation_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalculationEntity', () {
    test('should be equal when properties are same', () {
      final calculation1 = CalculationEntity(
        expression: '2+2',
        result: '4',
        timestamp: DateTime(2023, 1, 1),
      );

      final calculation2 = CalculationEntity(
        expression: '2+2',
        result: '4',
        timestamp: DateTime(2023, 1, 1),
      );

      expect(calculation1, calculation2);
    });

    test('should have correct props', () {
      final calculation = CalculationEntity(
        expression: '3*4',
        result: '12',
        timestamp: DateTime(2023, 1, 1),
      );

      expect(calculation.props, ['3*4', '12', DateTime(2023, 1, 1)]);
    });
  });
}