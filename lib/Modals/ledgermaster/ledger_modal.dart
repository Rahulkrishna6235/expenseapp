// To parse this JSON data, do
//
//     final ledgermodal = ledgermodalFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';




Ledgermodal ledgermodalFromJson(String str) =>
    Ledgermodal.fromJson(json.decode(str));

String ledgermodalToJson(Ledgermodal data) => json.encode(data.toJson());

class Ledger {
  List<Ledgermodal> data;
  Ledger({required this.data});

  factory Ledger.fromJson(Map<String, dynamic> json) => Ledger(
        data: List<Ledgermodal>.from(json["data"].map((x) => Ledgermodal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}




class Ledgermodal {
  int ledgerId;
  int companyId;
  DateTime? date;
  int? nameId;
  int? typeId;
  String description;
  double credit;
  double debit;
 
  LedgerNames names;
    LedgerType1 ledgerType;
  Ledgermodal({
    required this.ledgerId,
    required this.companyId,
    required this.date,
    required this.nameId,
    required this.typeId,
    required this.description,
    required this.credit,
    required this.debit,
    required this.names,
    required this.ledgerType
  });

  factory Ledgermodal.fromJson(Map<String, dynamic> json) => Ledgermodal(
        ledgerId: json["ledgerId"]?? 0,
        companyId: json["companyId"]?? 0,
        date: DateTime.parse(json["date"]),
        nameId: json["nameId"]?? 0,
        typeId: json["typeId"]?? 0,
        description: json["description"]?? '',
        credit: json["credit"]!= null ? json["credit"].toDouble() : 0.0,
        debit: json["debit"]!= null ? json["debit"].toDouble() : 0.0,
        names: LedgerNames.fromJson(json["names"] ?? {}),
        ledgerType: LedgerType1.fromJson(json["ledgerType"] ?? {}),
        
      );

  Map<String, dynamic> toJson() => {
        "ledgerId": ledgerId,
        "companyId": companyId,
        "date": date?.toIso8601String(),
        "nameId": nameId,
        "typeId": typeId,
        "description": description,
        "credit": credit,
        "debit": debit,
        "ledgerType": ledgerType.toJson(),
         "names": names.toJson(),
      };
}
class LedgerType1 {
    int expenseTypeId;
    int companyId;
    String expenseType;
    dynamic error;

    LedgerType1({
        required this.expenseTypeId,
        required this.companyId,
        required this.expenseType,
        required this.error,
    });

    factory LedgerType1.fromJson(Map<String, dynamic> json) => LedgerType1(
        expenseTypeId: json["expenseTypeId"]?? 0,
        companyId: json["companyId"]?? 0,
        expenseType: json["expenseType"]?? '',
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "expenseTypeId": expenseTypeId,
        "companyId": companyId,
        "expenseType": expenseType,
        "error": error,
    };
}

class LedgerNames {
    int nameId;
    int companyId;
    String name;
    String mobile;
    dynamic error;

    LedgerNames({
        required this.nameId,
        required this.companyId,
        required this.name,
        required this.mobile,
        required this.error,
    });

    factory LedgerNames.fromJson(Map<String, dynamic> json) => LedgerNames(
        nameId: json["nameId"]?? 0,
        companyId: json["companyId"]?? 0,
        name: json["name"]?? '',
        mobile: json["mobile"]?? '',
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "nameId": nameId,
        "companyId": companyId,
        "name": name,
        "mobile": mobile,
        "error": error,
    };
}

