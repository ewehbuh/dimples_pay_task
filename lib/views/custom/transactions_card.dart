import 'package:dimples_task/models/transactions_card_model.dart';
import 'package:flutter/material.dart';


class TransactionListView extends StatelessWidget {
  final List<TransactionModel> transactions;

  const TransactionListView({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            margin: const EdgeInsets.all(8),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 180,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID: ${transaction.transactionId}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Date: ${transaction.date}'),
                  Text('Amount: ${transaction.amount.toStringAsFixed(2)}'),
                  Text('Description: ${transaction.description}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
