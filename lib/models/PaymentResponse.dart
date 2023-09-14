class PaymentResponse {
  final String merchantRequestID;
  final String checkoutRequestID;
  final String responseCode;
  final String responseDescription;
  final String customerMessage;

  PaymentResponse({
    required this.merchantRequestID,
    required this.checkoutRequestID,
    required this.responseCode,
    required this.responseDescription,
    required this.customerMessage,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      merchantRequestID: json['MerchantRequestID'],
      checkoutRequestID: json['CheckoutRequestID'],
      responseCode: json['ResponseCode'],
      responseDescription: json['ResponseDescription'],
      customerMessage: json['CustomerMessage'],
    );
  }
}
