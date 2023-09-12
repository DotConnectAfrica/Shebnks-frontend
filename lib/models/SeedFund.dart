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
  String? application_date;
  String? application_code;
  String? applicant;
  int? userId;
  String? business_name;
  String? bussiness_mobile;
  String? bussiness_email;
  String? business_founders;
  String? bussiness_about;
  String? bussiness_vision_mission;
  String? proven_traction;
  String? funding_reason;
  bool? fandraised_before;
  String? bussiness_goals;
  String? bussiness_challenge;
  String? bussiness_challenge_solution;
  String? assigned_judge;
  String? other_attachements;
  String? business_other_info;
  String? project_budget;
  bool? ownedbywomen;
  bool? fundRaisedBefore;
  String? stemGap;
  String? business_share_capital;
  String? business_problems;
  String? business_impact;
  String? business_initiative;
  String? business_market;
  String? bussiness_level;
  String? attachments_link;
  String? revenue_amount;
  String? bussiness_sectors;
  int? application_received_status;
  int? application_rules_status;
  int? application_evaluation_status;
  int? application_admin_check_status;
  int? application_status;
  String? bussiness_target;
  String? joint_statement;
  String? tax_admin_cert;

  Data({
    this.application_id,
    this.application_date,
    this.application_code,
    this.applicant,
    this.userId,
    this.business_name,
    this.bussiness_mobile,
    this.bussiness_email,
    this.business_founders,
    this.bussiness_about,
    this.bussiness_vision_mission,
    this.proven_traction,
    this.funding_reason,
    this.fandraised_before,
    this.bussiness_goals,
    this.bussiness_challenge,
    this.bussiness_challenge_solution,
    this.assigned_judge,
    this.other_attachements,
    this.business_other_info,
    this.project_budget,
    this.ownedbywomen,
    this.fundRaisedBefore,
    this.stemGap,
    this.business_share_capital,
    this.business_problems,
    this.business_impact,
    this.business_initiative,
    this.business_market,
    this.bussiness_level,
    this.attachments_link,
    this.revenue_amount,
    this.bussiness_sectors,
    this.application_received_status,
    this.application_rules_status,
    this.application_evaluation_status,
    this.application_admin_check_status,
    this.application_status,
    this.bussiness_target,
    this.joint_statement,
    this.tax_admin_cert,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      application_id: json['application_id'],
      application_date: json['application_date'],
      application_code: json['application_code'],
      applicant: json['applicant'],
      userId: json['userId'],
      business_name: json['business_name'],
      bussiness_mobile: json['bussiness_mobile'],
      bussiness_email: json['bussiness_email'],
      business_founders: json['business_founders'],
      bussiness_about: json['bussiness_about'],
      bussiness_vision_mission: json['bussiness_vision_mission'],
      proven_traction: json['proven_traction'],
      funding_reason: json['funding_reason'],
      fandraised_before: json['fandraised_before'],
      bussiness_goals: json['bussiness_goals'],
      bussiness_challenge: json['bussiness_challenge'],
      bussiness_challenge_solution: json['bussiness_challenge_solution'],
      assigned_judge: json['assigned_judge'],
      other_attachements: json['other_attachements'],
      business_other_info: json['business_other_info'],
      project_budget: json['project_budget'],
      ownedbywomen: json['ownedbywomen'],
      fundRaisedBefore: json['fundRaisedBefore'],
      stemGap: json['stemGap'],
      business_share_capital: json['business_share_capital'],
      business_problems: json['business_problems'],
      business_impact: json['business_impact'],
      business_initiative: json['business_initiative'],
      business_market: json['business_market'],
      bussiness_level: json['bussiness_level'],
      attachments_link: json['attachments_link'],
      revenue_amount: json['revenue_amount'],
      bussiness_sectors: json['bussiness_sectors'],
      application_received_status: json['application_received_status'],
      application_rules_status: json['application_rules_status'],
      application_evaluation_status: json['application_evaluation_status'],
      application_admin_check_status: json['application_admin_check_status'],
      application_status: json['application_status'],
      bussiness_target: json['bussiness_target'],
      joint_statement: json['joint_statement'],
      tax_admin_cert: json['tax_admin_cert'],
    );
  }
}
