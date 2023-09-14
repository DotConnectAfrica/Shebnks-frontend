import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:she_banks/models/Activation.dart';
import 'package:she_banks/models/IQ.dart';
import 'package:she_banks/models/Registration.dart';
import 'package:she_banks/models/Success.dart';
import 'package:she_banks/models/laon.dart';
import 'package:she_banks/models/loan_types.dart';
import 'package:she_banks/models/loginModel.dart';
import 'package:she_banks/models/model_user.dart';
import 'package:she_banks/models/seedModel.dart';

import '../models/Error.dart';
import '../models/FirebaseModel.dart';
import 'package:dio/dio.dart';

import '../models/LoanApplicationModel.dart';
import '../models/PaymentResponse.dart';
import '../models/SeedFund.dart';
import '../models/UserAccountResponse.dart';
import '../models/model_loan_status.dart';
import '../models/updateModel.dart';

final dio = Dio();

class ApiServices {
  // late String base_url;
  bool test = false;
  static const List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];
  Future<void> handleSignIn() async {
    try {
      await googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  GoogleSignIn googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: 'your-client_id.apps.googleusercontent.com',
    scopes: scopes,
  );

  Future<UserCredential?> signInWithGoogle() async {
    // Create an instance of the firebase auth and google signin
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    //Triger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    //Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    //Create a new credentials
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    //Sign in the user with the credentials
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
    return null;
  }

  // if(test) {
  // fibase_url= '192.168.137.202:8080/she/api/v1';
  // }else {
  // base_url= 'http://192.168.152.238:8080/she/api/v1';
  // }
  //live
  // final String base_url = 'https://shebnks.com/she/api/v1';
  final String base_url = "https://shebnks.com";
  // final String base_url = "10.0.2.2:8090";
  // final String base_url = 'https://dca.com/she/api/v1';
  // /she/api/v1/loan/request/:userId
  //test
  // final String base_url = 'http://192.168.29.238:8080/she/api/v1';

  // /auth/login';
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<SuccessModel> requestOtp(String mobile) async {
    final String phoneNumber = mobile;
    String result = "";
    final Uri url = Uri.parse('https://shebnks.com/otp/send-otp');
    final Map<String, String> body = {
      'phoneNumber': phoneNumber,
    };

    final response = await http.post(url, body: body);

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print("response$response.body");
      return SuccessModel.fromJson(jsonDecode(response.body));
    } else {
      print("error again");
      throw Exception('Failed to send otp');

      // }
    }
  }

  Future<UserAccountResponse> getUserDetail(String mobile) async {
    final String phoneNumber = mobile;
    String result = "";
    final Uri url = Uri.parse(
        'https://shebnks.com/api/profile/get-user-details/${phoneNumber}');
    // final Map<String, String> body = {
    //   'user': phoneNumber,
    // };

    final response = await http.get(url);
    debugPrint(response.body);
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print("responsee$response.body");
      return UserAccountResponse.fromJson(jsonDecode(response.body));
    } else {
      print("error again");
      throw Exception('Failed to send otp');

      // }
    }
  }

  Future forgotPassword(String password, String phoneNumber) async {
    String url = "https://shebnks.com/otp/reset-password";

    final Map<String, String> body = {
      "phoneNumber": phoneNumber,
      "password": password
    };

    debugPrint('cPin request>>>>>$body');

    final response = await http.post(Uri.parse(url), body: body);
    debugPrint('cPin${response.body}');

    if (response.statusCode == 200) {
      return SuccessModel.fromJson(jsonDecode(response.body));
    } else {
      return ErrorP.fromJson(jsonDecode(response.body));
    }
  }

  Future<Activation> verifyOtp(String mobile, String otpCode) async {
    final String phoneNumber = mobile;
    final String otp = otpCode;
    String result = "";
    final Uri url = Uri.parse('https://shebnks.com/otp/validate');
    final Map<String, String> body = {
      'phoneNumber': phoneNumber,
      'otpCode': otp
    };

    final response = await http.post(url, body: body);
    print(response);
    print(response.body);
    if (response.statusCode == 201) {
      debugPrint("response$response.body");
      return Activation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Invalid Otp');
    }
  }

  Future<LoginModel> login(String mobile, String pass) async {
    final String phoneNumber = mobile;
    final String password = pass;

    final Uri url = Uri.parse('https://shebnks.com/otp/login');
    final Map<String, String> body = {
      'phoneNumber': phoneNumber,
      'password': password
    };

    final response = await http.post(url, body: body);
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      debugPrint(response.body);
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Invalid Password');
    }
  }

  Future<LoginModel> loginWithGmail(String email) async {
    final String url = 'https://shebnks.com/otp/loginMail/${email}';

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.get(Uri.parse(url), headers: headers);
    print(response.body);
    print(response.statusCode);
    debugPrint("try to login with gmail");

    if (response.statusCode == 200) {
      debugPrint(response.body);
      debugPrint("logged");
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      debugPrint("failed");
      throw Exception('Email does not exists');
    }
  }

  Future sign_up(Map data) async {
    final Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    String url = 'https://shebnks.com/api/auth/signup';
    debugPrint('requestBody...................$data');

    final response = await http.post(Uri.parse(url), body: data);
    debugPrint('responsedata${response.body}');
    debugPrint('responsedata${response.statusCode}');
    if (response.statusCode == 200) {
      return SuccessModel.fromJson(jsonDecode(response.body));
    } else {
      return ErrorP.fromJson(jsonDecode(response.body));
    }
    // } catch(e){
    //   print('Error is ${e.toString()}');
    // }
  }

  Future getAllIQ(String _token) async {
    String url = base_url + '/survey/quiz/all';
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_token}',
    };
    final response = await http.get(Uri.parse(url), headers: headers);
    debugPrint('Response is......${response.body}');

    if (response.statusCode == 200) {
      return IQ.fromJson(jsonDecode(response.body));
    } else
      return ErrorP.fromJson(jsonDecode(response.body));
  }

  Future update_data(Map data, int _userId) async {
    // String url = base_url + '/user/profile/update/${_userId}';
    String url = "https://shebnks.com/api/profile/update-user-data/${_userId}";
    print(jsonEncode(data));
    //  String jsonData = jsonEncode(datas); // Encode the data as JSON

    final response = await http.put(Uri.parse(url), body: data);
    debugPrint('response is...................${response.body}');
    if (response.statusCode == 200) {
      debugPrint('response is...................${response.body}');
      return UpdateModel.fromJson(jsonDecode(response.body));
    } else {
      debugPrint('response is...................${response.body}');
      return ErrorP.fromJson(jsonDecode(response.body));
    }
  }

  submit_sheiq(iq_body) async {
    String url = "https://shebnks.com/api/she-iq";
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.post(Uri.parse(url),
        headers: header, body: jsonEncode(iq_body));
    debugPrint('IQ Response>>>>>>>${response.body}');
    if (response.statusCode == 200) {
      return SuccessModel.fromJson(jsonDecode(response.body));
    } else {
      return ErrorP.fromJson(jsonDecode(response.body));
    }
  }

  submit_iq(Map iq_body) async {
    String url = "https://shebnks.com/api/sheiq";
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    debugPrint('requestbodyisss......' + '${iq_body}');

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(iq_body));
    debugPrint('IQ Response>>>>>>>${response.body}');
    if (response.statusCode == 200) {
      return SuccessModel.fromJson(jsonDecode(response.body));
    } else {
      return ErrorP.fromJson(jsonDecode(response.body));
    }
  }

  String generateLoanCode() {
    final random = Random();
    const characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    final codeLength = 4;
    String code = '';

    for (var i = 0; i < codeLength; i++) {
      final randomIndex = random.nextInt(characters.length);
      code += characters[randomIndex];
    }

    return code;
  }

  Future applyloan(Map _data) async {
    String url = "https://shebnks.com/sheloans/loan-request";
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post(Uri.parse(url),
        headers: header, body: jsonEncode(_data));
    print(jsonEncode(_data));
    print(_data);
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      debugPrint("response$response.body");
      return LoanApplicationModel.fromJson(jsonDecode(response.body));
    } else {
      debugPrint("invalid loan request");
      return LoanApplicationModel.fromJson(jsonDecode(response.body));
    }
  }

  Future repayLoan(Map _data) async {
    String url = "https://shebnks.com/mobile-money/stk-transaction-request";
    // Map<String, String> headers = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    //   // 'Authorization': 'Bearer ${_token}',
    // };
    debugPrint('Loan repayment Request is>>>>${_data}');

    final response = await http.post(Uri.parse(url), body: _data);

    debugPrint('Loan Response is>>>>${response.body}');
    debugPrint('Loan Response is>>>>${response.statusCode}');

    if (response.statusCode == 200) {
      return PaymentResponse.fromJson(jsonDecode(response.body));
    } else {
      return Exception('EEEEEE>>>>>>${response.body}');
    }
  }

  checkSeedProgress(int _userId) async {
    String url = "https://shebnks.com/seedFund/view-progress/${_userId}";
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      debugPrint(jsonDecode(response.body).toString());
      return SeedFund.fromJson(jsonDecode(response.body));
    } else {
      return SeedFund.fromJson(jsonDecode(response.body));
      // return Exception('Errorrrr>>>${response.body}');
    }
  }

  seedFundApplication(Map seedfundData) async {
    String url = "https://shebnks.com/seedFund/loan-request";
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer ${_token}',
    };

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(seedfundData));
    debugPrint(response.body);
    debugPrint(response.statusCode.toString());

    if (response.statusCode == 200) {
      return SuccessModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Invalid loan Request');
    }
  }
}
