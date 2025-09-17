import 'package:expense_tracker/feature/data/models/expense.dart';

abstract class ExpenseRepository {
  void addExpense(Expense expense);
  void deleteExpense(String id);
  List<Expense> getExpenses();
  Map<Category, double> getCategoryTotals();
}

class ExpenseRepositoryImpl implements ExpenseRepository {
  final List<Expense> _expenses = [];

  @override
  void addExpense(Expense expense) {
    _expenses.add(expense);
  }

  @override
  void deleteExpense(String id) {
    _expenses.removeWhere((expense) => expense.id == id);
  }

  @override
  List<Expense> getExpenses() {
    return _expenses;
  }

  @override
  Map<Category, double> getCategoryTotals() {
    final Map<Category, double> categoryTotals = {};
    for (final expense in _expenses) {
      categoryTotals.update(
        expense.category,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    return categoryTotals;
  }
}
