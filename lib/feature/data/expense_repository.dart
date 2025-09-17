import 'package:expense_tracker/feature/data/models/expense.dart';

abstract class ExpenseRepository {
  void addExpense(Expense expense);
  void deleteExpense(String id);
  List<Expense> getExpenses();
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
}
