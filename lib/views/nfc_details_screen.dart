import 'package:dimples_task/views/card_details_widgets/card_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:dimples_task/api/api_service.dart';

class CardDetailsScreen extends StatefulWidget {
  final int cardId;
  final String token;

  const CardDetailsScreen({
    Key? key,
    required this.cardId,
    required this.token,
  }) : super(key: key);

  @override
  _CardDetailsScreenState createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _cardData;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchCardDetails();
  }

  Future<void> _fetchCardDetails() async {
    try {
      final response = await ApiService.fetchNfcCardDetails(widget.token, widget.cardId);
      setState(() {
        _isLoading = false;
        _cardData = response['data'];
        if (_cardData == null) {
          _errorMessage = 'No data found for this card.';
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to fetch card details. Please try again later.';
      });
    }
  }

  void _topUpCard(BuildContext context) {
    showInputDialog(
      context,
      title: "Top-up Card Balance",
      hint: "Enter amount to top up",
      onConfirm: (amount) async {
        try {
          final responseMessage = await ApiService.topUpCard(
            widget.token,
            widget.cardId,
            double.parse(amount),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseMessage)),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'This Transaction Failed. Top up your wallet and try again',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }
      },
    );
  }

  void _deductCardBalance(BuildContext context) {
    showInputDialog(
      context,
      title: "Deduct Card Balance",
      hint: "Enter amount to deduct",
      onConfirm: (amount) {
        showInputDialog(
          context,
          title: "Confirm PIN",
          hint: "Enter your PIN",
          isPin: true,
          onConfirm: (pin) {
            print("Deduct amount: $amount with PIN $pin for card ${widget.cardId}");
            // Call API for deduction
          },
        );
      },
    );
  }

 void _toggleFreezeState(BuildContext context, bool isCardFrozen) {
  if (isCardFrozen) {
    // Show a dialog asking if the user wants to unfreeze the card
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unfreeze Card'),
        content: const Text('This card is currently frozen. Do you want to unfreeze it?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Close dialog without any action
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              _unfreezeCard(context); // Call unfreeze function
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  } else {
    _freezeCard(context);
  }
}

  void _freezeCard(BuildContext context) async {
    final freezeReason = "stolen"; // Replace with actual reason if needed
    try {
      final responseMessage = await ApiService.freezeCard(
        widget.token,
        widget.cardId,
        freezeReason,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to freeze card: $e', style: const TextStyle(color: Colors.red))),
      );
    }
  }

  void _unfreezeCard(BuildContext context) async {
    try {
      final responseMessage = await ApiService.unfreezeCard(widget.token, widget.cardId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to unfreeze card: $e', style: const TextStyle(color: Colors.red))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Details'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Card Details',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(height: 16),
                          buildDetailRow("Card ID", _cardData?["id"]),
                          buildDetailRow("Card Number", _cardData?["card_number"]),
                          buildDetailRow("Serial Number", _cardData?["serial_number"]),
                          buildDetailRow("Balance", _cardData?["balance"]),
                          buildDetailRow("Status", _cardData?["status"]),
                          buildDetailRow("Activation Date", _cardData?["activation_date"]),
                          buildDetailRow("Transaction Limit", _cardData?["transaction_limit"]),
                          buildDetailRow("Top-up Limit", _cardData?["topup_limit"]),
                          buildDetailRow("Freeze Reason", _cardData?["freeze_reason"] ?? "N/A"),
                          const SizedBox(height: 16),
                          const Divider(thickness: 1),
                          const SizedBox(height: 16),
                          buildActionButtons(
                            context,
                            _cardData?["status"] == "Inactive",
                            _cardData?["status"] == "Frozen",
                            _topUpCard,
                            _deductCardBalance,
                            _toggleFreezeState,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
