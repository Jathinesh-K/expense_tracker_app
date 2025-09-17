import 'package:expense_tracker/feature/data/expense_repository.dart';
import 'package:expense_tracker/feature/data/models/expense.dart';
import 'package:expense_tracker/feature/ui/view_models/expense_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ExpenseViewModel viewModel;

  setUp(() {
    viewModel = ExpenseViewModel(expenseRepository: ExpenseRepositoryImpl());
  });

  test('Initial values are correct', () {
    expect(viewModel.expenses, []);
    expect(viewModel.categoryTotals, {});
    expect(viewModel.startDate, null);
    expect(viewModel.endDate, null);
  });

  test('addExpense should add an expense', () {
    final expense = Expense(
      amount: 50.0,
      category: Category.food,
      dateTime: DateTime.now(),
      description: 'Lunch',
    );
    viewModel.addExpense(expense);
    expect(viewModel.expenses.length, 1);
    expect(viewModel.expenses.first, expense);
  });

  test('deleteExpense should remove an expense', () {
    final expense = Expense(
      amount: 50.0,
      category: Category.food,
      dateTime: DateTime.now(),
      description: 'Lunch',
    );
    viewModel.addExpense(expense);
    viewModel.deleteExpense(expense.id);
    expect(viewModel.expenses.length, 0);
  });

  test('filterExpensesByDate should filter expenses', () {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final tomorrow = now.add(const Duration(days: 1));

    viewModel.addExpense(Expense(
      amount: 50.0,
      category: Category.food,
      dateTime: now,
      description: 'Lunch',
    ));
    viewModel.addExpense(Expense(
      amount: 25.0,
      category: Category.groceries,
      dateTime: yesterday,
      description: 'Vegetables',
    ));
    viewModel.addExpense(Expense(
      amount: 30.0,
      category: Category.food,
      dateTime: tomorrow,
      description: 'Groceries',
    ));

    viewModel.filterExpensesByDate(now, null);
    expect(viewModel.expenses.length, 1);
    expect(viewModel.startDate, now);
    expect(viewModel.endDate, null);
  });
}
