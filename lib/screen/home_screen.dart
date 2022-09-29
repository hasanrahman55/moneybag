import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  @override
  Widget build(BuildContext context) {
    final data = context.watch<TransactionProvider>().data;
    final transaction = context.watch<TransactionProvider>();
    return Scaffold(
      // appBar: AppBar(
      //   title: const Center(child: Text("MoneyBag")),
      // ),
      body: data.isEmpty
          ? const Center(
              child: Text(
                'No expenses yet!',
                style: TextStyle(fontSize: 24),
              ),
            )
          : SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(18.0),
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(26),
                    decoration: const BoxDecoration(
                      // color: const Color(0xffE94C89).withOpacity(0.5),
                      color: Colors.black,
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
                          "${transaction.finalAmount().toString()} Tk",
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

                  const Text(
                    ' Expanses',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 18),
                  const Divider(thickness: 2),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final expanse = data[index];

                      final color =
                          expanse.isExpense ? Colors.red : Colors.green;
                      return Card(
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 8),
                          title: Text(
                            expanse.name,
                            maxLines: 2,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          subtitle: Text(
                            DateFormat.yMMMd().format(expanse.createdAt),
                          ),
                          trailing: expanse.isExpense
                              ? Text(
                                  "- ${expanse.amount.toString()}  Tk",
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                )
                              : Text(
                                  "+ ${expanse.amount.toString()}  Tk",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton.icon(
                                    label: const Text('Edit'),
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {},
                                  ),
                                ),
                                Expanded(
                                  child: TextButton.icon(
                                    label: const Text('Delete'),
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      transaction.removeTransaction(expanse);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
