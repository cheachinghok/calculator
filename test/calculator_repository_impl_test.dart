import 'package:calculator/features/calculator/data/repositories/calculator_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CalculatorRepositoryImpl repository;

  setUp(() {
    repository = CalculatorRepositoryImpl();
  });

  group('CalculatorRepositoryImpl', () {
    test('should evaluate basic expressions correctly', () {
      expect(repository.evaluateExpression('2+2'), 4.0);
      expect(repository.evaluateExpression('10-5'), 5.0);
      expect(repository.evaluateExpression('3*4'), 12.0);
      expect(repository.evaluateExpression('15/3'), 5.0);
    });

    test('should handle complex expressions', () {
      expect(repository.evaluateExpression('2+3*4'), 14.0);
      expect(repository.evaluateExpression('(2+3)*4'), 20.0);
    });

    test('should throw exception for invalid expressions', () {
      expect(() => repository.evaluateExpression('2++2'), throwsException);
      expect(() => repository.evaluateExpression('abc'), throwsException);
    });
  });
}