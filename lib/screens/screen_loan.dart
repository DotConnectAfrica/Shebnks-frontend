import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:she_banks/screens/screen_home.dart';
import 'package:she_banks/screens/screen_she_funds.dart';

import '../api_services/api_services.dart';
import '../utils/universal_methods.dart';
import 'colors.dart';

class LoansPage extends StatefulWidget {
  final token;
  final fName;
  final userId;

  LoansPage({required this.token, required this.fName, required this.userId});

  @override
  _LoansPageState createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
  List<String> selectedCategories2 = [];
  var isOtherEnabled = false;
  var isOtherEnabled2 = false;
  var isWomanOwned = 1;
  var fStatement = 1;
  var collateral = 1;
  var bPlan = 1;
  var womenInit = 1;
  var references = 1;
  var mentor = 1;
  var programs = 1;
  var existing = 1;
  var user = "";
  @override
  void initState() {
    super.initState();
    useUser();
    // Call useUser during widget initialization
    // _hasIq == false
    //     ? _showDialog("Please fill in the sheIq section before proceeding")
    //     : null;
  }

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _apiServices = ApiServices();

  storeHasLoan() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('hasExistingLoan', true);
  }

  Future<String> getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var mPhone = prefs.getString("PhoneNumber");
    user = mPhone!.replaceAll('+', '');
    return user;
  }

  var _hasIq = false;

  void useUser() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    user = await getPhone();
    _hasIq = _prefs.getBool("hasSheiq")!;

    // Now, you can use the user variable as needed

    // Any code that depends on the user variable should be placed here
  }

// '
//   1What is your full name and contact information?
//   2Are you a woman-owned business?
//   3How long have you been operating your business?
//   4What is the legal structure of your business (sole proprietorship, partnership, LLC, etc.)?
//   5What is the industry or sector of your business?
//   6How much funding are you seeking for your business?
//   7What is the purpose of the loan? (e.g., working capital, equipment purchase, expansion, etc.)
//   8How will the loan funds be used to benefit your business?
//   9What is your estimated timeline for repayment of the loan?
//   10Can you provide a brief overview of your business, including its products or services?
//   11What is your business's annual revenue and net profit (if applicable)?
//   12Do you have any existing loans or outstanding debts related to your business?
//   13Are you willing to provide collateral or a personal guarantee for the loan?
//   14Have you previously applied for a business loan? If yes, please provide details.
//   15Can you provide financial statements for your business, such as income statements and balance sheets?
//   16How many employees do you currently have, and do you plan to hire additional staff with the loan funds?
//   17Are you currently experiencing any financial challenges or legal issues related to your business?
//   18Do you have a business plan or strategy for growth and sustainability?
//   19What sets your business apart from competitors in your industry?
//   20Are you involved in any women-focused or community initiatives?
//   21How do you plan to market and promote your business in the future?
//   22Can you provide references from clients, suppliers, or partners who can vouch for your business's reliability?
//   23Have you participated in any business or entrepreneurship training programs?
//   24Are you willing to work with a business mentor or advisor, if offered?
//   25Is there any additional information you would like to provide to support your loan application?'
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

  // Assuming you have all your TextEditingController instances declared

  void clearAllControllers() {
    _amountController.clear();
    _womanOwnedController.clear();
    _howLongController.clear();
    _legalController.clear();
    _industryController.clear();
    _loanPurposeController.clear();
    _loanUseController.clear();
    _estimatedTimeController.clear();
    _businessOverviewController.clear();
    _annualRevenueTimeController.clear();
    _existingLoansController.clear();
    _collateralController.clear();
    _previouslyAppliedController.clear();
    _statementController.clear();
    _employeeNoController.clear();
    _financialChallengesController.clear();
    _bplanController.clear();
    _competitorController.clear();
    _womenController.clear();
    _marketingController.clear();
    _reliabilityController.clear();
    _trainingController.clear();
    _mentorController.clear();
    _otherInfoController.clear();
  }

// Call the clearAllControllers() function after submitting the form or as needed to clear the text in all controllers.

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
      final phone = user;

      final loan = {
        "amount": double.parse(amount),
        "survey": {
          "womanOwned": isWomanOwned == 1,
          "howLong": int.parse(howLong),
          "legal": legal,
          "industry": finalIndustry.last,
          "loanPurpose": loanPurpose,
          "loanUse": loanUse,
          "estTime": estTime,
          "businessOverview": businessOverview,
          "annualRevenue": annualRevenue,
          "existingLoans": existing == 1,
          "collateral": collateral == 1,
          "previouslyApplied": previouslyAppplied,
          "statement": fStatement == 1,
          "employeeNo": int.parse(employeeNo),
          "financialChallenges": financialChallenges,
          "competitor": competitor,
          "women": womenInit == 1,
          "marketing": marketing,
          "reliability": references == 1,
          "training": programs == 1,
          "mentor": mentor == 1,
          "otherInfo": otherInfo
        },
        "user": phone
      };
      _apiServices.applyloan(loan).then((value) {
        print("applying loan");
        print(value.status);
        setState(() {
          _isLoading = false;
        });
        try {
          if (value.status == 200) {
            // var
            // storeHasLoan();
            _successDialog('Loan Application Submitted Successfully');
            clearAllControllers();
            debugPrint('tmessage is.......${value.message.toString()}');
          } else if (value.status != 200) {
            _showDialog('${value.message.toString()}');
            clearAllControllers();
          } else {
            _showDialog('${value.message.toString()}');
            clearAllControllers();
          }
        } catch (e) {
          _showDialog('An error occurred: $e');
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
// Call the clearAllControllers() function after submitting the form or as needed to clear the text in all controllers.

    return Scaffold(
        appBar: AppBar(
          title: const Text('Apply SheLoan'),
        ),
        backgroundColor: const Color(0xfff6e0e0),
        body: _hasIq == false
            ? Card(
                color: Colors.pink[50], // Light pink color
                margin: const EdgeInsets.all(20.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Hey Please take the sheiq before you can apply for loan. Navigate to home screen.Fill in the sheI questions then submit.After that we can let you apply for the loan.Thank you",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : SingleChildScrollView(
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
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 30),
                              child: Column(children: [
                                const Text(
                                    '1. How much funding are you seeking for your business (Limit KES 50,000)*'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: TextFormField(
                                        controller: _amountController,
                                        decoration: InputDecoration(
                                          hintText: 'Amount',
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
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
                                          // fillColor: Colors.green
                                        ),
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Amount cannot be empty";
                                          }
                                          // Convert the input to a numeric value and check the limit
                                          final numericValue =
                                              double.tryParse(val);
                                          if (numericValue == null ||
                                              numericValue <= 0 ||
                                              numericValue > 50000) {
                                            return "Enter a valid amount between 1 and 50,000 KES";
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType
                                            .number, // Use TextInputType.number to show a numeric keyboard
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
                                    Row(
                                      children: [
                                        Text(
                                          "2. Are you a woman-owned business?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "*",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(color: Colors.red),
                                        )
                                      ],
                                    ),
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.only(left: 0),
                                      title: Text(
                                        'Yes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 1,
                                        groupValue: isWomanOwned,
                                        onChanged: (int? value) {
                                          setState(
                                            () {
                                              isWomanOwned = value!;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: 0, top: 0),
                                      title: Text(
                                        'No',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 0,
                                        groupValue: isWomanOwned,
                                        onChanged: (int? value) {
                                          setState(() {
                                            isWomanOwned = value!;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              )),
                          // Card(
                          //   margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          //   elevation: 0.9,
                          //   shape: const RoundedRectangleBorder(
                          //       borderRadius:
                          //       BorderRadius.all(Radius.circular(10.0))),
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(
                          //         left: 20, right: 20, top: 30, bottom: 30),
                          //     child: Column(children: [
                          //       const Text('Are you a woman-owned business?'),
                          //       const SizedBox(
                          //         height: 8,
                          //       ),
                          //       Row(
                          //         mainAxisSize: MainAxisSize.min,
                          //         children: [
                          //           Flexible(
                          //             child: TextFormField(
                          //               controller: _womanOwnedController,
                          //               decoration: InputDecoration(
                          //                 hintText: 'Member',
                          //                 contentPadding:
                          //                 const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                          //
                          //                 hintStyle: const TextStyle(
                          //                     fontSize: 13, color: Colors.grey),
                          //                 focusedBorder: OutlineInputBorder(
                          //                   borderRadius: BorderRadius.circular(8.0),
                          //                   borderSide: const BorderSide(
                          //                     color: Colors.grey,
                          //                   ),
                          //                 ),
                          //                 enabledBorder: OutlineInputBorder(
                          //                   borderRadius: BorderRadius.circular(8.0),
                          //                   borderSide: const BorderSide(
                          //                     color: Colors.grey,
                          //                     width: 1.0,
                          //                   ),
                          //                 ),
                          //                 //fillColor: Colors.green
                          //               ),
                          //               validator: (val) {
                          //                 if (val!.length == 0) {
                          //                   return "Field Cannot be empty";
                          //                 } else {
                          //                   return null;
                          //                 }
                          //               },
                          //               keyboardType: TextInputType.text,
                          //               style: const TextStyle(
                          //                 // fontFamily: "Poppins",
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ]),
                          //   ),
                          // ),
                          Card(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            elevation: 0.9,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 30),
                              child: Column(children: [
                                const Text(
                                    '3. How long have you been operating your business (In months)?'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  Flexible(
                                    child: TextFormField(
                                      controller: _howLongController,
                                      decoration: InputDecoration(
                                        hintText:
                                            'Operations of the business (in months)',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
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
                                        // fillColor: Colors.green
                                      ),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Field cannot be empty";
                                        }
                                        // Check if the input is a valid positive integer
                                        final isValidInput = int.tryParse(val);
                                        if (isValidInput == null ||
                                            isValidInput <= 0) {
                                          return "Enter a valid number of months";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType
                                          .number, // Use TextInputType.number to show a numeric keyboard
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                ]),
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
                              child: Column(children: [
                                const Text(
                                    '4. What is the legal structure of your business (sole proprietorship, partnership, LLC, etc.)?'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  Flexible(
                                    child: TextFormField(
                                      controller: _legalController,
                                      decoration: InputDecoration(
                                        hintText: 'Legal structure',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
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
                                ]),
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
                                            "5. Which SDGs are you primarily targeting? (Please fill multiple if necessary) ?",
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
                                      title: const Text('No poverty'),
                                      value: selectedCategories2
                                          .contains("No poverty"),
                                      activeColor: const Color(0xffed39ca),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            selectedCategories2
                                                .add("No poverty");
                                          } else {
                                            selectedCategories2
                                                .remove("No poverty");
                                          }
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: const Text('Zero Hunger'),
                                      value: selectedCategories2
                                          .contains("Zero Hunger"),
                                      activeColor: const Color(0xffed39ca),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            selectedCategories2
                                                .add("Zero Hunger");
                                          } else {
                                            selectedCategories2
                                                .remove("Zero Hunger");
                                          }
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: const Text(
                                          'Good health and wellbeing'),
                                      value: selectedCategories2.contains(
                                          "Good health and wellbeing"),
                                      activeColor: const Color(0xffed39ca),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            selectedCategories2.add(
                                                "Good health and wellbeing");
                                          } else {
                                            selectedCategories2.remove(
                                                "Good health and wellbeing");
                                          }
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: const Text('Quality Education'),
                                      value: selectedCategories2
                                          .contains("Quality Education"),
                                      activeColor: const Color(0xffed39ca),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            selectedCategories2
                                                .add("Quality Education");
                                          } else {
                                            selectedCategories2
                                                .remove("Quality Education");
                                          }
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: const Text('Gender Equality'),
                                      value: selectedCategories2
                                          .contains("Gender Equality"),
                                      activeColor: const Color(0xffed39ca),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            selectedCategories2
                                                .add("Gender Equality");
                                          } else {
                                            selectedCategories2
                                                .remove("Gender Equality");
                                          }
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: const Text(
                                          'Clean water and Sanitation'),
                                      value: selectedCategories2.contains(
                                          "Clean water and Sanitation"),
                                      activeColor: const Color(0xffed39ca),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            selectedCategories2.add(
                                                "Clean water and Sanitation");
                                          } else {
                                            selectedCategories2.remove(
                                                "Clean water and Sanitation");
                                          }
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: const Text(
                                          'Affordable and Clean energy'),
                                      value: selectedCategories2.contains(
                                          "Affordable and Clean energy"),
                                      activeColor: const Color(0xffed39ca),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            selectedCategories2.add(
                                                "Affordable and Clean energy");
                                          } else {
                                            selectedCategories2.remove(
                                                "Affordable and Clean energy");
                                          }
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: const Text(
                                          'Decent work and Economic growth'),
                                      value: selectedCategories2.contains(
                                          "Decent work and Economic growth"),
                                      activeColor: const Color(0xffed39ca),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            selectedCategories2.add(
                                                "Decent work and Economic growth");
                                          } else {
                                            selectedCategories2.remove(
                                                "Decent work and Economic growth");
                                          }
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: const Text(
                                          'Industry,Innovation and Infrastructure'),
                                      value: selectedCategories2.contains(
                                          "Industry,Innovation and Infrastructure"),
                                      activeColor: const Color(0xffed39ca),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            selectedCategories2.add(
                                                "Industry,Innovation and Infrastructure");
                                          } else {
                                            selectedCategories2.remove(
                                                "Industry,Innovation and Infrastructure");
                                          }
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: const Text('Reduced Inequalities'),
                                      value: selectedCategories2
                                          .contains("Reduced Inequalities"),
                                      activeColor: const Color(0xffed39ca),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            selectedCategories2
                                                .add("Reduced Inequalities");
                                          } else {
                                            selectedCategories2
                                                .remove("Reduced Inequalities");
                                          }
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: const Text(
                                          'Sustainable cities and Communities'),
                                      value: selectedCategories2.contains(
                                          "Sustainable cities and Communities"),
                                      activeColor: const Color(0xffed39ca),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            selectedCategories2.add(
                                                "Sustainable cities and Communities");
                                          } else {
                                            selectedCategories2.remove(
                                                "Sustainable cities and Communities");
                                          }
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: const Text(
                                          'Responsible Consumption and Production'),
                                      value: selectedCategories2.contains(
                                          "Responsible Consumption and Production"),
                                      activeColor: const Color(0xffed39ca),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            selectedCategories2.add(
                                                "Responsible Consumption and Production");
                                          } else {
                                            selectedCategories2.remove(
                                                "Responsible Consumption and Production");
                                          }
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: const Text('Climate Action'),
                                      value: selectedCategories2
                                          .contains("Climate Action"),
                                      activeColor: const Color(0xffed39ca),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            selectedCategories2
                                                .add("Climate Action");
                                          } else {
                                            selectedCategories2
                                                .remove("Climate Action");
                                          }
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: const Text(
                                          'Peace,Justice and Strong Institutions'),
                                      value: selectedCategories2.contains(
                                          "Peace,Justice and Strong Institutions"),
                                      activeColor: const Color(0xffed39ca),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          if (value!) {
                                            selectedCategories2.add(
                                                "Peace,Justice and Strong Institutions");
                                          } else {
                                            selectedCategories2.remove(
                                                "Peace,Justice and Strong Institutions");
                                          }
                                        });
                                      },
                                    ),
                                    CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.trailing,
                                      title: const Text('Others'),
                                      value: isOtherEnabled2,
                                      activeColor: const Color(0xffed39ca),
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isOtherEnabled2 = value!;
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
                              child: Column(children: [
                                const Text(
                                    '7. What is the purpose of the loan? (e.g., working capital, equipment purchase, expansion, etc.)'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  Flexible(
                                    child: TextFormField(
                                      controller: _loanPurposeController,
                                      decoration: InputDecoration(
                                        hintText: 'Loan purpose',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
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
                                ]),
                              ]),
                            ),
                          ),
                          // Card(
                          //   margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          //   elevation: 0.9,
                          //   shape: const RoundedRectangleBorder(
                          //       borderRadius:
                          //       BorderRadius.all(Radius.circular(10.0))),
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(
                          //         left: 20, right: 20, top: 30, bottom: 30),
                          //     child: Column(children: [
                          //       const Text(
                          //           'What is the purpose of the loan? (e.g., working capital, equipment purchase, expansion, etc.)'),
                          //       const SizedBox(
                          //         height: 8,
                          //       ),
                          //       Row(mainAxisSize: MainAxisSize.min, children: [
                          //         Flexible(
                          //           child: TextFormField(
                          //             controller: _loanPurposeController,
                          //             decoration: InputDecoration(
                          //               hintText: 'Loan purpose',
                          //               contentPadding:
                          //               const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                          //
                          //               hintStyle: const TextStyle(
                          //                   fontSize: 13, color: Colors.grey),
                          //               focusedBorder: OutlineInputBorder(
                          //                 borderRadius: BorderRadius.circular(8.0),
                          //                 borderSide: const BorderSide(
                          //                   color: Colors.grey,
                          //                 ),
                          //               ),
                          //               enabledBorder: OutlineInputBorder(
                          //                 borderRadius: BorderRadius.circular(8.0),
                          //                 borderSide: const BorderSide(
                          //                   color: Colors.grey,
                          //                   width: 1.0,
                          //                 ),
                          //               ),
                          //               //fillColor: Colors.green
                          //             ),
                          //             validator: (val) {
                          //               if (val!.length == 0) {
                          //                 return "Field cannot be empty";
                          //               } else {
                          //                 return null;
                          //               }
                          //             },
                          //             keyboardType: TextInputType.text,
                          //             style: const TextStyle(
                          //               fontFamily: "Poppins",
                          //             ),
                          //           ),
                          //         ),
                          //       ]),
                          //     ]),
                          //   ),
                          // ),
                          Card(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            elevation: 0.9,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 30),
                              child: Column(children: [
                                const SizedBox(height: 16.0),
                                const Text(
                                    '8. How will the loan funds be used to benefit your business?'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  Flexible(
                                    child: TextFormField(
                                      controller: _loanUseController,
                                      decoration: InputDecoration(
                                        hintText: 'Use of the loan',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
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
                                ]),
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
                              child: Column(children: [
                                const SizedBox(height: 16.0),
                                const Text(
                                    '9. Can you provide a brief overview of your business, including its products or services?'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  Flexible(
                                    child: TextFormField(
                                      controller: _businessOverviewController,
                                      decoration: InputDecoration(
                                        hintText: 'Business Overview',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
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
                                ]),
                              ]),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            elevation: 0.9,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 30),
                              child: Column(children: [
                                const SizedBox(height: 16.0),
                                const Text(
                                    '10. What is your business\'s annual revenue and net profit (if applicable)?'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  Flexible(
                                    child: TextFormField(
                                      controller: _annualRevenueTimeController,
                                      decoration: InputDecoration(
                                        hintText: 'Annual Revenue',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
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
                                        // fillColor: Colors.green
                                      ),
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Field cannot be empty";
                                        }
                                        // Check if the input is a valid numeric value (e.g., a double or int)
                                        final numericValue =
                                            double.tryParse(val);
                                        if (numericValue == null ||
                                            numericValue < 0) {
                                          return "Enter a valid annual revenue";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType
                                          .number, // Use TextInputType.number to show a numeric keyboard
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                ]),
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
                                    Row(
                                      children: [
                                        Text(
                                          "11. Do you have any existing loans or \n outstanding debts related \n to your business?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "*",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(color: Colors.red),
                                        )
                                      ],
                                    ),
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.only(left: 0),
                                      title: Text(
                                        'Yes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 1,
                                        groupValue: existing,
                                        onChanged: (int? value) {
                                          setState(
                                            () {
                                              existing = value!;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: 0, top: 0),
                                      title: Text(
                                        'No',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 0,
                                        groupValue: existing,
                                        onChanged: (int? value) {
                                          setState(() {
                                            collateral = value!;
                                          });
                                        },
                                      ),
                                    )
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
                                    Row(
                                      children: [
                                        Text(
                                          "12. Are you willing to provide \n collateral or a personal guarantee \n for the loan?' ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "*",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(color: Colors.red),
                                        )
                                      ],
                                    ),
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.only(left: 0),
                                      title: Text(
                                        'Yes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 1,
                                        groupValue: collateral,
                                        onChanged: (int? value) {
                                          setState(
                                            () {
                                              collateral = value!;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: 0, top: 0),
                                      title: Text(
                                        'No',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 0,
                                        groupValue: collateral,
                                        onChanged: (int? value) {
                                          setState(() {
                                            collateral = value!;
                                          });
                                        },
                                      ),
                                    )
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
                                    Row(
                                      children: [
                                        Text(
                                          "13. Have you previously \n  applied for a business loan?  ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "*",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(color: Colors.red),
                                        )
                                      ],
                                    ),
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.only(left: 0),
                                      title: Text(
                                        'Yes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 1,
                                        groupValue: isWomanOwned,
                                        onChanged: (int? value) {
                                          setState(
                                            () {
                                              isWomanOwned = value!;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: 0, top: 0),
                                      title: Text(
                                        'No',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 0,
                                        groupValue: isWomanOwned,
                                        onChanged: (int? value) {
                                          setState(() {
                                            isWomanOwned = value!;
                                          });
                                        },
                                      ),
                                    )
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
                                    Row(
                                      children: [
                                        Text(
                                          "14. Can you provide financial \n statements for your business, \n such as income statements \n and balance sheets?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "*",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(color: Colors.red),
                                        )
                                      ],
                                    ),
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.only(left: 0),
                                      title: Text(
                                        'Yes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 1,
                                        groupValue: fStatement,
                                        onChanged: (int? value) {
                                          setState(
                                            () {
                                              fStatement = value!;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: 0, top: 0),
                                      title: Text(
                                        'No',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 0,
                                        groupValue: fStatement,
                                        onChanged: (int? value) {
                                          setState(() {
                                            fStatement = value!;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              )),

                          Card(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            elevation: 0.9,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 30),
                              child: Column(children: [
                                const SizedBox(height: 16.0),
                                const Text(
                                    '15. How many employees do you currently have, and do you plan to hire additional staff with the loan funds?'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  Flexible(
                                    child: TextFormField(
                                      controller: _employeeNoController,
                                      decoration: InputDecoration(
                                        hintText: 'Number of Employees',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
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
                                        // fillColor: Colors.green
                                      ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Field cannot be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType
                                          .number, // Use TextInputType.number to show a numeric keyboard
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                ]),
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
                              child: Column(children: [
                                const SizedBox(height: 16.0),
                                const Text(
                                    '16. Are you currently experiencing any financial challenges or legal issues related to your business? Elaborate each '),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  Flexible(
                                    child: TextFormField(
                                      controller:
                                          _financialChallengesController,
                                      decoration: InputDecoration(
                                        hintText: 'Any financil challenges',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
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
                                ]),
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
                                    Row(
                                      children: [
                                        Text(
                                          "17. Do you have a business plan or \n strategy for growth and sustainability? ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "*",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(color: Colors.red),
                                        )
                                      ],
                                    ),
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.only(left: 0),
                                      title: Text(
                                        'Yes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 1,
                                        groupValue: bPlan,
                                        onChanged: (int? value) {
                                          setState(
                                            () {
                                              bPlan = value!;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: 0, top: 0),
                                      title: Text(
                                        'No',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 0,
                                        groupValue: bPlan,
                                        onChanged: (int? value) {
                                          setState(() {
                                            bPlan = value!;
                                          });
                                        },
                                      ),
                                    )
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
                              child: Column(children: [
                                const SizedBox(height: 16.0),
                                const Text(
                                    '18. What sets your business apart from competitors in your industry?'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  Flexible(
                                    child: TextFormField(
                                      controller: _competitorController,
                                      decoration: InputDecoration(
                                        hintText: 'Competitor Strategy',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
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
                                ]),
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
                                    Row(
                                      children: [
                                        Text(
                                          "19. Are you involved in any \n women-focused or \n community initiatives?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "*",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(color: Colors.red),
                                        )
                                      ],
                                    ),
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.only(left: 0),
                                      title: Text(
                                        'Yes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 1,
                                        groupValue: womenInit,
                                        onChanged: (int? value) {
                                          setState(
                                            () {
                                              womenInit = value!;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: 0, top: 0),
                                      title: Text(
                                        'No',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 0,
                                        groupValue: womenInit,
                                        onChanged: (int? value) {
                                          setState(() {
                                            womenInit = value!;
                                          });
                                        },
                                      ),
                                    )
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
                                    Row(
                                      children: [
                                        Text(
                                          "20. Can you provide references from \n clients,  suppliers, or partners who \n can vouch  for your  business\'s \n reliability?",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(),
                                        ),
                                        Text(
                                          "*",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(color: Colors.red),
                                        )
                                      ],
                                    ),
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.only(left: 0),
                                      title: Text(
                                        'Yes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 1,
                                        groupValue: references,
                                        onChanged: (int? value) {
                                          setState(
                                            () {
                                              references = value!;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: 0, top: 0),
                                      title: Text(
                                        'No',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 0,
                                        groupValue: references,
                                        onChanged: (int? value) {
                                          setState(() {
                                            references = value!;
                                          });
                                        },
                                      ),
                                    )
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
                                    const Text(
                                        "21. Have you participated in any business or entrepreneurship training programs?"),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.only(left: 0),
                                      title: Text(
                                        'Yes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 1,
                                        groupValue: programs,
                                        onChanged: (int? value) {
                                          setState(
                                            () {
                                              programs = value!;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: 0, top: 0),
                                      title: Text(
                                        'No',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 0,
                                        groupValue: programs,
                                        onChanged: (int? value) {
                                          setState(() {
                                            programs = value!;
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
                              child: Column(children: [
                                const SizedBox(height: 16.0),
                                const Text(
                                    '22. How do you plan to market and promote your business in the future?'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  Flexible(
                                    child: TextFormField(
                                      controller: _marketingController,
                                      decoration: InputDecoration(
                                        hintText: 'Marketing Strategy',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
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
                                ]),
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
                                    const Text(
                                        "23. Are you willing to work with a business mentor or advisor, if offered?"),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    ListTile(
                                      contentPadding:
                                          const EdgeInsets.only(left: 0),
                                      title: Text(
                                        'Yes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 1,
                                        groupValue: mentor,
                                        onChanged: (int? value) {
                                          setState(
                                            () {
                                              mentor = value!;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          left: 0, top: 0),
                                      title: Text(
                                        'No',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      leading: Radio(
                                        value: 0,
                                        groupValue: mentor,
                                        onChanged: (int? value) {
                                          setState(() {
                                            mentor = value!;
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
                              child: Column(children: [
                                const SizedBox(height: 16.0),
                                const Text(
                                    '24. Is there any additional information you would like to provide to support your loan application?'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  Flexible(
                                    child: TextFormField(
                                      controller: _otherInfoController,
                                      decoration: InputDecoration(
                                        hintText: 'Other Info',
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
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
                                          // fontFamily: "Poppins",
                                          ),
                                    ),
                                  ),
                                ]),
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
                                children: [
                                  const Text(
                                      '25. Attach the following documents either as .docx, pdf,  or png'),

                                  FormBuilderFilePicker(
                                    name: 'businessPlan',
                                    decoration: const InputDecoration(
                                        labelText: 'Business plan'),
                                    // maxFiles: 3, // Maximum number of attachments allowed
                                    previewImages:
                                        true, // Display image previews
                                    onChanged: (value) {
                                      print(value);
                                    },
                                    // selectorButtonOnErrorText: 'Add attachments',
                                  ),

                                  FormBuilderFilePicker(
                                    name: 'financialStatement',
                                    decoration: const InputDecoration(
                                        labelText: 'Financial Statement'),
                                    // maxFiles: 3, // Maximum number of attachments allowed
                                    previewImages:
                                        true, // Display image previews
                                    onChanged: (value) {
                                      print(value);
                                    },
                                    // selectorButtonOnErrorText: 'Add attachments',
                                  ),

                                  FormBuilderFilePicker(
                                    name: 'taxAdminCertificate',
                                    decoration: const InputDecoration(
                                        labelText:
                                            'Tax Compliance Certificate'),
                                    // maxFiles: 3, // Maximum number of attachments allowed
                                    previewImages:
                                        true, // Display image previews
                                    onChanged: (value) {
                                      print(value);
                                    },
                                    // selectorButtonOnErrorText: 'Add attachments',
                                  ),

                                  FormBuilderFilePicker(
                                    name: 'applicantCoinvestorStmt',
                                    decoration: const InputDecoration(
                                        labelText:
                                            'Applicant Coinvester Statement'),
                                    // maxFiles: 3, // Maximum number of attachments allowed
                                    previewImages:
                                        true, // Display image previews
                                    onChanged: (value) {
                                      print(value);
                                    },
                                    // selectorButtonOnErrorText: 'Add attachments',
                                  ),
                                  // SizedBox(height: 20),
                                  // ElevatedButton(
                                  //   onPressed: () {
                                  //     if (_formKey.currentState!.saveAndValidate()) {
                                  //       final formData = _formKey.currentState!.value;
                                  //       // Process the form data here
                                  //       print(formData);
                                  //     }
                                  //   },
                                  //   child: Text('Submit'),
                                  // ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16.0),

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
                                    child: const Text('Apply Loan',
                                        style: TextStyle(color: Colors.white)),
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
