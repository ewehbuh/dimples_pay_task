import 'package:flutter/material.dart';

class CardBasicInfo extends StatelessWidget {
  final String title;
  final String logo;

  const CardBasicInfo({
    Key? key,
    required this.title,
    required this.logo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          logo,
          height: 60,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
