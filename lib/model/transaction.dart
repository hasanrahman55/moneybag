class Transaction {
  late String name;
  late DateTime createdAt;
  late bool isExpense;
  late double amount;
  Transaction({
    required this.name,
    required this.createdAt,
    required this.isExpense,
    required this.amount,
  });
}
