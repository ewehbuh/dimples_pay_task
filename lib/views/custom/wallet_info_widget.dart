import 'package:flutter/material.dart';

class WalletInfoView extends StatelessWidget {
  final double balance;
  final String currency;
  final String logo;
  final String title;

  const WalletInfoView({
    Key? key,
    required this.balance,
    required this.currency,
    required this.logo,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blueAccent, Colors.lightBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo and Title Row
          Row(
            children: [
              // Logo
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(logo),
                onBackgroundImageError: (_, __) => const Icon(
                  Icons.error,
                  size: 24,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 10),
              // Wallet Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Balance
          Text(
            '$currency $balance',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          // Card Number and Placeholder Logo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Card Number Placeholder
              const Text(
                '**** **** **** 1234',
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 2,
                  color: Colors.white70,
                ),
              ),
              // Styled Placeholder for Visa Logo
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'DIM',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
