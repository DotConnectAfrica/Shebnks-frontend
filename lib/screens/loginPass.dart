import 'dart:convert';

import 'package:clippy_flutter/arc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:she_banks/api_services/api_services.dart';
import 'package:she_banks/models/IQ.dart';
import 'package:she_banks/models/loginModel.dart';
import 'package:she_banks/screens/screen_forgotPassword.dart';
import 'package:she_banks/screens/screen_home.dart';
import 'package:she_banks/screens/screen_registration.dart';
import 'package:she_banks/screens/screen_sheiq.dart';
import 'package:she_banks/utils/universal_methods.dart';

const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);

class LoginPass extends StatefulWidget {
  const LoginPass({Key? key}) : super(key: key);

  @override
  State<LoginPass> createState() => _LoginPassState();
}

class _LoginPassState extends State<LoginPass> {
  TextEditingController _passController = TextEditingController();
  TextEditingController _cnfpinController = TextEditingController();
  final _apiServices = ApiServices();
  GlobalKey _formKey = GlobalKey();
  bool _isLoading = false;
  var _mPhone;
  var _fName;
  var _lName;
  var _email;
  var _mobile;
  var _idNumber;
  var _token;
  var _userId;
  String? encondedLoans;
  List<Question> questions = [];
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';
  // List<Loans> loans =[];
  // List<String> _encodedLoans=[];
  setHasNLoan() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('hasExistingLoan', false);
  }

  setHasLoan() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('hasExistingLoan', true);
  }

  getPhone() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var phone = _prefs.getString("PhoneNumber");
    _mPhone = phone?.replaceAll('+', '');
    debugPrint("phone........$phone");
    return _mPhone;
  }

  setLoginState() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('userExists', true);
  }

  storeDetails(
    String _fName,
    String _lName,
    String _mobile,
    String _token,
    int _userId,
    String _email,
  ) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    setState(() {
      debugPrint("Tokeeeeeeeeeen  $_token");

      _prefs.setString('token', _token);
      _prefs.setString('fName', _fName);
      _prefs.setString('lName', _lName);
      _prefs.setString('email', _email);
      _prefs.setInt('userId', _userId);
    });
  }

  storeLoanDetails(int initAmount, int remainingAmount, String status, int id,
      int amountToPay) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefs.setInt('initAmount', initAmount);
      _prefs.setInt('remainingAmount', remainingAmount);
      _prefs.setString('status', status);
      _prefs.setInt('loanId', id);
      _prefs.setInt('amountToPay', amountToPay);
    });
  }

  @override
  void initState() {
    setLoginState();
    getPhone();
    // getIQuestions();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      // In mobile, being authenticated means being authorized...
      bool isAuthorized = account != null;
      // However, in the web...
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }

      setState(() {
        _currentUser = account;
        _isAuthorized = isAuthorized;
      });
    });

    _googleSignIn.signInSilently();
    super.initState();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    final GoogleSignInAccount? user = _currentUser;
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
      child: Container(
        margin: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              const CircleAvatar(
                backgroundColor: Colors.black,
                radius: 50,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Enter Password to Continue',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        // maxLength: 10,
                        controller: _passController,
                        obscureText: true,
                        decoration: InputDecoration(
                          // icon: const Icon(CupertinoIcons.lock),
                          hintText: 'Password',
                          contentPadding:
                              const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),

                          hintStyle:
                              const TextStyle(fontSize: 13, color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          //fillColor: Colors.green
                        ),
                        validator: (val) {
                          if (val!.length == 0) {
                            return "Pasword cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                            // fontFamily: "Poppins",
                            ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: _isLoading
                              ? SpinKitCircle(
                                  color: Color(0xffed39ca),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xffed39ca)),
                                  onPressed: () {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    getLoginData();
                                    // Get.to(()=>ScreenRegistration());
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white),
                                  ))),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(''),
                          InkWell(
                              onTap: () {
                                _otpRequest(_mPhone);
                              },
                              child: const Text('Forgot Password?'))
                        ],
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffed39ca)),
                          onPressed: () {
                            setState(() {
                              _isLoading = true;
                            });
                            // getLoginWithGmail(user!.email);
                            getLoginWithGmail(user);
                          },
                          child: const Text(
                            'Login with Google',
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ))
            ]),
      ),
    )));
  }

  void _otpRequest(String phone) {
    _apiServices.requestOtp(phone).then((value) {
      if (value.status == 200) {
        Get.to(() => ForgotPassword(_mPhone));
      } else {
        UniversalMethods.show_toast('Unable to Send OTP. Try again later',
            context); // _showDialog(value.message.toString());
      }
    });
  }

  getLoginData() async {
    var _password = _passController.text;
    var _phone = _mPhone;

    await _login(_phone, _password);
  }

  getLoginWithGmail(user) async {
    // _handleSig
    _handleSignIn();
    user != null
        ? await _loginWithGmail(user.email)
        : Get.snackbar("Failed", "No google user found");
  }

  Future _loginWithGmail(String email) async {
    Map newRequestData = {
      'email': "${email.toString()}",
    };
    _apiServices.loginWithGmail(email).then((value) {
      debugPrint('loginValue...${value}');
      if (value.status == 200) {
        _fName = value.data?.user?.firstName;
        _lName = value.data?.user?.lastName;
        _idNumber = value.data?.user?.id;
        _email = value.data?.user?.email;
        _mobile = value.data?.user?.mobile;
        _userId = value.data?.user?.userId;
        _token = value.data?.token;

        debugPrint("Token sfgyuigs: $_token");
        encondedLoans = jsonEncode(value.data?.loan);
        // getIQuestions();
        // _encodedLoans= jsonEncode(loans);

        debugPrint('Details.......${_fName}');
        debugPrint('Details.......${_lName}');
        debugPrint('Details.......${_token}');
        debugPrint('UserID.......${_userId}');
        // debugPrint('produts.......${ encondedLoans}');
        // var initAmount = value.data.loan.initialAmount;
        // var remainingAmount = value.data.loan.initialAmount;
        // var status = value.data.loan.status;
        // var loanId = value.data.loan.id;
        var loan = value.data?.loan;
        debugPrint('produts.......${loan}');

        storeDetails(_fName, _lName, _mobile, _token, _userId, _email
            // initAmount, remainingAmount, status, loanId
            );

        // storeDetails(_fName, _lName, _mobile, _token, _userId, _email, encondedLoans?);
        Get.snackbar("", 'Login Successful');
        setState(() {
          _isLoading = false;
        });
        if (loan?.amountToPay != null) {
          setState(() {
            setHasLoan();

            print('HasLoan');
            var initAmount = value.data?.loan?.initialAmount;
            var remainingAmount = value.data?.loan?.amountRemaining;
            var amountToPay = value.data?.loan?.amountToPay;
            var status = value.data?.loan?.status;
            var loanId = value.data?.loan?.id;
            Loan? loan = value.data?.loan;

            storeLoanDetails(
                initAmount!, remainingAmount!, status!, amountToPay!, loanId!);
          });
        } else {
          setState(() {
            setHasNLoan();
          });
        }

        // ScreenSheIq

        // Get.offAll(()=>ScreenSheIq(_token));
        Get.offAll(() => Homescreen(
              fName: _fName,
              lName: _lName,
              phone: _mPhone,
              token: _token,
              email: _email,
              userId: _userId,
            ));
      } else {
        setState(() {
          _isLoading = false;
        });
        return showDialog<void>(
            context: context,
            barrierDismissible: true, // user must tap button!
            builder: (BuildContext context) {
              // setState(() {
              //   _isLoading=false;
              // });
              return AlertDialog(
                title: const Text('Alert'),
                content: Text('${value.message.toString()}'),
              );
            });
      }
    });
  }

  getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    return fcmToken;
  }

  Future _login(_phone, _password) async {
    Map newRequestData = {
      'password': "${_password.toString()}",
      'mobile': "${_phone.toString()}",
    };
    _apiServices.login(_phone, _password).then((value) {
      debugPrint('loginValue...${value}');
      if (value.status == 200) {
        _fName = value.data?.user?.firstName;
        _lName = value.data?.user?.lastName;
        _idNumber = value.data?.user?.id;
        _email = value.data?.user?.email;
        _mobile = value.data?.user?.mobile;
        _userId = value.data?.user?.userId;
        _token = value.data?.token;

        debugPrint("Token sfgyuigs: $_token");
        encondedLoans = jsonEncode(value.data?.loan);
        // getIQuestions();
        // _encodedLoans= jsonEncode(loans);

        debugPrint('Details.......${_fName}');
        debugPrint('Details.......${_lName}');
        debugPrint('Details.......${_token}');
        debugPrint('UserID.......${_userId}');
        // debugPrint('produts.......${ encondedLoans}');
        // var initAmount = value.data.loan.initialAmount;
        // var remainingAmount = value.data.loan.initialAmount;
        // var status = value.data.loan.status;
        // var loanId = value.data.loan.id;
        var loan = value.data?.loan;
        debugPrint('produts.......${loan}');

        storeDetails(_fName, _lName, _mobile, _token, _userId, _email
            // initAmount, remainingAmount, status, loanId
            );

        // storeDetails(_fName, _lName, _mobile, _token, _userId, _email, encondedLoans?);
        Get.snackbar("", 'Login Successful');
        setState(() {
          _isLoading = false;
        });
        if (loan?.amountToPay != null) {
          setState(() {
            setHasLoan();

            print('HasLoan');
            var initAmount = value.data?.loan?.initialAmount;
            var remainingAmount = value.data?.loan?.amountRemaining;
            var amountToPay = value.data?.loan?.amountToPay;
            var status = value.data?.loan?.status;
            var loanId = value.data?.loan?.id;
            Loan? loan = value.data?.loan;

            storeLoanDetails(
                initAmount!, remainingAmount!, status!, amountToPay!, loanId!);
          });
        } else {
          setState(() {
            setHasNLoan();
          });
        }

        // ScreenSheIq

        // Get.offAll(()=>ScreenSheIq(_token));
        Get.offAll(() => Homescreen(
              fName: _fName,
              lName: _lName,
              phone: _mPhone,
              token: _token,
              email: _email,
              userId: _userId,
            ));
      } else {
        setState(() {
          _isLoading = false;
        });
        return showDialog<void>(
            context: context,
            barrierDismissible: true, // user must tap button!
            builder: (BuildContext context) {
              // setState(() {
              //   _isLoading=false;
              // });
              return AlertDialog(
                title: const Text('Alert'),
                content: Text('${value.message.toString()}'),
              );
            });
      }
    });
  }
}
