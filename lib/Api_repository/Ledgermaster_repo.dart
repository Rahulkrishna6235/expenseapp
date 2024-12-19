import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:expenseapp/Api_repository/url_repo.dart';
import 'package:expenseapp/Modals/ledgermaster/ledger_modal.dart';
import 'package:http/http.dart' as http;
import 'package:date_formatter/date_formatter.dart';
import 'package:intl/intl.dart';


class ApiLedgerRpository {
  ///***************create ledger************ */

  Future createledgerDB({required Ledgermodal createledger}) async {
    try {
      var formatter = DateFormat('yyyy-MM-dd');
      String formatteddate = formatter.format(createledger.date!);
      log("api");
      Map<String, dynamic> param = {
        "ledgerId":createledger.ledgerId,
        "companyId": createledger.companyId,
        "date": formatteddate,
        "nameId": createledger.nameId,
        "typeId": createledger.typeId,
        "description": createledger.description,
        "credit": createledger.credit,
        "debit": createledger.debit,
        "error": ""
      };
              log(createledger.ledgerId.toString());

      log(jsonEncode(param).toString(), name: "hhhh");

      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.post(
          Uri.parse(
           
              UrlRepository().baseUrl + UrlRepository().saveLedgermasterDb
              ),
          body: jsonEncode(param),
          headers: headers);
          log( UrlRepository().baseUrl + UrlRepository().saveLedgermasterDb);
      log(response.body.toString(), name: 'response body1');
      //log(response.statusCode.toString(), name: 'response body1');
      if (response.statusCode == 200) {
        ///log(response.body.toString(), name: 'response ');
        var body = await jsonDecode(response.body);
        log(response.body, name: 'response');
        if (body['status'] == true) {
          return {'status': 'success', 'data': createledger};
        } else {
          return {"status": "failed", "data": body};
        }
      } else {
        log(response.body, name: "hhhh");
        return {'status': 'failed', 'error': 'network error'};
      }
    } on SocketException {
      return {'status': 'failed', 'error': 'socket error'};
    } catch (e) {
      return {'status': 'failed', 'error': 'client error'};
    }
  }

  //**********************delete ledger *****************8 */

  Future deleteLedger({required String customerId}) async {
    try {
            log("api");

      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.delete(
          Uri.parse(
              UrlRepository().baseUrl + UrlRepository().deleteLedgermasterDb+customerId),
          headers: headers);
          log(UrlRepository().baseUrl + UrlRepository().deleteLedgermasterDb+customerId);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log(response.body.toString(), name: 'response body');
        var body = await jsonDecode(response.body);
        log(response.body, name: 'response');
        if (body["status"] == true) {
          return {'status': 'success'};
        } else {
          return {'status': 'failed', 'error': 'network error'};
        }
      }else{
                  return {'status': 'failed', 'error': 'network error'};

      }
    } on SocketException {
          return {'status': 'failed', 'error': 'network error'};
    } catch (e) {
      return {'status': 'error', 'error': 'client error'};
    }
  }

  //***************************update ledger****************** */

  Future updateLedger({required Ledgermodal createledger}) async {
    try {
      log("api");
     var formatter = DateFormat('yyyy-MM-dd');
      String formatteddate = formatter.format(createledger.date!);

      Map<String, dynamic> param = {
        "ledgerId": createledger.ledgerId,
        "companyId": createledger.companyId,
        "date": formatteddate,
        "nameId": createledger.nameId,
        "typeId": createledger.typeId,
        "description": createledger.description,
        "credit": createledger.credit,
        "debit": createledger.debit,
        
      };
      log(jsonEncode(param).toString(), name: "ggggg");

      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.post(
          Uri.parse(
              UrlRepository().baseUrl + UrlRepository().saveLedgermasterDb),
          body: jsonEncode(param),
          headers: headers);
          log(UrlRepository().baseUrl + UrlRepository().saveLedgermasterDb);
      log(response.body.toString(), name: 'response body1');
      log(response.statusCode.toString(), name: 'response body1');
      if (response.statusCode == 200) {
        log(response.body.toString(), name: 'response body1');
        var body = await jsonDecode(response.body);
        log(response.body, name: 'response');
        if (body['status'] == true) {
          Ledgermodal ledger = Ledgermodal.fromJson(body["data"]);
          return {'status': 'success' , "data" : ledger};
        } else {
          return {'status': 'failed', 'error': body};
        }
      } else {
        log(response.body, name: 'error');
        return {'status': 'failed', 'error': 'network error'};
      }
    } on SocketException {
      return {'status': 'failed', 'error': 'socket error'};
    } catch (e) {
      log(e.toString(), name: 'error');
      return {'status': 'error', 'error': 'client error'};
    }
  }

  Future getledgerdata({int companyId=1 }) async {
    try {
      log("api");
      log(companyId.toString());
       Map params = {"companyId": companyId.toString()};
      log(params.toString());
      var response = await http.post(
        Uri.parse(
          UrlRepository().baseUrl + UrlRepository().postLedgermasterDb + "$companyId"
          ));
      log(UrlRepository().baseUrl + UrlRepository().postLedgermasterDb + "$companyId");
      log(response.statusCode.toString());
       log(response.toString());
      if (response.statusCode == 200) {
        log(response.body.toString(), name: "ledger response");
        var body = await jsonDecode(response.body);
        log(response.body, name: 'response');
        if (response.statusCode == 200) {
          var body = await jsonDecode(response.body);
          if (body["status"] == true) {
            Ledger ledgerdata = Ledger.fromJson(body);
           log(ledgerdata.toString());

            return {'status': 'success', 'data': ledgerdata.data};
          }
        } else {
          return {"status": "failed", "error": "network error1"};
        }
      } else {
        return {"status": "failed", "error": "network error"};
      }
    } on SocketException {
      return {"status": "failed", "error": "socket error"};
    } catch (e) {
      log(e.toString(), name: "error");
      return {"status": "failed", "error": "client error"};
    }
  }
}
