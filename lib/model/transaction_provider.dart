import 'package:flutter/material.dart';
import 'package:moneybag/model/boxex.dart';
import 'package:moneybag/model/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  final box = Boxes.getTransaction();
  List<Transaction> _data = [];
  List<Transaction> get data => _data;

  List<Transaction> getTransaction() {
    final value = box.values.toList();

    return _data = value;
  }

  void addTransaction(Transaction transaction) {
    box.add(transaction);
    _data = box.values.toList().cast<Transaction>();
    getTransaction();
    notifyListeners();
  }

  void deleteTransaction(int index) async {
    //  final box = Boxes.getTransaction();
    await box.deleteAt(index);
    getTransaction();

    notifyListeners();
  }

  Future<void> deleteAll() async {
    // final box = Boxes.getTransaction();
    await box.clear();
    getTransaction();
    notifyListeners();
  }

  finalAmount() {
    return _data.fold<double>(
        0,
        (previousValue, transaction) => transaction.isExpense
            ? previousValue - transaction.amount
            : previousValue + transaction.amount);
  }
}
