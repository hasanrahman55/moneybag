import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late DateTime createdAt;
  @HiveField(2)
  late bool isExpense;
  @HiveField(3)
  late double amount;
  Transaction({
    required this.name,
    required this.createdAt,
    required this.isExpense,
    required this.amount,
  });
}
