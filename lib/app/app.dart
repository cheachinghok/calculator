import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/themes/app_theme.dart';
import '../features/calculator/data/repositories/calculator_repository_impl.dart';
import '../features/calculator/domain/repositories/calculator_repository.dart';
import '../features/calculator/presentation/bloc/calculator_bloc.dart';
import '../features/calculator/presentation/page/calculator_page.dart';

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<CalculatorRepository>(
      create: (context) => CalculatorRepositoryImpl(),
      child: BlocProvider<CalculatorBloc>(
        create: (context) => CalculatorBloc(
          calculatorRepository: RepositoryProvider.of<CalculatorRepository>(context),
        )..add(LoadCalculatorHistory()),
        child: MaterialApp(
          title: 'Calculator App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: const CalculatorPage(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}