import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:she_banks/models/banner.dart';
import 'package:she_banks/screens/BannerWidget.dart';
import 'package:she_banks/screens/TextBannerWidget.dart';
import 'package:she_banks/screens/colors.dart';
import 'package:she_banks/screens/restart_widget.dart';
import 'package:she_banks/screens/screen_home.dart';

import '../api_services/api_services.dart';
import '../models/FirebaseModel.dart';
import '../models/model_user.dart';
import '../utils/universal_methods.dart';

class ScreenEditProfile extends StatefulWidget {
  final fName;

  final lName;

  final email;

  final userId;

  final mobile;
  final secondName;

  const ScreenEditProfile(
      {super.key,
      required this.fName,
      required this.lName,
      required this.email,
      required this.userId,
      required this.mobile,
      this.secondName});

  @override
  State<ScreenEditProfile> createState() => _MyAccountState();
}

class _MyAccountState extends State<ScreenEditProfile> {
  var token;
  final TextEditingController controller_first_name = TextEditingController();
  final TextEditingController controller_second_name = TextEditingController();
  final TextEditingController controller_last_name = TextEditingController();
  final TextEditingController controller_email = TextEditingController();
  final TextEditingController controller_id_number = TextEditingController();

  final TextEditingController controller_mobile_number =
      TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference? users;
  // ModelUser? user;

  getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    token = _prefs.get('token');
    debugPrint('token isss.........$token');
  }

  @override
  void initState() {
    getToken();
    super.initState();
    // user = widget.user;

    // controller_second_name.text = user!.middleName;
    // controller_last_name.text = user!.lastName;
    // controller_email.text = user!.emailAddress;
    // controller_id_number.text = user!.idNumber;
      controller_first_name.text = widget.fName;
    controller_last_name.text = widget.lName;
    controller_email.text = widget.email;
    controller_second_name.text = widget.secondName;
  }

  @override
  Widget build(BuildContext context) {
    // controller_first_name.text = widget.fName;
    // controller_last_name.text = widget.lName;
    // controller_email.text = widget.email;
    // controller_second_name.text = widget.secondName;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              leading: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              largeTitle: Text('Edit Profile'),
            ),
          ];
        },
        body: Container(
          margin: EdgeInsets.only(top: 16, right: 16, left: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                first_tile(),
                SizedBox(
                  height: 32,
                ),
                _phone_input(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget first_tile() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // margin: EdgeInsets.only(left: 16),
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/default_avatar.png',
                        height: 50,
                        width: 50,
                        color: Color(0xffed39ca),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.fName} ${widget.lName}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${widget.email}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _phone_input() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: TextFormField(
                controller: controller_first_name,
                decoration: new InputDecoration(
                  hintText: 'First name',
                  contentPadding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),

                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val!.length == 0) {
                    return "Phone number be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 32,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: TextFormField(
                controller: controller_second_name,
                decoration: new InputDecoration(
                  hintText: 'Second name',
                  contentPadding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val!.length == 0) {
                    return "Phone number be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 32,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: TextFormField(
                controller: controller_last_name,
                decoration: new InputDecoration(
                  hintText: 'Last name',
                  contentPadding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),

                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val!.length == 0) {
                    return "Phone number be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 32,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: TextFormField(
                controller: controller_email,
                decoration: InputDecoration(
                  hintText: 'Email address',
                  contentPadding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),

                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val!.length == 0) {
                    return "Phone number be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ],
        ),
      SizedBox(
          height: 36,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 42,
          child: OutlinedButton(
            onPressed: () {
              get_user_info();
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(MyColors().primaryColor),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
            child: const Text(
              "SAVE CHANGES",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  get_user_info() async {
    var first_name = controller_first_name.text;
    var second_name = controller_second_name.text;
    var last_name = controller_last_name.text;
    var email = controller_email.text;
    // var id_number = controller_id_number.text;

    if (first_name.isEmpty) {
      FocusScope.of(context).unfocus();
      UniversalMethods.show_toast('First name is required', context);
      return false;
    }

    if (last_name.isEmpty) {
      FocusScope.of(context).unfocus();
      UniversalMethods.show_toast('Last name is required', context);
      return;
    }
    if (email.isEmpty) {
      FocusScope.of(context).unfocus();
      UniversalMethods.show_toast('Email is required', context);
      return;
    }

    await addUser(first_name, second_name, last_name, email);
  }

  Future addUser(first_name, second_name, last_name, email) async {
    var userId = widget.userId;
    debugPrint('email is $email');
    Map<String, dynamic> signup_data = {
      "firstName": first_name,
      "lastName": last_name,
      "middleName": second_name,

      "email": email,
      // 'idNumber': id_number,
      // 'mobileNumber': widget.mobile,
      // John Doe
    };
    ApiServices().update_data(signup_data, userId).then((value) {
      if (value.status == 200) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Update Details'),
                content: Text('${value.message.toString()}'),
              );
            });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${value.message.toString()}')));
      } else if(value.status==400){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Alert'),
                content: Text('Bad request'),
              );
            });
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Oops an error occured')));
      }
    });
  }
}