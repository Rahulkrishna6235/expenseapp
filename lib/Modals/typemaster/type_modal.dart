// To parse this JSON data, do
//
//     final typemodal = typemodalFromJson(jsonString);

import 'dart:convert';

Typemodal typemodalFromJson(String str) => Typemodal.fromJson(json.decode(str));

String typemodalToJson(Typemodal data) => json.encode(data.toJson());

class Typedata {
  List<Typemodal> data;
  Typedata({required this.data});

  factory Typedata.fromJson(Map<String, dynamic> json) => Typedata(
        data: List<Typemodal>.from(
            json["data"].map((x) => Typemodal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Typemodal {
  int expenseTypeId;
  int companyId;
  String expenseType;
  String error;

  Typemodal({
    required this.expenseTypeId,
    required this.companyId,
    required this.expenseType,
    required this.error,
  });

  factory Typemodal.fromJson(Map<String, dynamic> json) => Typemodal(
        expenseTypeId: json["expenseTypeId"] ?? 0,
        companyId: json["companyId"] ?? 0,
        expenseType: json["expenseType"]??"",
        error: json["error"] ?? "",
      );

  

      

  Map<String, dynamic> toJson() => {
        "expenseTypeId": expenseTypeId,
        "companyId": companyId,
        "expenseType": expenseType,
        "error": error,
      };
}
