import 'package:flutter/material.dart';
import 'package:moneybag/model/boxex.dart';
import 'package:moneybag/model/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  List<Transaction> _data = [];
  List<Transaction> get data => _data;

  List<Transaction> getTransaction() {
    final box = Boxes.getTransaction();

    return _data = box.values.toList().cast<Transaction>();
    notifyListeners();
  }

  void addTransaction(Transaction transaction) {
    final box = Boxes.getTransaction();
    box.add(transaction);
    _data = box.values.toList().cast<Transaction>();
    getTransaction();
    notifyListeners();
  }

  void add(String name, double amount, bool isExpense) {
    final box = Boxes.getTransaction();
    box.add(Transaction(
        name: name,
        createdAt: DateTime.now(),
        isExpense: isExpense,
        amount: amount));
    _data = box.values.toList().cast<Transaction>();
    getTransaction();
    notifyListeners();
  }

  void deleteTransaction(int index) async {
    final box = Boxes.getTransaction();
    await box.deleteAt(index);
    getTransaction();

    notifyListeners();
  }

  Future<void> deleteAll() async {
    final box = Boxes.getTransaction();
    await box.clear();
    getTransaction();
  }

  finalAmount() {
    return _data.fold<double>(
        0,
        (previousValue, transaction) => transaction.isExpense
            ? previousValue - transaction.amount
            : previousValue + transaction.amount);
  }
}
