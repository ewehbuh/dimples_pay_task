import 'dart:async';
import 'dart:convert';
import 'dart:io'; // For SocketException handling
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class NetworkError implements Exception {
  final String message;
  NetworkError(this.message);
}

class ApiService {
  // Login function

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse("${AppConstants.baseUrl}/api/user/login"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email, "password": password}),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return {
          "message": data["message"]["success"]?.first ?? "Login Successful",
          "user": data["data"]["user"],
          "token": data["data"]["token"],
        };
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        final String errorMessage =
            errorData["message"]["error"]?.first ?? "An error occurred.";
        throw Exception(errorMessage);
      }
    } on SocketException {
      throw NetworkError('No Internet connection');
    } on TimeoutException {
      throw NetworkError('Connection Timeout. Please, try again');
    } catch (e) {
      throw NetworkError(' $e');
    }
  }

  // Fetch NFC Cards
  static Future<Map<String, dynamic>> fetchNfcCards(String token) async {
    try {
      final response = await http.get(
        Uri.parse("${AppConstants.baseUrl}/api/user/nfc-cards/all-cards"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return {
          "message": data["message"]["success"]?.first ?? "Data retrieved",
          "data": data["data"],
        };
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        final String errorMessage =
            errorData["message"]["error"]?.first ?? "An error occurred.";
        throw Exception(errorMessage);
      }
    } on SocketException {
      throw NetworkError('No Internet connection');
    } on TimeoutException {
      throw NetworkError('Connection Timeout. Please, try again');
    } catch (e) {
      throw NetworkError(' $e');
    }
  }

  static Future<String> freezeCard(
      String token, int cardId, String freezeReason) async {
    final response = await http.post(
      Uri.parse('${AppConstants.baseUrl}/api/user/nfc-cards/freeze'),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        'card_id': cardId.toString(),
        'freeze_reason': freezeReason,
      },
    );

    if (response.statusCode == 200) {
      // Return success message
      return 'Card frozen successfully';
    } else {
      // Return error message from API
      final responseBody = json.decode(response.body);
      throw Exception(responseBody['message']['error'].join(', '));
    }
  }

  static Future<String> unfreezeCard(String token, int cardId) async {
    final response = await http.post(
      Uri.parse('${AppConstants.baseUrl}/api/user/nfc-cards/unfreeze'),
      headers: {'Authorization': 'Bearer $token'},
     body: {
        'card_id': cardId.toString(),
        
      },
    );
    print(cardId);
    print(response.body);
    if (response.statusCode == 200) {
      return 'Card unfrozen successfully';
    } else {
      throw Exception('Failed to unfreeze card');
    }
  }

  // Fetch NFC Card Details (GET Method)
  static Future<Map<String, dynamic>> fetchNfcCardDetails(
      String token, int cardId) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${AppConstants.baseUrl}/api/user/nfc-cards/details?card_id=$cardId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).timeout(const Duration(seconds: 15));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return {
          "message": data["message"]["success"]?.first ?? "Data retrieved",
          "data": data["data"],
        };
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        final String errorMessage =
            errorData["message"]["error"]?.first ?? "An error occurred.";
        throw Exception(errorMessage);
      }
    } on SocketException {
      throw NetworkError('No Internet connection');
    } on TimeoutException {
      throw NetworkError('Connection Timeout. Please, try again');
    } catch (e) {
      throw NetworkError('Something went wrong: $e');
    }
  }

  // Top-up NFC Card
  static Future<String> topUpCard(
      String token, int cardId, double topupAmount) async {
    try {
      final response = await http
          .post(
            Uri.parse("${AppConstants.baseUrl}/api/user/nfc-cards/top-up"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: jsonEncode({
              "card_id": cardId,
              "topup_amount": topupAmount,
            }),
          )
          .timeout(const Duration(seconds: 15));
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data["message"]["success"]?.first ?? "Top-up successful!";
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        final String errorMessage =
            errorData["message"]["error"]?.first ?? "An error occurred.";
        throw Exception(errorMessage);
      }
    } on SocketException {
      throw NetworkError('No Internet connection');
    } on TimeoutException {
      throw NetworkError('Connection Timeout. Please, try again');
    } catch (e) {
      throw NetworkError('Something went wrong: $e');
    }
  }

// Buy NFC Card
  static Future<String> buyCard(
      String token, String name, double balance) async {
    try {
      final response = await http
          .post(
            Uri.parse("${AppConstants.baseUrl}/api/user/nfc-cards/card-buy"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: jsonEncode({
              "card_type": "physical",
              "name": name,
              "balance": balance,
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data["message"]["success"]?.first ??
            "Card purchased successfully!";
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        final String errorMessage =
            errorData["message"]["error"]?.first ?? "An error occurred.";
        throw Exception(errorMessage);
      }
    } on SocketException {
      throw NetworkError('No Internet connection');
    } on TimeoutException {
      throw NetworkError('Connection Timeout. Please, try again');
    } catch (e) {
      throw NetworkError('Something went wrong: $e');
    }
  }
}
