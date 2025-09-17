import 'package:expense_tracker/feature/data/models/expense.dart';
import 'package:expense_tracker/feature/ui/view/add_expense_dialog.dart';
import 'package:expense_tracker/feature/ui/view/expense_filter_dialog.dart';
import 'package:expense_tracker/feature/ui/view_models/expense_viewmodel.dart';
import 'package:expense_tracker/feature/utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.expenseTracker),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showFilterDialog(context),
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<ExpenseViewModel>(
          builder: (context, viewModel, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _CategoryTotals(
                    categoryTotals: viewModel.categoryTotals,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    Constants.expenses,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: viewModel.expenses.isNotEmpty
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
                                subtitle: Text(
                                  '${expense.category.name} - ${DateFormat.yMd().format(expense.dateTime)}',
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Rs. ${expense.amount.toStringAsFixed(2)}',
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          viewModel.deleteExpense(expense.id),
                                      icon: const Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: viewModel.expenses.length,
                        )
                      : const Center(child: Text(Constants.noExpenses)),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final shouldLoadExpenses = await _showAddExpenseDialog(context);
          if (context.mounted && (shouldLoadExpenses ?? false)) {
            Provider.of<ExpenseViewModel>(
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

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ExpenseFilterDialog(),
    );
  }
}

class _CategoryTotals extends StatelessWidget {
  final Map<Category, double> categoryTotals;

  const _CategoryTotals({required this.categoryTotals});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return categoryTotals.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Constants.categoryTotals,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: categoryTotals.entries
                      .map(
                        (entry) => Chip(
                          label: Text(
                            '${entry.key.name}: Rs. ${entry.value.toStringAsFixed(2)}',
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
