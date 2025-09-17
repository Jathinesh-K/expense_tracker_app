import 'package:expense_tracker/feature/data/expense_repository.dart';
import 'package:expense_tracker/feature/data/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpenseRepository _repository;

  List<Expense> _expenses = [];
  List<Expense> get expenses => _expenses;

  Map<Category, double> _categoryTotals = {};
  Map<Category, double> get categoryTotals => _categoryTotals;

  DateTime? _startDate;
  DateTime? _endDate;

  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;

  String getFormattedDate(DateTime dateTime) => DateFormat.yMd().format(dateTime);

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

  void filterExpensesByDate(DateTime? from, DateTime? to){
    _startDate = from;
    _endDate = to;
    _expenses = _repository.filterExpensesByDate(from: from, to: to);
    notifyListeners();
  }
}
