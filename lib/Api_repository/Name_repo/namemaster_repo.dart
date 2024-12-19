import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:expenseapp/Api_repository/url_repo.dart';
import 'package:expenseapp/Modals/namemaster/name_modal.dart';
import 'package:http/http.dart' as http;

class ApiNameRepository {
  Future createNameDB(
      {required Namemodal createname,}) async {
    try {
      log("api");
      Map<String, dynamic> params = {
        "nameId": createname.nameId,
        "companyId": createname.companyId,
        "name": createname.name,
        "mobile": createname.mobile,
        "error": createname.error
      };
      log(jsonEncode(params).toString(), name: "aaaa");

      //log(jsonEncode(params).toString(), name: "aaaa");
      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.post(
          Uri.parse(
            
              UrlRepository().baseUrl + UrlRepository().saveNamemasterDb
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
          return {"status": "success", "data": createname};
        } else {
          return {"status": "failed", "data": body};
        }
      } else {
        log(response.body, name: "aaaa");
        return {'status': 'failed', 'error': 'network error'};
      }
    } on SocketException {
      return {'status': 'failed', 'error': 'socket error'};
    } catch (e) {
      return {'status': 'failed', 'error': 'client error'};
    }
  }

  Future deleteName({required String userId}) async {
    try {
      log("api");
      Map<String, String> headers = {"Content-type": "apllication/json"};
      var response = await http.delete(
        Uri.parse(UrlRepository().baseUrl + UrlRepository().deleteNamemasterDb + userId),
        headers: headers,
      );
      log(UrlRepository().baseUrl + UrlRepository().deleteNamemasterDb + userId);
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
      }else{
                  return {'status': 'failed', 'error': 'networ error'};

      }
    } on SocketException {
      return {'status': 'failed', 'error': 'networ error'};
    } catch (e) {
      return {'status': 'failed', 'error': 'networ error'};
    }
  }

  Future updateDBname({required Namemodal createname}) async {
    try {
      log("api");
      Map<String, dynamic> params = {
        "nameId": createname.nameId,
        "companyId": createname.companyId,
        "name": createname.name,
        "mobile": createname.mobile,
        "error": createname.error
      };
      log(jsonEncode(params).toString(), name: "tttt");
      Map<String, String> headers = {"Content-type": "application/json"};
      var response = await http.post(
          Uri.parse(UrlRepository().baseUrl + UrlRepository().saveNamemasterDb),
          headers: headers,
          body: jsonEncode(params));
          log(UrlRepository().baseUrl + UrlRepository().saveNamemasterDb);
      log(response.body.toString(), name: "response body1");
      log(response.statusCode.toString(), name: "response body1");
      if (response.statusCode == 200) {
        log(response.body.toString(), name: "response body1");
        var body = await jsonDecode(response.body);
        log(response.body, name: "response");
        if (body["status"] == true) {
                 Namemodal type=   Namemodal.fromJson(body["data"]);

          return {"status": "success", "data" : type};
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

  Future getNameDB({int companyId = 1}) async {
    try {
      log("api");
      log(companyId.toString());
      Map params = {"CompanyId": companyId.toString()};
      log(params.toString());
      var response = await http.post(Uri.parse(
         // "http://keytech-003-site2.anytempurl.com/api/fund/getNamesByCompanyId?companyId=$companyId"
           UrlRepository().baseUrl+UrlRepository().postNamemasterDb+"$companyId"
          ));
      log(UrlRepository().baseUrl+UrlRepository().postNamemasterDb+"$companyId");
      log(response.statusCode.toString());

      log(response.toString());

      if (response.statusCode == 200) {
        log(response.body.toString(), name: "name response");
        var body = await jsonDecode(response.body);
        log(response.body, name: "response");
        if (body["status"] == true) {
          Namedata namedata = Namedata.fromJson(body);
          log(namedata.toString());
          return {"status": "success", "data": namedata.data};
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
