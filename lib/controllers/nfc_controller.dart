// lib/controllers/nfc_card_controller.dart
import 'package:dimples_task/api/api_service.dart';
import 'package:flutter/material.dart';

class NfcCardController {
  Future<void> fetchNfcCards(BuildContext context, String token) async {
    try {
      final response = await ApiService.fetchNfcCards(token);
      // Handle successful response, update UI accordingly
      // Pass data to a provider or UI directly
    } catch (e) {
      // Handle error, show a message in the UI
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching NFC cards: $e')),
      );
    }
  }

  Future<void> fetchNfcCardDetails(BuildContext context, String token, int cardId) async {
    try {
      final response = await ApiService.fetchNfcCardDetails(token, cardId);
      // Handle successful response, update UI accordingly
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching card details: $e')),
      );
    }
  }
}
