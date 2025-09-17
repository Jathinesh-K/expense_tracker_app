import 'package:expense_tracker/feature/data/models/expense.dart';
import 'package:expense_tracker/feature/ui/view_models/add_expense_view_model.dart';
import 'package:expense_tracker/feature/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseDialog extends StatelessWidget {
  const AddExpenseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddExpenseViewModel>(
      builder: (context, viewModel, _) {
        return AlertDialog(
          title: const Text(Constants.addExpense),
          content: Form(
            key: viewModel.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: viewModel.descriptionController,
                  decoration: const InputDecoration(
                    labelText: Constants.description,
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? Constants.descriptionValidation
                      : null,
                ),
                TextFormField(
                  controller: viewModel.amountController,
                  decoration: const InputDecoration(
                    labelText: Constants.amount,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? Constants.amountValidation
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
                      viewModel.setCategory(value);
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: Constants.category,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${Constants.date}: ${viewModel.formattedSelectedDate}',
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                        );
                        if (date != null) {
                          viewModel.setDate(date);
                        }
                      },
                      child: const Text(Constants.selectDate),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                viewModel.reset();
                Navigator.of(context).pop();
              },
              child: const Text(Constants.cancel),
            ),
            TextButton(
              onPressed: () {
                if (viewModel.formKey.currentState!.validate()) {
                  viewModel.addExpense();
                  viewModel.reset();
                  Navigator.of(context).pop(true);
                }
              },
              child: const Text(Constants.add),
            ),
          ],
        );
      },
    );
  }
}
