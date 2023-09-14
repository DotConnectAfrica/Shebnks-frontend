// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:she_banks/utils/universal_methods.dart';

// class EmailSender extends StatefulWidget {
//   const EmailSender({Key? key}) : super(key: key);

//   @override
//   _EmailSenderState createState() => _EmailSenderState();
// }

// class _EmailSenderState extends State<EmailSender> {
//   List<String> attachments = [];
//   bool isHTML = false;

//   final _recipientController = TextEditingController(
//     text: 'example@example.com',
//   );

//   final _subjectController = TextEditingController();

//   final _bodyController = TextEditingController(
//     text: '',
//   );

//   Future<void> send() async {
//     final Email email = Email(
//       body: _bodyController.text,
//       subject: _subjectController.text,
//       recipients: [_recipientController.text],
//       attachmentPaths: attachments,
//       isHTML: isHTML,
//     );

//     String platformResponse;

//     try {
//       await FlutterEmailSender.send(email);
//       platformResponse = 'success';
//     } catch (error) {
//       print(error);
//       platformResponse = error.toString();
//     }

//     if (!mounted) return;

//     UniversalMethods.show_toast(platformResponse, context);

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         foregroundColor: Colors.black,
//         backgroundColor: Colors.white,
//         title: Text('Contact Us'),
//         actions: <Widget>[
//           IconButton(
//             onPressed: send,
//             icon: Icon(Icons.send),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: _recipientController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Recipient',
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: _subjectController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Subject',
//                   ),
//                 ),
//               ),

//               Expanded(
//                 child: Container(
//                   decoration: new BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(32.0),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       SizedBox(
//                         width: 16,
//                       ),
//                       Expanded(
//                         child: TextFormField(
//                           maxLines: 360,
//                           controller: _bodyController,
//                           decoration: new InputDecoration(
//                             contentPadding:
//                             EdgeInsets.all(8),
//                             hintText: 'Type a message',
//                             hintStyle:
//                             TextStyle(fontSize: 16, color: Colors.grey[700]),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                               borderSide: BorderSide(
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                               borderSide: BorderSide(
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             errorBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                               borderSide: BorderSide(
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             disabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(8.0),
//                               borderSide: BorderSide(
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                           validator: (val) {
//                             if (val!.length == 0) {
//                               return "Empty comment";
//                             } else {
//                               return null;
//                             }
//                           },
//                           keyboardType: TextInputType.multiline,
//                           style: new TextStyle(
//                               fontFamily: "Poppins",
//                               fontSize: 16,
//                               color: Colors.grey[800]),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               // Expanded(
//               //   child: Padding(
//               //     padding: EdgeInsets.all(8.0),
//               //     child: TextField(
//               //       controller: _bodyController,
//               //       maxLines: null,
//               //       expands: true,
//               //       textAlignVertical: TextAlignVertical.top,
//               //       decoration: InputDecoration(
//               //           labelText: 'Enter a message', border: OutlineInputBorder()),
//               //     ),
//               //   ),
//               // ),

//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Column(
//                   children: <Widget>[
//                     for (var i = 0; i < attachments.length; i++)
//                       Row(
//                         children: <Widget>[
//                           Expanded(
//                             child: Text(
//                               '${attachments[i].split('/').last}',
//                               softWrap: true,
//                               maxLines: 10,
//                               style: TextStyle(fontSize: 12),
//                               overflow: TextOverflow.fade,
//                             ),
//                           ),
//                           IconButton(
//                             icon: Icon(Icons.remove_circle),
//                             onPressed: () => {_removeAttachment(i)},
//                           )
//                         ],
//                       ),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: IconButton(
//                         icon: Icon(Icons.attach_file),
//                         onPressed: _openImagePicker,
//                       ),
//                     ),
//                     TextButton(
//                       child: Text('Attach file in app documents directory'),
//                       onPressed: () => _attachFileFromAppDocumentsDirectoy(),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _openImagePicker() async {
//     final picker = ImagePicker();
//     PickedFile? pick = await picker.getImage(source: ImageSource.gallery);
//     if (pick != null) {
//       setState(() {
//         attachments.add(pick.path);
//       });
//     }
//   }

//   void _removeAttachment(int index) {
//     setState(() {
//       attachments.removeAt(index);
//     });
//   }

//   Future<void> _attachFileFromAppDocumentsDirectoy() async {
//     try {
//       final appDocumentDir = await getApplicationDocumentsDirectory();
//       final filePath = appDocumentDir.path + '/file.txt';
//       final file = File(filePath);
//       await file.writeAsString('Text file in app directory');

//       setState(() {
//         attachments.add(filePath);
//       });
//     } catch (e) {
//     UniversalMethods.show_toast('Error', context);
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

class EmailSender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Column(
        children: [
          // Company Logo and Motto
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/logo.png', // Replace with your company logo image
                    width: 100, // Adjust the size as needed
                    height: 100,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Your Company Motto', // Replace with your company motto
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Contact Buttons
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildContactButton('Website', Icons.web, () {
                      _makePhoneCall("123");
                    }, context),
                    _buildContactButton('Phone Number', Icons.phone, () {
                      _makePhoneCall('123');
                    }, context),
                    _buildContactButton(
                        'Email', Icons.email, () => _makePhoneCall, context),
                    _buildContactButton('Twitter', FontAwesomeIcons.twitter,
                        () {
                      _makePhoneCall('123');
                    }, context),
                    _buildContactButton('Instagram', FontAwesomeIcons.instagram,
                        () {
                      _makePhoneCall('123');
                    }, context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    // await launchUrl(launchUri);
  }

  Widget _buildContactButton(
      String label, IconData icon, Function onPressed, context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: ElevatedButton.icon(
        onPressed: () async {
          final Uri url = Uri.parse("https://dotconnectafrica.org/");
        //   if (await canLaunchUrl(url)) {
        //     if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
        //       throw Exception('Could not launch $url');
        //     }
        //   } else {}
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16),
          primary: Color(0xffed39ca), // Change button color as needed
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Adjust the corner radius
          ),
        ),
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        label: Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
