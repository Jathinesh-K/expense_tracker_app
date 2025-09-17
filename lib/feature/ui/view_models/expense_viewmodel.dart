import 'package:expense_tracker/feature/data/expense_repository.dart';
import 'package:expense_tracker/feature/data/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpenseRepository _repository;

  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;

  Map<Category, double> _categoryTotals = {};
  Map<Category, double> get categoryTotals => _categoryTotals;

  ExpenseViewModel({required ExpenseRepository expenseRepository})
    : _repository = expenseRepository {
    loadExpenses();
  }

  void loadExpenses() {
    _expenses = _repository.getExpenses();
    _categoryTotals = _repository.getCategoryTotals();
    notifyListeners();
  }

  void addExpense(Expense expense) {
    _repository.addExpense(expense);
    loadExpenses();
  }

  void deleteExpense(String id) {
    _repository.deleteExpense(id);
    loadExpenses();
  }
}
