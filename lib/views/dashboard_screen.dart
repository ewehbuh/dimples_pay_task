import 'package:dimples_task/api/api_service.dart';
import 'package:dimples_task/views/custom/nfc_cards_widget.dart';
import 'package:dimples_task/views/custom/transactions_card.dart';
import 'package:dimples_task/views/custom/user_profile_info.dart';
import 'package:dimples_task/views/custom/wallet_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/nfc_card_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final nfcCardProvider =
        Provider.of<NfcCardProvider>(context, listen: false);

    if (!authProvider.isAuthenticated || authProvider.token == null) {
      return const Scaffold(
        body: Center(
          child: Text('Please log in to access the dashboard.'),
        ),
      );
    }

    final String? token = authProvider.token;
    final user = authProvider.user!;
    final String name = user['firstname'];
    final String lastName = user['lastname'];
    final String lastLogin = user['lastLogin'] ?? 'N/A';
    final String profileImage = user['image'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: FutureBuilder(
        future: nfcCardProvider.fetchNfcCards(token!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Profile Info Section
                    UserProfileCard(
                      name: 'Hello, $lastName',
                      lastLogin: lastLogin,
                      profileImage: profileImage,
                    ),
                    const SizedBox(height: 20),

                    // Wallet Info Section
                    WalletInfoView(
                      balance: nfcCardProvider.userWallet['balance'] ?? 0.0,
                      currency: nfcCardProvider.userWallet['currency'] ?? 'N/A',
                      logo: nfcCardProvider.cardBasicInfo['site_logo'] ?? '',
                      title:
                          nfcCardProvider.cardBasicInfo['site_title'] ?? 'N/A',
                    ),
                    const SizedBox(height: 20),

                    // NFC Cards Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "My Cards",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () => _buyCard(context, token),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          child: const Text("Buy Card"),
                        ),
                      ],
                    ),
                    CardListView(
                      cards: nfcCardProvider.cards,
                      token: token,
                    ),
                    const SizedBox(height: 20),

                    // Transactions Section
                    const Text(
                      "Transactions",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TransactionListView(
                        transactions: nfcCardProvider.transactions),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

void _buyCard(BuildContext context, String token) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();

  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: const Text("Buy New Card"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: balanceController,
              decoration: const InputDecoration(labelText: "Initial Balance"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              final String name = nameController.text.trim();
              final double? balance =
                  double.tryParse(balanceController.text.trim());
              if (name.isEmpty || balance == null || balance <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Invalid input. Please try again.")),
                );
                return;
              }

              Navigator.pop(ctx); // Close the dialog

              try {
                final responseMessage =
                    await ApiService.buyCard(token, name, balance);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(responseMessage)),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                        // e.toString(),
                      "CHECK YOUR BALANCE AND TRY AGAIN",
                          style: const TextStyle(color: Colors.red))),
                );
              }
            },
            child: const Text("Confirm"),
          ),
        ],
      );
    },
  );
}
