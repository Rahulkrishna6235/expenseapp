import 'package:expenseapp/Modals/ledgermaster/ledger_modal.dart';
import 'package:expenseapp/Modals/namemaster/name_modal.dart';
import 'package:expenseapp/Modals/typemaster/type_modal.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<List<Ledgermodal>> ledgerlist = ValueNotifier([]);
ValueNotifier<List<Namemodal>> namelist = ValueNotifier([]);
ValueNotifier<List<Typemodal>> typelist = ValueNotifier([]);

int? companyId;
String companyname = "Polo";
String adress = "Perinthalmanna";
String mobile = "964582277";
String username = "keytech";
String password = "123";
String error = "";

getCompanyDetails() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  companyId = sp.getInt("CompanyId");
  return true;
}

   