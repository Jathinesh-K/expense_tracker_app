import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ExpenseScreen has a title and a floating action button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());

    expect(find.text('Expense Tracker'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Tapping floating action button opens add expense dialog',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    expect(find.text('Add Expense'), findsOneWidget);
  });

  testWidgets('Tapping filter button opens filter dialog',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());

    await tester.tap(find.byIcon(Icons.filter_list));
    await tester.pump();

    expect(find.text('Filter Expenses'), findsOneWidget);
  });
}
