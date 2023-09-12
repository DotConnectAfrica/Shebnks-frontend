import 'package:flutter/material.dart';
import '../api_services/api_services.dart';
import '../widgets/Custom_Card.dart';
import '../widgets/Customresponse.dart';

class ViewProgressPage extends StatefulWidget {
  final Map<String, dynamic> progressData;

  ViewProgressPage({required this.progressData});

  @override
  _ViewProgressPageState createState() => _ViewProgressPageState();
}

class _ViewProgressPageState extends State<ViewProgressPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _apiServices = ApiServices();
  final aboutController = TextEditingController();
  final sectorsController = TextEditingController();
  final founderController = TextEditingController();
  final bridgingController = TextEditingController();
  final problemController = TextEditingController();
  final impactController = TextEditingController();
  final marketingController = TextEditingController();
  final stemInitiativeController = TextEditingController();
  final transactonController = TextEditingController();
  final sdgController = TextEditingController();
  final tellusController = TextEditingController();
  final anyOtherinfoController = TextEditingController();

  var countryCode = "+254";
  var _usercountry = "Kenya";
  final formKey = GlobalKey<FormState>();
  Future<bool>? _futureAlbum;
  List<String> finalSectors = [];
  List<int> someList = [1, 2, 3, 4, 5];
  List<String> selectedCategories = [];
  List<String> selectedCategories2 = [];
  var isOtherEnabled2 = false;
  var isOtherEnabled = false;
  bool isLoading = false;
  var isWomanOwned = 1;
  var fundraised = 1;
  var generatingRevenue = 1;
  var growthLevel = 0;
  String? phone,
      projectBudgetUrl,
      shareCapital,
      jointStatment,
      taxAdmin,
      financialStatments,
      id,
      applicationId = "2021",
      growthLevelString = "Start-up",
      videoStatements;
  bool budgetLoading = false,
      capitalLoading = false,
      jointLoading = false,
      taxLoading = false,
      financialLoading = false,
      pathsLoading = false,
      videoLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              color: Colors.pink[50], // Light pink color
              margin: const EdgeInsets.all(20.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.progressData["application_status"] == 0
                      ? "Application is under review"
                      : "Congratulations, your application has been approved",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // CustomResponse(
            //   question: "1. Tell us about your organization or Project (Applicant expected to give the name, size, current residence and any other information)",
            //   answer: widget.progressData["bussiness_about"],
            // ),
            CustomResponse(
              question:
                  "1. Who is the trusted founder(s) or Leader? (Please include phone number and email address and separate each founder by comma)",
              answer: widget.progressData["proven_traction"],
            ),
            CustomResponse(
              question: "2. Tell us why we should fund you.",
              answer: widget.progressData["funding_reason"],
            ),
            CustomResponse(
              question: "3. What problem/community need are you addressing?",
              answer: widget.progressData["business_problems"],
            ),
            CustomResponse(
              question:
                  "4. Which sector does your business operate in(Please fill multiple if necessary) ?",
              answer: widget.progressData["bussiness_sectors"],
            ),
          ],
        ),
      ),
    );
  }
}
