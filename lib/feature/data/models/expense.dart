class Expense {
  final double amount;
  final Category category;
  final String description;
  final DateTime dateTime;
  final String id;

  Expense({
    required this.amount,
    required this.category,
    required this.description,
    required this.dateTime,
  }) : id = 'timestamp-${DateTime.now().toIso8601String()}';
}

enum Category { food, groceries, travel, other }
