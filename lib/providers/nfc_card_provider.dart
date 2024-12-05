import 'package:dimples_task/models/transactions_card_model.dart';
import 'package:flutter/material.dart';
import '../models/nfc_card_model.dart';
import '../api/api_service.dart';

class NfcCardProvider with ChangeNotifier {
  List<NfcCard> _cards = [];
  List<TransactionModel> _transactions = [];
  Map<String, dynamic> _userWallet = {};
  Map<String, dynamic> _cardBasicInfo = {};
  bool _isLoading = false;
  String? _errorMessage; // Add private error message variable

  // Getters
  List<NfcCard> get cards => _cards;
  List<TransactionModel> get transactions => _transactions;
  Map<String, dynamic> get userWallet => _userWallet;
  Map<String, dynamic> get cardBasicInfo => _cardBasicInfo;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage; // Getter for error message

  // Fetch NFC Cards
  Future<void> fetchNfcCards(String token) async {
    _isLoading = true;
    _errorMessage = null; // Reset error message when fetching starts
    notifyListeners();
    
    try {
      final response = await ApiService.fetchNfcCards(token);

      // Parse data
      _cards = (response['data']['myCard'] as List<dynamic>)
          .map((card) => NfcCard.fromJson(card))
          .toList();

      _transactions = (response['data']['transactions'] as List<dynamic>)
          .map((tx) => TransactionModel.fromJson(tx))
          .toList();

      _userWallet = Map<String, dynamic>.from(response['data']['userWallet']);
      _cardBasicInfo = Map<String, dynamic>.from(response['data']['card_basic_info']);
    } catch (e) {
      _errorMessage = 'Error fetching NFC cards: $e'; // Update the error message
      print(_errorMessage); // Log error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
