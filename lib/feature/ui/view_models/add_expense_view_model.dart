import 'package:expense_tracker/feature/data/expense_repository.dart';
import 'package:expense_tracker/feature/data/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpenseViewModel extends ChangeNotifier {
  AddExpenseViewModel({required ExpenseRepository expenseRepository})
    : _repository = expenseRepository;

  final ExpenseRepository _repository;

  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  Category _selectedCategory = Category.food;
  Category get selectedCategory => _selectedCategory;

  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  String get formattedSelectedDate => DateFormat.yMd().format(selectedDate);

  void setCategory(Category category) {
    _selectedCategory = category;
  }

  void setDate(DateTime date) {
    _selectedDate = date;
  }

  void addExpense() {
    final expense = Expense(
      amount: double.parse(amountController.text),
      category: selectedCategory,
      description: descriptionController.text,
      dateTime: selectedDate,
    );
    _repository.addExpense(expense);
  }

  void reset() {
    descriptionController.clear();
    amountController.clear();
    _selectedCategory = Category.food;
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    amountController.dispose();
    super.dispose();
  }
}
