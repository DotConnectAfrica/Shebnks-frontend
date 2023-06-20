import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:she_banks/screens/screen_home.dart';
import 'package:she_banks/screens/screen_she_funds.dart';

import '../api_services/api_services.dart';
import '../utils/universal_methods.dart';
import 'colors.dart';

class SheIq extends StatefulWidget {
  final token;
  final fName;
  final userId;

  SheIq({required this.token, required this.fName, required this.userId});

  @override
  _SheIqState createState() => _SheIqState();
}

class _SheIqState extends State<SheIq> {
  List<String> selectedCategories2 = [];

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _apiServices = ApiServices();
  var isOtherEnabled = false;
  var isOtherEnabled2 = false;
  var isAnyoneHavingBankAccount = 1;
  var isHavingAtmCard = 1;
  var isHavingInsurancePolicy = 0;
  var isHavingBusiness = 1;

  storeHasLoan() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('hasExistingLoan', true);
  }

  TextEditingController _amountController = TextEditingController();
  TextEditingController _womanOwnedController = TextEditingController();
  TextEditingController _howLongController = TextEditingController();

  // TextEditingController .dispose();
  TextEditingController _legalController = TextEditingController();
  TextEditingController _industryController = TextEditingController();
  TextEditingController _loanPurposeController = TextEditingController();
  TextEditingController _loanUseController = TextEditingController();
  TextEditingController _estimatedTimeController = TextEditingController();
  TextEditingController _businessOverviewController = TextEditingController();
  TextEditingController _annualRevenueTimeController = TextEditingController();
  TextEditingController _existingLoansController = TextEditingController();
  TextEditingController _collateralController = TextEditingController();
  TextEditingController _previouslyAppliedController = TextEditingController();
  TextEditingController _statementController = TextEditingController();
  TextEditingController _employeeNoController = TextEditingController();
  TextEditingController _financialChallengesController =
  TextEditingController();
  TextEditingController _bplanController = TextEditingController();
  TextEditingController _competitorController = TextEditingController();
  TextEditingController _womenController = TextEditingController();
  TextEditingController _marketingController = TextEditingController();
  TextEditingController _reliabilityController = TextEditingController();
  TextEditingController _trainingController = TextEditingController();
  TextEditingController _mentorController = TextEditingController();
  TextEditingController _otherInfoController = TextEditingController();

  // TextEditingController _trainingController = TextEditingController();

  @override
  void dispose() {
    // _amountController.dispose();
    _amountController.dispose();
    _womanOwnedController.dispose();
    _howLongController.dispose();
    _legalController.dispose();
    _industryController.dispose();
    _loanPurposeController.dispose();
    _loanUseController.dispose();
    _estimatedTimeController.dispose();
    _businessOverviewController.dispose();
    _annualRevenueTimeController.dispose();
    _existingLoansController.dispose();
    _collateralController.dispose();
    _previouslyAppliedController.dispose();
    _statementController.dispose();
    _employeeNoController.dispose();
    _financialChallengesController.dispose();
    _bplanController.dispose();
    _competitorController.dispose();
    _womenController.dispose();
    _marketingController.dispose();
    _reliabilityController.dispose();
    _trainingController.dispose();
    _mentorController.dispose();
    _otherInfoController.dispose();
    // TextEditingController _trainingController = TextEditingController();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      List<String> finalIndustry = [];

      final amount = _amountController.text;
      // final womanOwned = _womanOwnedController.text;
      final howLong = _howLongController.text;
      final legal = _legalController.text;
      // final industry = _industryController.text;
      finalIndustry.addAll(_industryController.text.split(','));
      finalIndustry.addAll(selectedCategories2);
      final loanPurpose = _loanPurposeController.text;
      final loanUse = _loanUseController.text;
      final estTime = _estimatedTimeController.text;
      final businessOverview = _businessOverviewController.text;
      final annualRevenue = _annualRevenueTimeController.text;
      // final existingloans = _existingLoansController.text;
      final collateral = _collateralController.text;
      final previouslyAppplied = _previouslyAppliedController.text;
      // final statement = _statementController.text;
      final employeeNo = _employeeNoController.text;
      final financialChallenges = _financialChallengesController.text;
      // final bPlan = _bplanController.text;
      final competitor = _competitorController.text;
      // final women = _womenController.text;
      final marketing = _marketingController.text;
      // final reliability = _reliabilityController.text;
      // final training = _trainingController.text;
      // final mentor = _mentorController.text;
      final otherInfo = _otherInfoController.text;
      // var isWoman//Owned = 1;
      // var fStatement = 1;
      // var collateral = 1;
      // var bPlan = 1;
      // var womenInit = 1;
      // var references = 1;
      // var mentor = 1;
      // var programs = 1;
      final loanData = {
        'amount': amount,
        "survey": {
          // 'womanOwned': isWomanOwned==1,
          // 'howLong': howLong,
          // 'legal': legal,
          // 'industry': finalIndustry,
          // 'loanPurpose': loanPurpose,
          // 'loanUse': loanUse,
          // 'estTime': estTime,
          // 'businessOverview': businessOverview,
          // 'annualRevenue': annualRevenue,
          // 'existingloans': existing==1,
          // 'collateral': collateral==1,
          // 'previouslyAppplied': previouslyAppplied,
          // 'statement': fStatement==1,
          // 'employeeNo': employeeNo,
          // 'financialChallenges': financialChallenges,
          // 'bPlan': bPlan==1,
          // 'competitor': competitor,
          // 'women': womenInit==1,
          // 'marketing': marketing,
          // 'reliability': references==1,
          // 'training': programs==1,
          // 'mentor': mentor==1,
          // 'otherInfo': otherInfo,
        }
      };
      _apiServices
          .applyloan(loanData, widget.token, widget.userId)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        if (value.status == 'OK') {
          // var
          // storeHasLoan();
          _successDialog('Loan Application Submitted Successfully');
          debugPrint('tmessage is.......${value.message.toString()}');
        } else if (value.status == 'BAD_REQUEST') {
          _showDialog('${value.message.toString()}');
        }
      });

      // _amountController.clear();
    }
  }

  void _showDialog(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(children: [
                  const SizedBox(
                    height: 24,
                  ),
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 50,
                    color: Color(0xffed39ca),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(message),
                  const SizedBox(
                    height: 24,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // push(MaterialPageRoute(
                        // builder: (context) => Homescreen()));
                      },
                      child: const Text('Ok'))
                ])),
          );
        });
  }

  void _successDialog(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                height: MediaQuery.of(context).size.height * 0.27,
                child: Column(children: [
                  const SizedBox(
                    height: 24,
                  ),
                  const Icon(
                    Icons.check_circle,
                    size: 50,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(message),
                  const SizedBox(
                    height: 24,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // push(MaterialPageRoute(
                        // builder: (context) => Homescreen()));
                      },
                      child: const Text('Ok'))
                ])),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SheIQ'),
        ),
        backgroundColor: const Color(0xfff6e0e0),

        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(children: <Widget>[
              Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('* All fields are required'),
                      const SizedBox(
                        height: 8,
                      ),
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0.9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const Text(
                                '1. What is your name*'),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  // height: 60,
                                  child: TextFormField(
                                    controller: _amountController,
                                    decoration: InputDecoration(
                                      hintText: 'Answer',
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          16.0, 0, 16.0, 0),

                                      hintStyle: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      //fillColor: Colors.green
                                    ),
                                    validator: (val) {
                                      if (val!.length == 0) {
                                        return "Field cannot be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0.9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const Text(
                                '2. What is your date of birth *'),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  // height: 60,
                                  child: TextFormField(
                                    controller: _amountController,
                                    decoration: InputDecoration(
                                      hintText: 'Answer',
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          16.0, 0, 16.0, 0),

                                      hintStyle: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      //fillColor: Colors.green
                                    ),
                                    validator: (val) {
                                      if (val!.length == 0) {
                                        return "Field cannot be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0.9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const Text(
                                '3. What is your Nationality*'),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  // height: 60,
                                  child: TextFormField(
                                    controller: _amountController,
                                    decoration: InputDecoration(
                                      hintText: 'Answer',
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          16.0, 0, 16.0, 0),

                                      hintStyle: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      //fillColor: Colors.green
                                    ),
                                    validator: (val) {
                                      if (val!.length == 0) {
                                        return "Field cannot be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0.9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const Text(
                                '4. What is your Identification Number, eg passport, or ID card Number*'),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  // height: 60,
                                  child: TextFormField(
                                    controller: _amountController,
                                    decoration: InputDecoration(
                                      hintText: 'Answer',
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          16.0, 0, 16.0, 0),

                                      hintStyle: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      //fillColor: Colors.green
                                    ),
                                    validator: (val) {
                                      if (val!.length == 0) {
                                        return "Field cannot be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0.9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const Text(
                                '5. What is your Residential Address?*'),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  // height: 60,
                                  child: TextFormField(
                                    controller: _amountController,
                                    decoration: InputDecoration(
                                      hintText: 'Answer',
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          16.0, 0, 16.0, 0),

                                      hintStyle: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      //fillColor: Colors.green
                                    ),
                                    validator: (val) {
                                      if (val!.length == 0) {
                                        return "Field cannot be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0.9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const Text(
                                '6. Your Phone Number*'),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  // height: 60,
                                  child: TextFormField(
                                    controller: _amountController,
                                    decoration: InputDecoration(
                                      hintText: 'Answer',
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          16.0, 0, 16.0, 0),

                                      hintStyle: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      //fillColor: Colors.green
                                    ),
                                    validator: (val) {
                                      if (val!.length == 0) {
                                        return "Field cannot be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0.9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const Text(
                                '7. What is your email Address? *'),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  // height: 60,
                                  child: TextFormField(
                                    controller: _amountController,
                                    decoration: InputDecoration(
                                      hintText: 'Answer',
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          16.0, 0, 16.0, 0),

                                      hintStyle: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      //fillColor: Colors.green
                                    ),
                                    validator: (val) {
                                      if (val!.length == 0) {
                                        return "Field cannot be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0.9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const Text(
                                '8. What is your Employment Status*'),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  // height: 60,
                                  child: TextFormField(
                                    controller: _amountController,
                                    decoration: InputDecoration(
                                      hintText: 'Answer',
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          16.0, 0, 16.0, 0),

                                      hintStyle: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      //fillColor: Colors.green
                                    ),
                                    validator: (val) {
                                      if (val!.length == 0) {
                                        return "Field cannot be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0.9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const Text(
                                '9. In the last year, how many loans has your household taken ?*'),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  // height: 60,
                                  child: TextFormField(
                                    controller: _amountController,
                                    decoration: InputDecoration(
                                      hintText: 'Answer',
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          16.0, 0, 16.0, 0),

                                      hintStyle: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      //fillColor: Colors.green
                                    ),
                                    validator: (val) {
                                      if (val!.length == 0) {
                                        return "Field cannot be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0.9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const Text(
                                '10. For what purpose was the loan taken?'),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  // height: 60,
                                  child: TextFormField(
                                    controller: _amountController,
                                    decoration: InputDecoration(
                                      hintText: 'Answer',
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          16.0, 0, 16.0, 0),

                                      hintStyle: const TextStyle(
                                          fontSize: 13, color: Colors.grey),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                      //fillColor: Colors.green
                                    ),
                                    validator: (val) {
                                      if (val!.length == 0) {
                                        return "Field cannot be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      Card(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 0.9,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 30, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(),
                                    text:
                                    "11. From who was the loan taken From ?",
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '*',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                CheckboxListTile(
                                  title: const Text('Family Member'),
                                  value: selectedCategories2
                                      .contains("Family Member"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("Family Member");
                                      } else {
                                        selectedCategories2
                                            .remove("Family Member");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('Commercial Bank'),
                                  value: selectedCategories2
                                      .contains("Commercial Bank"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("Commercial Bank");
                                      } else {
                                        selectedCategories2
                                            .remove("Commercial Bank");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title:
                                  const Text('Micro Finance Institutions'),
                                  value: selectedCategories2
                                      .contains("Micro Finance Institutions"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2
                                            .add("Micro Finance Institutions");
                                      } else {
                                        selectedCategories2.remove(
                                            "Micro Finance Institutions");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('Cooperative'),
                                  value: selectedCategories2
                                      .contains("Cooperative"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2
                                            .add("Cooperative");
                                      } else {
                                        selectedCategories2
                                            .remove("Cooperative");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('Self Help group'),
                                  value: selectedCategories2
                                      .contains("Self Help group"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2
                                            .add("Self Help group");
                                      } else {
                                        selectedCategories2
                                            .remove("Self Help group");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title:
                                  const Text('Finance Company'),
                                  value: selectedCategories2
                                      .contains("Finance Company"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2
                                            .add("Finance Company");
                                      } else {
                                        selectedCategories2.remove(
                                            "Finance Company");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title:
                                  const Text('Friend'),
                                  value: selectedCategories2
                                      .contains("Friend"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2
                                            .add("Friend");
                                      } else {
                                        selectedCategories2.remove(
                                            "Friend");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text(
                                      'Provident Fund'),
                                  value: selectedCategories2.contains(
                                      "Provident Fund"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add(
                                            "Provident Fund");
                                      } else {
                                        selectedCategories2.remove(
                                            "Provident Fund");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text(
                                      'Others'),
                                  value: selectedCategories2.contains(
                                      "Provident Fund"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add(
                                            "Provident Fund");
                                      } else {
                                        selectedCategories2.remove(
                                            "Provident Fund");
                                      }
                                    });
                                  },
                                ),

                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: TextFormField(
                                      controller: _industryController,
                                      validator: (value) => isOtherEnabled2
                                          ? value!.isEmpty
                                          ? "this field is required"
                                          : null
                                          : null,
                                      enabled: isOtherEnabled,
                                      decoration: const InputDecoration(
                                        labelText: 'Enter others here',
                                        labelStyle: TextStyle(
                                          color: Colors.black,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFF6200EE)),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          )),
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0.9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    '12. Who in the household decided to take this loan? *'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      // height: 60,
                                      child: TextFormField(
                                        controller: _amountController,
                                        decoration: InputDecoration(
                                          hintText: 'Answer',
                                          contentPadding: const EdgeInsets.fromLTRB(
                                              16.0, 0, 16.0, 0),

                                          hintStyle: const TextStyle(
                                              fontSize: 13, color: Colors.grey),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                          ),
                                          //fillColor: Colors.green
                                        ),
                                        validator: (val) {
                                          if (val!.length == 0) {
                                            return "Field cannot be empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        keyboardType: TextInputType.text,
                                        style: const TextStyle(
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0.9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    '13. How long ago was the loan taken out. (In hours, days, months or year)? *'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      // height: 60,
                                      child: TextFormField(
                                        controller: _amountController,
                                        decoration: InputDecoration(
                                          hintText: 'Answer',
                                          contentPadding: const EdgeInsets.fromLTRB(
                                              16.0, 0, 16.0, 0),

                                          hintStyle: const TextStyle(
                                              fontSize: 13, color: Colors.grey),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                          ),
                                          //fillColor: Colors.green
                                        ),
                                        validator: (val) {
                                          if (val!.length == 0) {
                                            return "Field cannot be empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        keyboardType: TextInputType.text,
                                        style: const TextStyle(
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0.9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    '13. Do you or anyone in your household have a bank account ? *'),
                                const SizedBox(
                                  height: 8,
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.only(left: 0),
                                  title: Text(
                                    'Yes',
                                    style:
                                    Theme.of(context).textTheme.subtitle1,
                                  ),
                                  leading: Radio(
                                    value: 1,
                                    groupValue: isAnyoneHavingBankAccount,
                                    onChanged: (int? value) {
                                      setState(
                                            () {
                                          isAnyoneHavingBankAccount = value!;
                                        },
                                      );
                                    },
                                  ),
                                ),
                                ListTile(
                                  contentPadding:
                                  const EdgeInsets.only(left: 0, top: 0),
                                  title: Text(
                                    'No',
                                    style:
                                    Theme.of(context).textTheme.subtitle1,
                                  ),
                                  leading: Radio(
                                    value: 0,
                                    groupValue: isAnyoneHavingBankAccount,
                                    onChanged: (int? value) {
                                      setState(() {
                                        isAnyoneHavingBankAccount = value!;
                                      });
                                    },
                                  ),
                                )
                              ]),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0.9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    '14. Do you have ATM Card ? *'),
                                const SizedBox(
                                  height: 8,
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.only(left: 0),
                                  title: Text(
                                    'Yes',
                                    style:
                                    Theme.of(context).textTheme.subtitle1,
                                  ),
                                  leading: Radio(
                                    value: 1,
                                    groupValue: isHavingAtmCard,
                                    onChanged: (int? value) {
                                      setState(
                                            () {
                                              isHavingAtmCard = value!;
                                        },
                                      );
                                    },
                                  ),
                                ),
                                ListTile(
                                  contentPadding:
                                  const EdgeInsets.only(left: 0, top: 0),
                                  title: Text(
                                    'No',
                                    style:
                                    Theme.of(context).textTheme.subtitle1,
                                  ),
                                  leading: Radio(
                                    value: 0,
                                    groupValue: isHavingAtmCard,
                                    onChanged: (int? value) {
                                      setState(() {
                                        isHavingAtmCard = value!;
                                      });
                                    },
                                  ),
                                )
                              ]),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0.9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    '15. Do you have insurance policy ? *'),
                                const SizedBox(
                                  height: 8,
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.only(left: 0),
                                  title: Text(
                                    'Yes',
                                    style:
                                    Theme.of(context).textTheme.subtitle1,
                                  ),
                                  leading: Radio(
                                    value: 1,
                                    groupValue: isHavingInsurancePolicy,
                                    onChanged: (int? value) {
                                      setState(
                                            () {
                                              isHavingInsurancePolicy = value!;
                                        },
                                      );
                                    },
                                  ),
                                ),
                                ListTile(
                                  contentPadding:
                                  const EdgeInsets.only(left: 0, top: 0),
                                  title: Text(
                                    'No',
                                    style:
                                    Theme.of(context).textTheme.subtitle1,
                                  ),
                                  leading: Radio(
                                    value: 0,
                                    groupValue: isHavingInsurancePolicy,
                                    onChanged: (int? value) {
                                      setState(() {
                                        isHavingInsurancePolicy = value!;
                                      });
                                    },
                                  ),
                                )
                              ]),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0.9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    '16. Do you Have a business ? *'),
                                const SizedBox(
                                  height: 8,
                                ),
                                ListTile(
                                  contentPadding: const EdgeInsets.only(left: 0),
                                  title: Text(
                                    'Yes',
                                    style:
                                    Theme.of(context).textTheme.subtitle1,
                                  ),
                                  leading: Radio(
                                    value: 1,
                                    groupValue: isHavingBusiness,
                                    onChanged: (int? value) {
                                      setState(
                                            () {
                                              isHavingBusiness = value!;
                                        },
                                      );
                                    },
                                  ),
                                ),
                                ListTile(
                                  contentPadding:
                                  const EdgeInsets.only(left: 0, top: 0),
                                  title: Text(
                                    'No',
                                    style:
                                    Theme.of(context).textTheme.subtitle1,
                                  ),
                                  leading: Radio(
                                    value: 0,
                                    groupValue: isHavingBusiness,
                                    onChanged: (int? value) {
                                      setState(() {
                                        isHavingBusiness = value!;
                                      });
                                    },
                                  ),
                                )
                              ]),
                        ),
                      ),
                      Card(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 0.9,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 30, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(),
                                    text:
                                    "17. What type of business do you have ?",
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '*',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                CheckboxListTile(
                                  title: const Text('Start a completely new enterprise'),
                                  value: selectedCategories2
                                      .contains("Start a completely new enterprise"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("Start a completely new enterprise");
                                      } else {
                                        selectedCategories2
                                            .remove("Start a completely new enterprise");
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                CheckboxListTile(
                                  title: const Text('Creation by an existing enterprise (affiliate)'),
                                  value: selectedCategories2
                                      .contains("Creation by an existing enterprise (affiliate)"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("Creation by an existing enterprise (affiliate)");
                                      } else {
                                        selectedCategories2
                                            .remove("Creation by an existing enterprise (affiliate)");
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                CheckboxListTile(
                                  title:
                                  const Text('Restart a business after dormancy of over 2 years'),
                                  value: selectedCategories2
                                      .contains("Restart a business after dormancy of over 2 years"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2
                                            .add("Restart a business after dormancy of over 2 years");
                                      } else {
                                        selectedCategories2.remove(
                                            "Restart a business after dormancy of over 2 years");
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                CheckboxListTile(
                                  title: const Text('Take-over a purchase of another enterprise'),
                                  value: selectedCategories2
                                      .contains("Take-over a purchase of another enterprise"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2
                                            .add("Take-over a purchase of another enterprise");
                                      } else {
                                        selectedCategories2
                                            .remove("Take-over a purchase of another enterprise");
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          )),
                      Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0.9,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    '18. How long has your business been in operation? *'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      // height: 60,
                                      child: TextFormField(
                                        controller: _amountController,
                                        decoration: InputDecoration(
                                          hintText: 'Answer',
                                          contentPadding: const EdgeInsets.fromLTRB(
                                              16.0, 0, 16.0, 0),

                                          hintStyle: const TextStyle(
                                              fontSize: 13, color: Colors.grey),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                          ),
                                          //fillColor: Colors.green
                                        ),
                                        validator: (val) {
                                          if (val!.length == 0) {
                                            return "Amount cannot be empty";
                                          } else {
                                            return null;
                                          }
                                        },
                                        keyboardType: TextInputType.text,
                                        style: const TextStyle(
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                      Card(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 0.9,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 30, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(),
                                    text:
                                    "19. What industry is your business in ?",
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '*',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                CheckboxListTile(
                                  title: const Text('Agribusiness'),
                                  value: selectedCategories2
                                      .contains("Agribusiness"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("Agribusiness");
                                      } else {
                                        selectedCategories2
                                            .remove("Agribusiness");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('Beauty'),
                                  value: selectedCategories2
                                      .contains("Beauty"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("Beauty");
                                      } else {
                                        selectedCategories2
                                            .remove("Beauty");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('ICT and communications'),
                                  value: selectedCategories2
                                      .contains("ICT and communications"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("ICT and communications");
                                      } else {
                                        selectedCategories2
                                            .remove("ICT and communications");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('construction'),
                                  value: selectedCategories2
                                      .contains("construction"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("construction");
                                      } else {
                                        selectedCategories2
                                            .remove("construction");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('Energy'),
                                  value: selectedCategories2
                                      .contains("Energy"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("Energy");
                                      } else {
                                        selectedCategories2
                                            .remove("Energy");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('Financial services'),
                                  value: selectedCategories2
                                      .contains("Financial services"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("Financial services");
                                      } else {
                                        selectedCategories2
                                            .remove("Financial services");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('Media and marketing'),
                                  value: selectedCategories2
                                      .contains("Media and marketing"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("Media and marketing");
                                      } else {
                                        selectedCategories2
                                            .remove("Media and marketing");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('Non-profit'),
                                  value: selectedCategories2
                                      .contains("Non-profit"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("Non-profit");
                                      } else {
                                        selectedCategories2
                                            .remove("Non-profit");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('Property'),
                                  value: selectedCategories2
                                      .contains("Property"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("Property");
                                      } else {
                                        selectedCategories2
                                            .remove("Property");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('Retail'),
                                  value: selectedCategories2
                                      .contains("Retail"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("Retail");
                                      } else {
                                        selectedCategories2
                                            .remove("Retail");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('others'),
                                  value: selectedCategories2
                                      .contains("others"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("others");
                                      } else {
                                        selectedCategories2
                                            .remove("others");
                                      }
                                    });
                                  },
                                ),

                              ],
                            ),
                          )),
                      Card(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 0.9,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 30, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(),
                                    text:
                                    "20. What type of loans do you have for your business ?",
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '*',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(color: Colors.red)),
                                    ],
                                  ),
                                ),
                                CheckboxListTile(
                                  title: const Text('Working capital'),
                                  value: selectedCategories2
                                      .contains("Working capital"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("Working capital");
                                      } else {
                                        selectedCategories2
                                            .remove("Working capital");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('Overdraft'),
                                  value: selectedCategories2
                                      .contains("Overdraft"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("Overdraft");
                                      } else {
                                        selectedCategories2
                                            .remove("Overdraft");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('Equipment Leasing'),
                                  value: selectedCategories2
                                      .contains("Equipment Leasing"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("Equipment Leasing");
                                      } else {
                                        selectedCategories2
                                            .remove("Equipment Leasing");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('Commercial Mortgage'),
                                  value: selectedCategories2
                                      .contains("Commercial Mortgage"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("Commercial Mortgage");
                                      } else {
                                        selectedCategories2
                                            .remove("Commercial Mortgage");
                                      }
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('Others'),
                                  value: selectedCategories2
                                      .contains("Others"),
                                  activeColor: const Color(0xffed39ca),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value!) {
                                        selectedCategories2.add("Others");
                                      } else {
                                        selectedCategories2
                                            .remove("Others");
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          )),





                      const SizedBox(height: 16.0),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        // margin: EdgeInsets.only(
                        //     left: MediaQuery.of(context).size.width *
                        //         0.1),
                        // right: MediaQuery.of(context).size.width * 0.3),
                        child: _isLoading
                            ? SpinKitCircle(
                          color: Color(0xffed39ca),
                        )
                            : OutlinedButton(
                          onPressed: () {
                            _submitForm();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(
                                Color(0xffed39ca)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(50.0)),
                            ),
                          ),
                          // style: ,
                          child: const Text('Submit', style:TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      )
                    ],
                  )),
            ])));
  }
}
