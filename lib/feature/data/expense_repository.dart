import 'package:expense_tracker/feature/data/models/expense.dart';

abstract class ExpenseRepository {
  void addExpense(Expense expense);
  void deleteExpense(String id);
  List<Expense> getExpenses();
}

class ExpenseRepositoryImpl implements ExpenseRepository {
  final List<Expense> _expenses = [
    Expense(
      amount: 100.0,
      category: Category.food,
      description: 'Food1',
      dateTime: DateTime.now(),
    ),
    Expense(
      amount: 100.0,
      category: Category.food,
      description: 'Food2',
      dateTime: DateTime.now(),
    ),
    Expense(
      amount: 100.0,
      category: Category.food,
      description: 'Food3',
      dateTime: DateTime.now(),
    ),
    Expense(
      amount: 100.0,
      category: Category.food,
      description: 'Food4',
      dateTime: DateTime.now(),
    ),
  ];

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
