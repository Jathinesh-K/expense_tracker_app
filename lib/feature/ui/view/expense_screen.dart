import 'package:expense_tracker/feature/ui/view/add_expense_dialog.dart';
import 'package:expense_tracker/feature/ui/view_models/expense_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Tracker')),
      body: SafeArea(
        child: Consumer<ExpenseViewmodel>(
          builder: (context, viewModel, _) {
            return viewModel.expenses.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (_, index) {
                      final expense = viewModel.expenses[index];
                      return Dismissible(
                        key: ValueKey(expense.id),
                        onDismissed: (_) {
                          viewModel.deleteExpense(expense.id);
                        },
                        background: Container(color: Colors.red),
                        child: ListTile(
                          title: Text(expense.description),
                          subtitle: Text(expense.amount.toString()),
                        ),
                      );
                    },
                    itemCount: viewModel.expenses.length,
                  )
                : const Center(child: Text('No Expenses'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final shouldLoadExpenses = await _showAddExpenseDialog(context);
          if (context.mounted && (shouldLoadExpenses ?? false)) {
            Provider.of<ExpenseViewmodel>(
              context,
              listen: false,
            ).loadExpenses();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<bool?> _showAddExpenseDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => const AddExpenseDialog(),
    );
  }
}
