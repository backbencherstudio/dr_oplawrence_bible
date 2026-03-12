class DonationResponse {
  final String message;
  final String paymentIntentId;
  final String clientSecret;
  final double amount;
  final String currency;
  final String status;

  DonationResponse({
    required this.message,
    required this.paymentIntentId,
    required this.clientSecret,
    required this.amount,
    required this.currency,
    required this.status,
  });

  factory DonationResponse.fromJson(Map<String, dynamic> json) {
    return DonationResponse(
      message: json['message'],
      paymentIntentId: json['paymentIntentId'],
      clientSecret: json['clientSecret'],
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'],
      status: json['status'],
    );
  }
}