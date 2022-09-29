import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moneybag/model/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  Transaction? transaction;

  List<Transaction> _data = [];
  List<Transaction> get data => _data;
  void addTransaction(String title, bool isExpense, double amount) {
    _data.add(
      Transaction(
          name: title,
          createdAt: DateTime.now(),
          isExpense: isExpense,
          amount: amount),
    );
    notifyListeners();
  }

  void removeTransaction(Transaction transaction) {
    _data.remove(transaction);
    notifyListeners();
  }

  void editTransaction(Transaction transaction) {
    notifyListeners();
  }

  void deleteTransaction() {}
  totalIn() {
    double income = 0.0;
    double expanse = 0.0;
    return _data.fold<double>(
        0,
        (previousValue, transaction) => transaction.isExpense
            ? expanse + transaction.amount
            : income + transaction.amount);
  }

  finalAmount() {
    return _data.fold<double>(
        0,
        (previousValue, transaction) => transaction.isExpense
            ? previousValue - transaction.amount
            : previousValue + transaction.amount);
  }
}
