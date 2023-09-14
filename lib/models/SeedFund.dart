class SeedFund {
  String? message;
  int? status;
  Data? data;

  SeedFund({this.message, this.status, this.data});

 factory SeedFund.fromJson(Map<String, dynamic> json) {
    return SeedFund(
      message: json['message'],
      status: json['status'],
      data: Data.fromJson(json['data']),

    );
  }




}
// class Data {
//   final Map<String, dynamic> jsonData; // Use a Map to store dynamic data

//   Data({
//     required this.jsonData,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       jsonData: json,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return jsonData;
//   }
// }

class Data {
  int? application_id;
  dynamic applicationdate;
  dynamic applicationcode;
  dynamic applicant;
  dynamic userId;
  dynamic business_name;
  dynamic bussinessMobile;
  dynamic bussinessEmail;
  dynamic businessFounders;
  dynamic? bussinessAbout;
  dynamic? bussinessVisionMission;
  dynamic? provenTraction;
  dynamic? fundingReason;
  bool? fandraisedBefore;
  dynamic? bussinessGoals;
  dynamic? bussinessChallenge;
  dynamic? bussinessChallengeSolution;
  dynamic? assignedJudge;
  dynamic? otherAttachements;
  dynamic? businessOtherInfo;
  dynamic? projectBudget;
  bool? ownedbywomen;
  bool? fundRaisedBefore;
  dynamic? stemGap;
  dynamic? businessShareCapital;
  dynamic? businessProblems;
  dynamic? businessImpact;
  dynamic? businessInitiative;
  dynamic? businessMarket;
  dynamic? bussinessLevel;
  dynamic? attachmentsLink;
  dynamic? revenueAmount;
  dynamic? bussinessSectors;
  int? applicationReceivedStatus;
  int? applicationRulesStatus;
  int? applicationEvaluationStatus;
  int? applicationAdminCheckStatus;
  int? applicationStatus;
  dynamic? bussinessTarget;
  dynamic? jointStatement;
  dynamic? taxAdminCert;

  

  Data({
    this.application_id,
    this.applicationdate,
    this.applicationcode,
    this.applicant,
    this.userId,
    this.business_name,
    this.bussinessMobile,
    this.bussinessEmail,
    this.businessFounders,
    this.bussinessAbout,
    this.bussinessVisionMission,
    this.provenTraction,
    this.fundingReason,
    this.fundRaisedBefore,
    this.bussinessGoals,
    this.bussinessChallenge,
    this.bussinessChallengeSolution,
    this.assignedJudge,
    this.otherAttachements,
    this.businessOtherInfo,
    this.projectBudget,
    this.ownedbywomen,
    this.stemGap,
    this.businessShareCapital,
    this.businessProblems,
    this.businessImpact,
    this.businessInitiative,
    this.businessMarket,
    this.bussinessLevel,
    this.attachmentsLink,
    this.revenueAmount,
    this.bussinessSectors,
    this.applicationReceivedStatus,
    this.applicationRulesStatus,
    this.applicationEvaluationStatus,
    this.applicationAdminCheckStatus,
    this.applicationStatus,
    this.bussinessTarget,
    this.jointStatement,
    this.taxAdminCert,
  });


  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      application_id: json['application_id'],
    applicationdate: json['applicationdate'],
    applicationcode: json['applicationcode'],
    applicant: json['applicant'],
    userId: json['userId'],
    business_name: json['business_name'],
    bussinessMobile: json['bussinessMobile'],
    bussinessEmail: json['bussinessEmail'],
    businessFounders: json['businessFounders'],
    bussinessAbout: json['bussinessAbout'],
    bussinessVisionMission: json['bussinessVisionMission'],
    provenTraction: json['provenTraction'],
    fundingReason: json['fundingReason'],
    fundRaisedBefore: json['fundRaisedBefore'],
    bussinessGoals: json['bussinessGoals'],
    bussinessChallenge: json['bussinessChallenge'],
    bussinessChallengeSolution: json['bussinessChallengeSolution'],
    assignedJudge: json['assignedJudge'],
    otherAttachements: json['otherAttachements'],
    businessOtherInfo: json['businessOtherInfo'],
    projectBudget:json['projectBudget'],
    ownedbywomen:json['ownedbywomen'],
    stemGap:json['stemGap'],
    businessShareCapital:json['businessShareCapital'],
    businessProblems:json['businessProblems'],
    businessImpact:json['businessImpact'],
    businessInitiative:json['businessInitiative'],
    businessMarket:json['businessMarket'],
    bussinessLevel:json['bussinessLevel'],
    attachmentsLink:json['projectBudget'],
    revenueAmount:json['attachmentsLink'],
    bussinessSectors:json['bussinessSectors'],
    applicationReceivedStatus:json['applicationReceivedStatus'],
    applicationRulesStatus:json['applicationRulesStatus'],
    applicationEvaluationStatus:json['applicationEvaluationStatus'],
    applicationAdminCheckStatus:json['applicationAdminCheckStatus'],
    applicationStatus:json['applicationStatus'],
    bussinessTarget:json['bussinessTarget'],
    jointStatement:json['jointStatement'],
    taxAdminCert:json['taxAdminCert'],
    );
  }
}
