import 'package:expense_tracker/feature/data/models/expense.dart';

abstract class ExpenseRepository {
  void addExpense(Expense expense);
  void deleteExpense(String id);
  List<Expense> getExpenses();
  Map<Category, double> getCategoryTotals();
  List<Expense> filterExpensesByDate({DateTime? from, DateTime? to});
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

  @override
  List<Expense> filterExpensesByDate({DateTime? from, DateTime? to}) {
    return _expenses.where((expense) {
      if (from != null && to != null) {
        return expense.dateTime.isAfter(from) && expense.dateTime.isBefore(to);
      } else if (from != null) {
        return expense.dateTime.isAfter(from);
      } else if (to != null) {
        return expense.dateTime.isBefore(to);
      } else {
        return true;
      }
    }).toList();
  }
}
