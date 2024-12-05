class TransactionModel {
  final String transactionId;
  final String date;
  final double amount;
  final String description;

  TransactionModel({
    required this.transactionId,
    required this.date,
    required this.amount,
    required this.description,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactionId: json['transactionId'],
      date: json['date'],
      amount: (json['amount'] as num).toDouble(),
      description: json['description'],
    );
  }
}
