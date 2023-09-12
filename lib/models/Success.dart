class SuccessModel {
  String? message;
  int? status;
  Data? data;

  SuccessModel({this.message, this.status, this.data});

 factory SuccessModel.fromJson(Map<String, dynamic> json) {
    return SuccessModel(
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

Data.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
return data;
}
}



