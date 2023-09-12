class UserAccountResponse {
  final bool error;
  final String message;
  final UserAccount body;

  UserAccountResponse({
    required this.error,
    required this.message,
    required this.body,
  });

  factory UserAccountResponse.fromJson(Map<String, dynamic> json) {
    return UserAccountResponse(
      error: json['error'],
      message: json['message'],
      body: UserAccount.fromJson(json['body']),
    );
  }
}

class UserAccount {
  final int userId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String emailAddress;
  final String password;
  final String? balance;
  final String? currency;
  final String? cardExpiry;
  final String? verifiedNumber;
  final String? mobileuuid;
  final String? firebaseId;
  final String mobileNumber;
  final String loanLimit;
  final String? sheloans;
  final String? shebnksCardNumber;
  final String? uuid;
  final String? profileImage;
  final String? messagingToken;
  final int accountVerificationStatus;
  final String idNumber;

  UserAccount({
    required this.userId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.emailAddress,
    required this.password,
    required this.mobileNumber,
    required this.loanLimit,
    required this.accountVerificationStatus,
    required this.idNumber,
    this.balance,
    this.currency,
    this.cardExpiry,
    this.verifiedNumber,
    this.mobileuuid,
    this.firebaseId,
    this.sheloans,
    this.shebnksCardNumber,
    this.uuid,
    this.profileImage,
    this.messagingToken,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      userId: json['userId'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      emailAddress: json['emailAddress'],
      password: json['password'],
      balance: json['balance'],
      currency: json['currency'],
      cardExpiry: json['cardExpiry'],
      verifiedNumber: json['verifiedNumber'],
      mobileuuid: json['mobileuuid'],
      firebaseId: json['firebaseId'],
      mobileNumber: json['mobileNumber'],
      loanLimit: json['loanLimit'],
      sheloans: json['sheloans'],
      shebnksCardNumber: json['shebnksCardNumber'],
      uuid: json['uuid'],
      profileImage: json['profileImage'],
      messagingToken: json['messagingToken'],
      accountVerificationStatus: json['accountVerificationStatus'],
      idNumber: json['idNumber'],
    );
  }
}
