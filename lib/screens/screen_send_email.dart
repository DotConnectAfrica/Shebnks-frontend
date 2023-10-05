import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailSender extends StatefulWidget {
  // const EmailSender({super.key, required this.title});
  // final String title;

  @override
  State<EmailSender> createState() => _EmailSenderState();
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

class _EmailSenderState extends State<EmailSender> {
  bool _hasCallSupport = false;
  Future<void>? _launched;
  String _phone = '';

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'developers@dotconnectafrica.org',
    query: encodeQueryParameters(<String, String>{
      'subject': 'Support',
    }),
  );

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchAsInAppWebViewWithCustomHeaders(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchInWebViewWithoutJavaScript(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: false),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchInWebViewWithoutDomStorage(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableDomStorage: false),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchUniversalLinkIos(Uri url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  final Uri smsLaunchUri = Uri(
    scheme: 'sms',
    path: '+254794163715',
    queryParameters: <String, String>{
      'body': Uri.encodeComponent('Support text'),
    },
  );

  @override
  Widget build(BuildContext context) {
    // onPressed calls using this URL are not gated on a 'canLaunch' check
    // because the assumption is that every device can launch a web URL.
    final Uri toLaunch =
        Uri(scheme: 'https', host: 'dotconnectafrica.org', path: 'headers/');
    return Scaffold(
        appBar: AppBar(
          title: Text("Contact Us"),
        ),
        body: Column(children: [
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
                  'Making women financialy stable', // Replace with your company motto
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: ElevatedButton.icon(
                      onPressed: _hasCallSupport
                          ? () {
                              // Make a phone call when the button is pressed
                              setState(() {
                                _launched = _makePhoneCall("+254794163715");
                              });
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        primary:
                            Color(0xffed39ca), // Change button color as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20), // Adjust the corner radius
                        ),
                      ),
                      icon: Icon(
                        Icons.phone,
                        color: Colors.black,
                      ),
                      label: Text(
                        'Phone Number',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _launched = _launchInWebViewOrVC(toLaunch);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        primary:
                            Color(0xffed39ca), // Change button color as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20), // Adjust the corner radius
                        ),
                      ),
                      icon: Icon(Icons.open_in_browser,
                          color: Colors.black), // Change icon as needed
                      label: Text(
                        'Website',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(16.0)),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: ElevatedButton.icon(
                      onPressed: () => launchUrl(emailLaunchUri),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        primary:
                            Color(0xffed39ca), // Change button color as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20), // Adjust the corner radius
                        ),
                      ),
                      icon: Icon(Icons.email,
                          color: Colors.black), // Change icon as needed
                      label: Text(
                        'Email',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(16.0)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: ElevatedButton.icon(
                      onPressed: () => launchUrl(smsLaunchUri),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        primary:
                            Color(0xffed39ca), // Change button color as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20), // Adjust the corner radius
                        ),
                      ),
                      icon: Icon(Icons.sms,
                          color: Colors.black), // Change icon as needed
                      label: Text(
                        'SMS',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // Link(
                  //   uri: Uri.parse(
                  //       'https://dotconnectafrica.org'),
                  //   target: LinkTarget.blank,
                  //   builder: (BuildContext ctx, FollowLink? openLink) {
                  //     return TextButton.icon(
                  //       onPressed: openLink,
                  //       label: const Text('Link Widget documentation'),
                  //       icon: const Icon(Icons.read_more),
                  //     );
                  //   },
                  // ),
                  // const Padding(padding: EdgeInsets.all(16.0)),
                  FutureBuilder<void>(
                      future: _launched, builder: _launchStatus),
                ],
              ),
            ],
          ))
        ]));
  }
}
