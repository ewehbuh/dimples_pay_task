// card_detail_widgets.dart
import 'package:flutter/material.dart';

Widget buildDetailRow(String label, dynamic value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          value?.toString() ?? 'N/A',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}

Widget buildActionButtons(BuildContext context, bool isCardInactive,
    bool isCardFrozen, Function topUpCard, Function deductCardBalance, Function toggleFreezeState) {
  return Column(
    children: [
      ElevatedButton(
        onPressed: isCardInactive ? null : () => topUpCard(context),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        child: const Text('Top-up Card Balance'),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: isCardInactive ? null : () => deductCardBalance(context),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
        child: const Text('Deduct Card Balance'),
      ),
      const SizedBox(height: 8),
      ElevatedButton(
        onPressed: isCardInactive
            ? null
            : () => toggleFreezeState(context, isCardFrozen),
        style: ElevatedButton.styleFrom(
          backgroundColor: isCardFrozen ? Colors.blue : Colors.red,
        ),
        child: Text(isCardFrozen ? 'Unfreeze Card' : 'Freeze Card'),
      ),
    ],
  );
}

Future<void> showInputDialog(BuildContext context,
    {required String title,
    required String hint,
    required Function(String) onConfirm,
    bool isPin = false}) {
  final controller = TextEditingController();
  return showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: hint),
          keyboardType: isPin
              ? TextInputType.number
              : TextInputType.numberWithOptions(decimal: true),
          obscureText: isPin,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              onConfirm(controller.text.trim());
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );
}
