import 'package:expense_tracker/feature/ui/view_models/expense_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class ExpenseFilterDialog extends StatefulWidget {
  const ExpenseFilterDialog({super.key});

  @override
  State<ExpenseFilterDialog> createState() => _ExpenseFilterDialogState();
}

class _ExpenseFilterDialogState extends State<ExpenseFilterDialog> {
  late DateTime? _startDate;
  late DateTime? _endDate;
  late ExpenseViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<ExpenseViewModel>(context, listen: false);
    _startDate = _viewModel.startDate;
    _endDate = _viewModel.endDate;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(Constants.filterExpenses),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _startDate == null
                      ? '${Constants.from} ${Constants.date}'
                      : '${Constants.from}: ${DateFormat.yMd().format(_startDate!)}',
                ),
              ),
              TextButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _startDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      _startDate = date;
                    });
                  }
                },
                child: const Text(Constants.select),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  _endDate == null
                      ? '${Constants.to} ${Constants.date}'
                      : '${Constants.to}: ${DateFormat.yMd().format(_endDate!)}',
                ),
              ),
              TextButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _endDate ?? DateTime.now(),
                    firstDate: _startDate ?? DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    setState(() {
                      _endDate = date;
                    });
                  }
                },
                child: const Text(Constants.select),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            _viewModel.loadExpenses();
            Navigator.of(context).pop();
          },
          child: const Text(Constants.clear),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(Constants.cancel),
        ),
        TextButton(
          onPressed: () {
            _viewModel.filterExpensesByDate(_startDate, _endDate);
            Navigator.of(context).pop();
          },
          child: const Text(Constants.apply),
        ),
      ],
    );
  }
}
