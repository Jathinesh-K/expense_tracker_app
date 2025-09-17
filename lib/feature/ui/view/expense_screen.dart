import 'package:expense_tracker/feature/ui/view_models/expense_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expense Tracker')),
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
                : Center(child: Text('No Expenses'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddExpenseDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    //TODO: Implement dialog to add transaction.
    showDialog(context: context, builder: (context) => Container());
  }
}
