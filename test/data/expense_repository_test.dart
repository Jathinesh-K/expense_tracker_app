import 'package:expense_tracker/feature/data/expense_repository.dart';
import 'package:expense_tracker/feature/data/models/expense.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ExpenseRepository repository;

  setUp(() {
    repository = ExpenseRepositoryImpl();
  });

  test('addExpense should add an expense to the list', () {
    final expense = Expense(
      amount: 50.0,
      category: Category.food,
      dateTime: DateTime.now(),
      description: 'Lunch',
    );

    repository.addExpense(expense);

    expect(repository.getExpenses().length, 1);
    expect(repository.getExpenses().first, expense);
  });

  test('deleteExpense should remove an expense from the list', () {
    final expense = Expense(
      amount: 50.0,
      category: Category.food,
      dateTime: DateTime.now(),
      description: 'Lunch',
    );
    repository.addExpense(expense);

    repository.deleteExpense(expense.id);

    expect(repository.getExpenses().length, 0);
  });

  test('getCategoryTotals should return correct totals', () {
    repository.addExpense(Expense(
      amount: 50.0,
      category: Category.food,
      dateTime: DateTime.now(),
      description: 'Lunch',
    ));
    repository.addExpense(Expense(
      amount: 25.0,
      category: Category.groceries,
      dateTime: DateTime.now(),
      description: 'Vegetables',
    ));
    repository.addExpense(Expense(
      amount: 30.0,
      category: Category.food,
      dateTime: DateTime.now(),
      description: 'Groceries',
    ));

    final totals = repository.getCategoryTotals();

    expect(totals[Category.food], 80.0);
    expect(totals[Category.groceries], 25.0);
  });

  test('filterExpensesByDate should return correct expenses', () {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final tomorrow = now.add(const Duration(days: 1));

    repository.addExpense(Expense(
      amount: 50.0,
      category: Category.food,
      dateTime: now,
      description: 'Lunch',
    ));
    repository.addExpense(Expense(
      amount: 25.0,
      category: Category.groceries,
      dateTime: yesterday,
      description: 'Vegetables',
    ));
    repository.addExpense(Expense(
      amount: 30.0,
      category: Category.food,
      dateTime: tomorrow,
      description: 'Groceries',
    ));

    var filtered = repository.filterExpensesByDate(from: now);
    expect(filtered.length, 1);

    filtered = repository.filterExpensesByDate(to: now);
    expect(filtered.length, 1);

    filtered = repository.filterExpensesByDate(
        from: yesterday, to: tomorrow.add(const Duration(seconds: 1)));
    expect(filtered.length, 2);
  });
}
