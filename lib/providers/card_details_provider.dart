import 'package:flutter/material.dart';
import 'package:dimples_task/api/api_service.dart';

class CardDetailsProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _cardDetails;
  bool _isCardFrozen = false; // Track freeze state

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get cardDetails => _cardDetails;
  bool get isCardFrozen => _isCardFrozen; // Expose freeze state

  // Fetch card details
  Future<void> fetchCardDetails(String token, int cardId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await ApiService.fetchNfcCardDetails(token, cardId);
      _cardDetails = result['data'];
      _isCardFrozen =
          _cardDetails?['status'] == 'Frozen'; // Update freeze state
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Freeze card
  Future<void> freezeCard(String token, int cardId, String freezeReason) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await ApiService.freezeCard(token, cardId, freezeReason);
      _isCardFrozen = true; // Set freeze state to true after freezing
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Unfreeze card
  Future<void> unfreezeCard(String token, int cardId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await ApiService.unfreezeCard(token, cardId);
      _isCardFrozen = false; // Set freeze state to false after unfreezing
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Top-up card
  Future<bool> topUpCard(String token, int cardId, double amount) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final message = await ApiService.topUpCard(token, cardId, amount);
      _errorMessage = null;

      // Optionally, fetch updated card details after top-up
      await fetchCardDetails(token, cardId);

      _isLoading = false;
      notifyListeners();
      return true; // Success
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false; // Failure
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
