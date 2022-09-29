import 'package:flutter/material.dart';

import 'package:moneybag/model/transaction_provider.dart';
import 'package:provider/provider.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  bool isExpense = false;
  final fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: fromKey,
      child: AlertDialog(
        title: const Text("Add Your Expanse"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              validator: (name) {
                return name != null && name.isEmpty ? 'Enter a name' : null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Name"),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              validator: (amount) =>
                  amount != null && double.tryParse(amount) == null
                      ? 'Enter a valid number'
                      : null,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Amount"),
            ),
            const SizedBox(height: 10),
            RadioListTile<bool>(
              activeColor: Colors.black,
              title: const Text('Income'),
              value: false,
              groupValue: isExpense,
              onChanged: (value) => setState(() => isExpense = value!),
            ),
            RadioListTile<bool>(
              activeColor: Colors.black,
              title: const Text('Expense'),
              value: true,
              groupValue: isExpense,
              onChanged: (value) => setState(() => isExpense = value!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    final isValid = fromKey.currentState!.validate();
                    if (isValid) {
                      context.read<TransactionProvider>().addTransaction(
                          nameController.text,
                          isExpense,
                          double.parse(amountController.text));
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Add"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
