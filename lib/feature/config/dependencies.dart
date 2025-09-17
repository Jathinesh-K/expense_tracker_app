import 'package:expense_tracker/feature/data/expense_repository.dart';
import 'package:expense_tracker/feature/ui/view_models/add_expense_view_model.dart';
import 'package:expense_tracker/feature/ui/view_models/expense_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providers => [
  Provider(create: (context) => ExpenseRepositoryImpl() as ExpenseRepository),
  ChangeNotifierProvider(
    create: (context) => ExpenseViewModel(expenseRepository: context.read()),
  ),
  ChangeNotifierProvider(
    create: (context) => AddExpenseViewModel(expenseRepository: context.read()),
  ),
];
