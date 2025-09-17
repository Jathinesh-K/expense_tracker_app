import 'package:expense_tracker/feature/data/expense_repository.dart';
import 'package:expense_tracker/feature/data/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseViewmodel extends ChangeNotifier {
  final ExpenseRepository _repository;

  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;

  ExpenseViewmodel({required ExpenseRepository expenseRepository})
    : _repository = expenseRepository {
    _loadExpenses();
  }

  void _loadExpenses() {
    _expenses = _repository.getExpenses();
    notifyListeners();
  }

  void addExpense(Expense expense) {
    _repository.addExpense(expense);
    _loadExpenses();
  }

  void deleteExpense(String id) {
    _repository.deleteExpense(id);
    _loadExpenses();
  }
}
