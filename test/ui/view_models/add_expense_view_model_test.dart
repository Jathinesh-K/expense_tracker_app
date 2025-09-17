import 'package:expense_tracker/feature/data/expense_repository.dart';
import 'package:expense_tracker/feature/data/models/expense.dart';
import 'package:expense_tracker/feature/ui/view_models/add_expense_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AddExpenseViewModel viewModel;

  setUp(() {
    viewModel = AddExpenseViewModel(expenseRepository: ExpenseRepositoryImpl());
  });

  test('setDate should update the selected date', () {
    final newDate = DateTime.now().subtract(const Duration(days: 1));
    viewModel.setDate(newDate);
    expect(viewModel.selectedDate, newDate);
  });

  test('setCategory should update the selected category', () {
    final newCategory = Category.food;
    viewModel.setCategory(newCategory);
    expect(viewModel.selectedCategory, newCategory);
  });

  test('reset should clear all fields', () {
    viewModel.descriptionController.text = 'Test';
    viewModel.amountController.text = '100';
    viewModel.setDate(DateTime.now().subtract(const Duration(days: 1)));
    viewModel.setCategory(Category.groceries);

    viewModel.reset();

    expect(viewModel.descriptionController.text, '');
    expect(viewModel.amountController.text, '');
    expect(viewModel.selectedDate.day, DateTime.now().day);
    expect(viewModel.selectedCategory, Category.food);
  });
}
