import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moneybag/model/boxex.dart';
import 'package:moneybag/model/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  List<Transaction> _data = [];
  List<Transaction> get data => _data;

  List<Transaction> getTransaction() {
    final box = Boxes.getTransaction();

    return _data = box.values.toList().cast<Transaction>();
  }

  void addTransaction(String title, bool isExpense, double amount) {
    final transaction = Transaction(
        name: title,
        createdAt: DateTime.now(),
        isExpense: isExpense,
        amount: amount);

    final box = Boxes.getTransaction();
    box.add(transaction);
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

  void editTransaction(String title, bool isExpense, double amount) {
    final transaction = Transaction(
        name: title,
        createdAt: DateTime.now(),
        isExpense: isExpense,
        amount: amount);

    final box = Boxes.getTransaction();
    //box.put( transaction)
    box.add(transaction);
    _data = box.values.toList().cast<Transaction>();
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
