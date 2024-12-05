import 'package:dimples_task/providers/nfc_card_provider.dart';
import 'package:dimples_task/views/nfc_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class TransactionsWidget extends StatelessWidget {
  const TransactionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NfcCardProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.transactions.isEmpty) {
          return const Text(
            'No transactions available.',
            style: TextStyle(color: Colors.grey),
          );
        }
        return const Text(
            'To Be updated available.',
            style: TextStyle(color: Colors.grey),
          );
          // children: provider.transactions
          //     .map((transaction) => TransactionView(transaction: transaction))
          //     .toList(),
        ;
      },
    );
  }
}
