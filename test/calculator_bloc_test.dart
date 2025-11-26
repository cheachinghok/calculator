import 'package:bloc_test/bloc_test.dart';
import 'package:calculator/features/calculator/domain/repositories/calculator_repository.dart';
import 'package:calculator/features/calculator/presentation/bloc/calculator_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCalculatorRepository extends Mock implements CalculatorRepository {}

void main() {
  late MockCalculatorRepository mockRepository;
  late CalculatorBloc calculatorBloc;

  setUp(() {
    mockRepository = MockCalculatorRepository();
    calculatorBloc = CalculatorBloc(calculatorRepository: mockRepository);
  });

  tearDown(() {
    calculatorBloc.close();
  });

  group('CalculatorBloc', () {
    test('initial state is CalculatorState', () {
      expect(calculatorBloc.state, const CalculatorState());
    });

    blocTest<CalculatorBloc, CalculatorState>(
      'emits state with updated expression when button is pressed',
      build: () => calculatorBloc,
      act: (bloc) => bloc.add(const CalculatorButtonPressed('2')),
      expect: () => [
        const CalculatorState(expression: '2'),
      ],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'emits initial state when clear is pressed',
      build: () => calculatorBloc,
      seed: () => const CalculatorState(expression: '2+2'),
      act: (bloc) => bloc.add(ClearCalculator()),
      expect: () => [
        const CalculatorState(),
      ],
    );
  });
}