import 'package:expenseapp/globel_variables.dart';

class UrlRepository {
  String baseUrl = "http://keytech-003-site2.anytempurl.com/";

  //\\\\\\\\\\\ Name master \\\\\\\\\\

  String postNamemasterDb = "api/fund/getNamesByCompanyId?companyId=";
  String getNamemasterDb = " ";
  String deleteNamemasterDb = "api/fund/DeleteNames/";
  String saveNamemasterDb = "api/fund/SaveName";

  //***************** type master **************** */

  String postTypemasterDb =
      "api/fund/getLedgerTypeByCompanyId?companyId=";
  String getTypemasterDb = " ";
  String deleteTypemasterDb = "api/fund/DeleteLedgerType/";
  String saveTypemaster = "api/fund/SaveLedgerType";

  //****************** Ledger master ************** */

  String postLedgermasterDb = "api/fund/getLedgerByCompanyId?companyId=";
  String getLedgermasterDb = "  ";
  String deleteLedgermasterDb = "api/fund/DeleteLedger/";
  String saveLedgermasterDb = "api/fund/SaveLedger";

  //****************** report master ******************* */

  String postReportmasterDb = "";
  String getReportmasterDb = "";
  String deleteReportmasterDb = "";

  ///******************Authentication ***************** */

  String loginurl = "";
  String registerural = "";
}
