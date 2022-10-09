import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:moneybag/model/transaction.dart';
import 'package:moneybag/model/transaction_provider.dart';

import 'package:moneybag/screen/custom_dialog.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Hive.box<Transaction>("transaction");
    Future.delayed(Duration(milliseconds: 10)).then((value) {
      Provider.of<TransactionProvider>(context, listen: false).getTransaction();
      //   Provider.of<TransactionProvider>(context, listen: false).deleteAll();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TransactionProvider>(
        builder: (context, value, child) {
          return value.data.isEmpty
              ? const Center(
                  child: Text(
                    'No expenses yet!',
                    style: TextStyle(fontSize: 24),
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(18.0),
                  children: [
                    const SizedBox(height: 60),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(26),
                      decoration: const BoxDecoration(
                        // color: const Color(0xffE94C89).withOpacity(0.5),
                        image: DecorationImage(
                          image: AssetImage("images/cover.png"),
                          fit: BoxFit.cover,
                        ),
                        //   color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            "Money Bag",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "${value.finalAmount().toString()} Tk",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 38,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    //     const Divider(thickness: 2, color: Colors.black),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          ' Expanses',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            value.deleteAll();
                          },
                          child: const Text(
                            ' All Clear',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const Divider(thickness: 2),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.data.length,
                      itemBuilder: (context, index) {
                        final transactions = value.getTransaction()[index];

                        return Card(
                          child: ExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 8),
                            title: Text(
                              transactions.name,
                              maxLines: 2,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: Text(
                              DateFormat.yMMMd().format(transactions.createdAt),
                            ),
                            trailing: transactions.isExpense
                                ? Text(
                                    "- ${transactions.amount.toString()}  Tk",
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  )
                                : Text(
                                    "+ ${transactions.amount.toString()}  Tk",
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                            children: [
                              TextButton.icon(
                                label: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  value.deleteTransaction(index);
                                  print("ha");
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 70),
                  ],
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(isEditing: false),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
