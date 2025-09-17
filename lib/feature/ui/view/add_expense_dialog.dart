import 'package:expense_tracker/feature/data/models/expense.dart';
import 'package:expense_tracker/feature/ui/view_models/add_expense_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseDialog extends StatelessWidget {
  const AddExpenseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddExpenseViewModel(),
      child: Consumer<AddExpenseViewModel>(
        builder: (context, viewModel, _) {
          return AlertDialog(
            title: Text('Add Expense'),
            content: Form(
              key: viewModel.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: viewModel.descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter a description'
                        : null,
                  ),
                  TextFormField(
                    controller: viewModel.amountController,
                    decoration: InputDecoration(labelText: 'Amount'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter an amount'
                        : null,
                  ),
                  DropdownButtonFormField<Category>(
                    initialValue: viewModel.selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(category.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        //TODO: set category in viewmodel
                      }
                    },
                    decoration: InputDecoration(labelText: 'Category'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
