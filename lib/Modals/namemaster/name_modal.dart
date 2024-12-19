// To parse this JSON data, do
//
//     final namemodal = namemodalFromJson(jsonString);

import 'dart:convert';

Namemodal namemodalFromJson(String str) => Namemodal.fromJson(json.decode(str));

String namemodalToJson(Namemodal data) => json.encode(data.toJson());

class Namedata {
  List<Namemodal> data;
  Namedata({required this.data});

  factory Namedata.fromJson(Map<String, dynamic> json) => Namedata(
        data: List<Namemodal>.from(json["data"].map((x) => Namemodal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Namemodal {
    int nameId;
    int companyId;
    String name;
    String mobile;
    String error;

    Namemodal({
        required this.nameId,
        required this.companyId,
        required this.name,
        required this.mobile,
        required this.error,
    });

    factory Namemodal.fromJson(Map<String, dynamic> json) => Namemodal(
        nameId: json["nameId"]?? 0,
        companyId: json["companyId"]?? 0,
        name: json["name"]?? '',
        mobile: json["mobile"]?? '',
        error: json["error"]?? "",
    );

    Map<String, dynamic> toJson() => {
        "nameId": nameId,
        "companyId": companyId,
        "name": name,
        "mobile": mobile,
        "error": error,
    };
}
