import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:expenseapp/Api_repository/url_repo.dart';
import 'package:expenseapp/Modals/typemaster/type_modal.dart';
import 'package:http/http.dart' as http;

class ApiTypeRpository {
  //############################create type #######################

  Future createtype({
    required Typemodal createtype,
  }) async {
    try {
      log("api");
      Map<String, dynamic> params = {
        "expensetypeId": createtype.expenseTypeId,
        "companyId": createtype.companyId,
        "expensetype": createtype.expenseType,
        "error": createtype.error
      };
      log(jsonEncode(params).toString(), name: "tttt");
      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.post(
          Uri.parse(
              UrlRepository().baseUrl + UrlRepository().saveTypemaster
              ),
          headers: headers,
          body: jsonEncode(params));
      log(response.body.toString(), name: "response body1");
      //log(response.statusCode.toString(), name: "response body1");
      if (response.statusCode == 200) {
        //log(response.body.toString(), name: "response body1");
        var body = await jsonDecode(response.body);
        log(response.body, name: "response");
        if (body["status"] == true) {
          return {"status": "success", "data": createtype};
        } else {
          return {"status": "failed", "data": body};
        }
      } else {
        log(response.body, name: "tttt");
        return {'status': 'failed', 'error': 'network error'};
      }
    } on SocketException {
      return {'status': 'failed', 'error': 'socket error'};
    } catch (e) {
      return {'status': 'failed', 'error': 'client error'};
    }
  }

  //##################################delete type ##########################

  Future deletetype({required String id}) async {
    try {
      log("api");
      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.delete(
        Uri.parse(
            UrlRepository().baseUrl + UrlRepository().deleteTypemasterDb + id),
        headers: headers,
      );
      log(UrlRepository().baseUrl + UrlRepository().deleteTypemasterDb + id);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log(response.body.toString(), name: "response body");
        var body = await jsonDecode(response.body);
        log(response.body, name: "response");
        if (body["status"] == true) {
          return {"status": "success"};
        } else {
          return {'status': 'failed', 'error': 'networ error'};
        }
      } else {
        return {'status': 'failed', 'error': 'networ error'};
      }
    } on SocketException {
      return {'status': 'failed', 'error': 'networ error'};
    } catch (e) {
      return {'status': 'failed', 'error': 'networ error'};
    }
  }

  //############################### update type #########################3

  Future updatetype({required Typemodal updatetype}) async {
    try {
      log("api");
      Map<String, dynamic> params = {
        "expensetypeId": updatetype.expenseTypeId,
        "companyId": updatetype.companyId,
        "expensetype": updatetype.expenseType,
        "error": updatetype.error
      };

      log(jsonEncode(params.toString()), name: "tttt");
      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.post(
          Uri.parse(UrlRepository().baseUrl + UrlRepository().saveTypemaster),
          headers: headers,
          body: jsonEncode(params));
      log(UrlRepository().baseUrl + UrlRepository().postTypemasterDb);
      log(response.body.toString(), name: "response body1");
      log(response.statusCode.toString(), name: "response body1");
      if (response.statusCode == 200) {
        log(response.body.toString(), name: "response body1");
        var body = await jsonDecode(response.body);
        log(response.body, name: "response");
        if (body["status"] == true) {
       Typemodal type=   Typemodal.fromJson(body["data"]);
          return {"status": "success","data":type};
        } else {
          return {"status": "failed", "error": body};
        }
      } else {
        log(response.body, name: "error");
        return {'status': 'failed', 'error': 'network error'};
      }
    } on SocketException {
      return {'status': 'failed', 'error': 'socket error'};
    } catch (e) {
      log(e.toString(), name: "error");
      return {'status': 'failed', 'error': 'client error'};
    }
  }

  //############################### getall type #####################

  Future gettypeDB({int companyId = 1}) async {
    try {
      log("api");
      log(companyId.toString());
      Map params = {"companyId": companyId.toString()};
      log(params.toString());
      var response = await http.post(Uri.parse(
         // "http://keytech-003-site2.anytempurl.com/api/fund/getLedgerTypeByCompanyId?companyId=$companyId"
          UrlRepository().baseUrl +UrlRepository().postTypemasterDb +"$companyId"
          ));
      log(          UrlRepository().baseUrl +UrlRepository().postTypemasterDb +"$companyId"
);
      log(
        response.statusCode.toString(),
      );
      log(response.toString());
      //log(response.body.toString(),name: "get");
      if (response.statusCode == 200) {
        log(response.body.toString(), name: "type response");
        var body = await jsonDecode(response.body);
        log(response.body, name: "response");
        if (body["status"] == true) {
          Typedata typedata = Typedata.fromJson(body);
          log(typedata.toString());
          return {"status": "success", "data": typedata.data};
        } else {
          return {"status": "failed", "error": "network error1"};
        }
      } else {
        // log(response.body.toString(), name: 'type response');
        // log("response.body.toString()", name: 'type response');
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
