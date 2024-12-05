class NfcCard {
  final int id;
  final String name;
  final String cardNumber;
  final String cardSerialNumber;
  final String expirationDate;
  final double balance;
  final String status;
  final bool isDefault;

  NfcCard({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.cardSerialNumber,
    required this.expirationDate,
    required this.balance,
    required this.status,
    required this.isDefault,
  });

  factory NfcCard.fromJson(Map<String, dynamic> json) {
    return NfcCard(
      id: json['id'],
      name: json['name'],
      cardNumber: json['card_number'],
      cardSerialNumber: json['card_serial_number'],
      expirationDate: json['expiration_date'],
      balance: (json['balance'] as num).toDouble(),
      status: json['status'],
      isDefault: json['is_default'] == "1",
    );
  }
}
