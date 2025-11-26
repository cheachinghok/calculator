import 'dart:math';
import 'package:math_expressions/math_expressions.dart';
import '../../domain/entities/calculation_entity.dart';
import '../../domain/repositories/calculator_repository.dart';

class CalculatorRepositoryImpl implements CalculatorRepository {
  final List<CalculationEntity> _calculationHistory = [];

  @override
  double evaluateExpression(String expression) {
    try {
      if (expression.isEmpty) {
        throw const FormatException('Expression cannot be empty');
      }

      // Basic validation - check for common invalid patterns
      if (_hasInvalidPatterns(expression)) {
        throw const FormatException('Invalid expression pattern');
      }

      // Clean and validate the expression
      final cleanExpression = _cleanExpression(expression);
      
      // Parse and evaluate
      // ignore: deprecated_member_use
      final Parser p = Parser();
      final Expression exp = p.parse(cleanExpression);
      final ContextModel cm = ContextModel()
        ..bindVariableName('pi', Number(pi))
        ..bindVariableName('e', Number(e));

      final double result = exp.evaluate(EvaluationType.REAL, cm);

      // Check for invalid results
      if (result.isNaN || result.isInfinite) {
        throw const FormatException('Calculation resulted in invalid value');
      }

      return result;
    } on FormatException catch (e) {
      throw Exception('Invalid expression: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  bool _hasInvalidPatterns(String expression) {
    // Check for consecutive operators
    if (RegExp(r'[+\-*/×÷]{2,}').hasMatch(expression)) {
      return true;
    }
    
    // Check for operators at the end (except when it's a valid ending)
    if (RegExp(r'[+\-*/×÷.]$').hasMatch(expression)) {
      return true;
    }
    
    // Check for invalid character sequences
    if (RegExp(r'[a-df-zA-DF-Z]').hasMatch(expression.replaceAll('sin', '').replaceAll('cos', '').replaceAll('tan', '').replaceAll('log', '').replaceAll('sqrt', '').replaceAll('pi', '').replaceAll('e', ''))) {
      return true;
    }
    
    return false;
  }

  String _cleanExpression(String expression) {
    String clean = expression
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('π', 'pi')
        .replaceAll('e', 'e')
        .replaceAll('√', 'sqrt')
        .replaceAll('²', '^2')
        .replaceAll('³', '^3');

    // Handle trigonometric functions and ensure proper formatting
    clean = clean.replaceAllMapped(RegExp(r'sin|cos|tan|log'), (match) {
      return '${match.group(0)}(';
    });

    // Ensure parentheses are balanced
    if (!_hasBalancedParentheses(clean)) {
      throw const FormatException('Unbalanced parentheses');
    }

    return clean;
  }

  bool _hasBalancedParentheses(String expression) {
    int balance = 0;
    for (int i = 0; i < expression.length; i++) {
      if (expression[i] == '(') balance++;
      if (expression[i] == ')') balance--;
      if (balance < 0) return false; // More closing than opening
    }
    return balance == 0; // Should be balanced
  }

  @override
  List<CalculationEntity> getCalculationHistory() {
    return List.from(_calculationHistory);
  }

  @override
  void saveCalculation(CalculationEntity calculation) {
    _calculationHistory.insert(0, calculation);
    // Keep only last 50 calculations
    if (_calculationHistory.length > 50) {
      _calculationHistory.removeLast();
    }
  }

  @override
  void clearHistory() {
    _calculationHistory.clear();
  }
}