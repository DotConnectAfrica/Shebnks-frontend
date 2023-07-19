import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:she_banks/screens/screen_home.dart';
import 'package:she_banks/screens/screen_she_funds.dart';

import '../api_services/api_services.dart';
import '../models/Notification.dart';
import '../utils/NotificationProvider.dart';
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

  TextEditingController _nameController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  TextEditingController _nationalityController = TextEditingController();
  TextEditingController _identificationNumberController =
  TextEditingController();
  TextEditingController _residentialAddressController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _employmentStatusController = TextEditingController();
  TextEditingController _monthlyIncome = TextEditingController();
  TextEditingController _maritalStatus = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _ethnicity = TextEditingController();
  TextEditingController _educationLevel = TextEditingController();
  TextEditingController _employmentIndustry = TextEditingController();

  @override
  void dispose() {
    // _amountController.dispose();
    _nameController.dispose();
    _dateOfBirthController.dispose();
    _nationalityController.dispose();
    _identificationNumberController.dispose();
    _residentialAddressController.dispose();
    _phoneNumberController.dispose();
    _emailAddressController.dispose();
    _maritalStatus.dispose();
    _employmentStatusController.dispose();
    _monthlyIncome.dispose();
    _gender.dispose();
    _ethnicity.dispose();
    _educationLevel.dispose();
    _employmentIndustry.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      List<String> finalIndustry = [];

      final name = _nameController.text;
      final birthDate = _dateOfBirthController.text;
      final nationality = _nationalityController.text;
      final identity = _identificationNumberController.text;
      final residentialAddress = _residentialAddressController.text;
      final phoneNumber = _phoneNumberController.text;
      final email = _emailAddressController.text;
      final employmentStatus = _employmentStatusController.text;
      final monthlyIncome = _monthlyIncome.text;
      final maritalStatus = _maritalStatus.text;
      final gender = _gender.text;
      final ethnicity = _ethnicity.text;
      final educationLevel = _educationLevel.text;
      final employmentIndustry = _employmentIndustry.text;

      // var isWoman//Owned = 1;
      // var fStatement = 1;
      // var collateral = 1;
      // var bPlan = 1;
      // var womenInit = 1;
      // var references = 1;
      // var mentor = 1;
      // var programs = 1;
      Map data = {
        'quiz': {
          'name': "$name",
          'dob': '$birthDate',
          'nationality': '$nationality',
          'id': '$identity',
          'residential': '$residentialAddress',
          'phone': "$phoneNumber",
          'employment': '$employmentStatus',
          'income': '$monthlyIncome',
          'email': '$email',
          'status': '$maritalStatus',
          'gender': '$gender',
          'ethnicity': '$ethnicity',
          'education': '$educationLevel',
          'industry': '$employmentIndustry'
        }
      };
      _apiServices.submit_iq(data, widget.token, widget.userId).then((value) {
        setState(() {
          _isLoading = false;
        });
        if (value.status == 'OK') {
          // var
          // storeHasLoan();
          _successDialog('SheIQ Submitted Successfully');
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
                        final notificationsProvider =
                        Provider.of<NotificationsProvider>(context, listen: false);

                        // Simulate receiving a new notification
                        final newNotification = NotificationModel(
                          title: 'She IQ',
                          body: '$message',

                        );

                        // Add the notification to the provider
                        notificationsProvider.addNotification(newNotification);
                        InAppNotifications.show(
                            title: "SheIQ",
                            leading: Image.asset('assets/images/logo.png'),
                            description: message,
                            // ending: Icon(Icons.arrow_forward_ios),
                            onTap: (){
                              Navigator.pop(context);
                            }

                        );
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
                      const Text('a. Personal information',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 4,
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
                                const Text('1. What is your name*'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      // height: 60,
                                      child: TextFormField(
                                        controller: _nameController,
                                        decoration: InputDecoration(
                                          hintText: 'Answer',
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
                                const Text('2. What is your date of birth (DDMMYYYY)*'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      // height: 60,
                                      child: TextFormField(
                                        controller: _dateOfBirthController,
                                        decoration: InputDecoration(
                                          hintText: 'Answer',
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
                                const Text('3. What is your Nationality*'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      // height: 60,
                                      child: TextFormField(
                                        controller: _nationalityController,
                                        decoration: InputDecoration(
                                          hintText: 'Answer',
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
                                const Text(
                                    '4. What is your National Identification, eg passport, or ID card Number*'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      // height: 60,
                                      child: TextFormField(
                                        controller:
                                        _identificationNumberController,
                                        decoration: InputDecoration(
                                          hintText: 'Answer',
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
                                  ],
                                ),
                              ]),
                        ),
                      ),
                      const Text('b. Contact information',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 4,
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
                                        controller:
                                        _residentialAddressController,
                                        decoration: InputDecoration(
                                          hintText: 'Answer',
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
                                const Text('6. Your Phone Number*'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      // height: 60,
                                      child: TextFormField(
                                        controller: _phoneNumberController,
                                        decoration: InputDecoration(
                                          hintText: 'Answer',
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
                                const Text('7. What is your email Address? *'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      // height: 60,
                                      child: TextFormField(
                                        controller: _emailAddressController,
                                        decoration: InputDecoration(
                                          hintText: 'Answer',
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
                                  ],
                                ),
                              ]),
                        ),
                      ),
                      const Text('c. Financial information',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 4,
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
                                        controller: _employmentStatusController,
                                        decoration: InputDecoration(
                                          hintText: 'Answer',
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
                                const Text('9. What is your monthly Income ?*'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      // height: 60,
                                      child: TextFormField(
                                        controller: _monthlyIncome,
                                        decoration: InputDecoration(
                                          hintText: 'Answer',
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
                                  ],
                                ),
                              ]),
                        ),
                      ),
                      const Text('d. Marital Status',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 4,
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
                                    '10. What is your Marital status (single, married, divorced, etc) ?*'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      // height: 60,
                                      child: TextFormField(
                                        controller: _maritalStatus,
                                        decoration: InputDecoration(
                                          hintText: 'Answer',
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
                                  ],
                                ),
                              ]),
                        ),
                      ),
                      const Text('e. Demographic Information:',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 4,
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
                                const Text('11. What is your gender ?*'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      // height: 60,
                                      child: TextFormField(
                                        controller: _gender,
                                        decoration: InputDecoration(
                                          hintText: 'Answer',
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
                                const Text('12. What is your Ethnicity ?*'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      // height: 60,
                                      child: TextFormField(
                                        controller: _ethnicity,
                                        decoration: InputDecoration(
                                          hintText: 'Answer',
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
                                const Text(
                                    '13. What is your Education Level ?*'),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      // height: 60,
                                      child: TextFormField(
                                        controller: _educationLevel,
                                        decoration: InputDecoration(
                                          hintText: 'Answer',
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
                                const Text(
                                  "14. What industry is your business in ?(eg Agribusiness, energy, tech, Beauty, construction etc )",
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      // height: 60,
                                      child: TextFormField(
                                        controller: _employmentIndustry,
                                        decoration: InputDecoration(
                                          hintText: 'Answer',
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
                                  ],
                                ),
                              ]),
                        ),
                      ),
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
                          child: const Text('Submit',
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
