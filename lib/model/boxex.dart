import 'package:hive/hive.dart';
import 'package:moneybag/model/transaction.dart';

class Boxes {
  static Box<Transaction> getTransaction() =>
      Hive.box<Transaction>("transaction");
}
