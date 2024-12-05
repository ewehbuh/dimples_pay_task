import 'package:dimples_task/models/nfc_card_model.dart';
import 'package:dimples_task/providers/nfc_card_provider.dart';
import 'package:dimples_task/views/nfc_details_screen.dart';
import 'package:dimples_task/api/api_service.dart'; // Assuming ApiService is defined elsewhere
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardListView extends StatelessWidget {
  final String token;

  const CardListView({
    Key? key,
    required this.token,
    required List<NfcCard> cards,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NfcCardProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.errorMessage != null) {
          return Center(
              child: Text(provider.errorMessage!)); // Show error message
        }

        return SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.cards.length,
            itemBuilder: (context, index) {
              final card = provider.cards[index];
              return GestureDetector(
                onTap: () {
                  if (card.status.toLowerCase() == 'inactive') {
                    _showInactiveMessage(context);
                  } else if (card.status.toLowerCase() == 'frozen') {
                    _promptUnfreezeCard(context, card.id, token);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CardDetailsScreen(
                          cardId: card.id,
                          token: token,
                        ),
                      ),
                    );
                  }
                },
                child: Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.blueAccent,
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [Colors.blueAccent, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'NFC Card: ${card.id}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Card Number: ${card.cardSerialNumber}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Balance: ${card.balance.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Status: ${card.status}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showInactiveMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Inactive Card'),
          content: const Text(
              'This card is currently inactive. Please activate it before proceeding.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _promptUnfreezeCard(BuildContext context, int cardId, String token) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Frozen Card'),
          content: const Text(
              'This card is currently frozen. Do you want to unfreeze it?'),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(ctx), // Close dialog without action
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx); // Close dialog
                _unfreezeCard(context, cardId, token);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _unfreezeCard(BuildContext context, int cardId, String token) async {
    try {
      final responseMessage = await ApiService.unfreezeCard(token, cardId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to unfreeze card: $e',
              style: const TextStyle(color: Colors.red)),
        ),
      );
    }
  }
}
