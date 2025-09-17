import 'package:expense_tracker/feature/data/models/expense.dart';
import 'package:flutter/material.dart';

class AddExpenseViewModel extends ChangeNotifier{
  final formKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  Category _selectedCategory = Category.food;
  Category get selectedCategory => _selectedCategory;
}