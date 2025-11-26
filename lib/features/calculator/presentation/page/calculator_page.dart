import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/calculator_bloc.dart';
import '../widgets/calculator_button.dart';
import '../widgets/calculator_display.dart';
import '../widgets/history_panel.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final List<List<String>> basicButtons = [
    ['C', '⌫', '%', '÷'],
    ['7', '8', '9', '×'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '+'],
    ['00', '0', '.', '='],
  ];

  final List<List<String>> advancedButtons = [
    ['π', 'e', '√', '^'],
    ['sin', 'cos', 'tan', 'log'],
    ['(', ')', '!', '²'],
  ];

  bool _showAdvanced = false;
  bool _showHistory = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        actions: [
          IconButton(
            icon: Icon(_showAdvanced ? Icons.calculate : Icons.functions),
            onPressed: () {
              setState(() {
                _showAdvanced = !_showAdvanced;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              setState(() {
                _showHistory = !_showHistory;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Display
          const CalculatorDisplay(),
          
          // History Panel
          if (_showHistory) const HistoryPanel(),
          
          // Advanced Buttons
          if (_showAdvanced) _buildAdvancedButtons(),
          
          // Basic Buttons
          Expanded(child: _buildBasicButtons()),
        ],
      ),
    );
  }

  Widget _buildAdvancedButtons() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.5,
      ),
      itemCount: advancedButtons.length * 4,
      itemBuilder: (context, index) {
        final row = index ~/ 4;
        final col = index % 4;
        final buttonText = advancedButtons[row][col];
        
        return CalculatorButton(
          text: buttonText,
          onPressed: () => _handleButtonPress(buttonText),
          isOperator: ['π', 'e', '√', '^', 'sin', 'cos', 'tan', 'log', '(', ')', '!', '²'].contains(buttonText),
        );
      },
    );
  }

  Widget _buildBasicButtons() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.2,
      ),
      itemCount: basicButtons.length * 4,
      itemBuilder: (context, index) {
        final row = index ~/ 4;
        final col = index % 4;
        final buttonText = basicButtons[row][col];
        
        return CalculatorButton(
          text: buttonText,
          onPressed: () => _handleButtonPress(buttonText),
          isOperator: ['÷', '×', '-', '+', '='].contains(buttonText),
          isSpecial: ['C', '⌫', '%', '='].contains(buttonText),
        );
      },
    );
  }

  void _handleButtonPress(String buttonText) {
    final calculatorBloc = context.read<CalculatorBloc>();

    switch (buttonText) {
      case 'C':
        calculatorBloc.add(ClearCalculator());
        break;
      case '⌫':
        calculatorBloc.add(DeleteLastCharacter());
        break;
      case '=':
        calculatorBloc.add(CalculateResult());
        break;
      default:
        calculatorBloc.add(CalculatorButtonPressed(buttonText));
        break;
    }
  }
}