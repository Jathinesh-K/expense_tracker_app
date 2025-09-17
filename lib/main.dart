import 'package:expense_tracker/feature/config/dependencies.dart';
import 'package:expense_tracker/feature/ui/view/expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(providers: providers, child: ExpenseScreen()),
    );
  }
}
