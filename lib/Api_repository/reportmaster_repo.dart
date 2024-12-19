import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;

class ApiReportRpository {
  Future createreportDB() async {
    try {
      Map<String, dynamic> params = {};
      Map<String, String> headers = {"Content-type": "apllication/json"};
      var response = await http.post(Uri.parse(""), body: jsonEncode(params));
      if (response.statusCode == 200) {
        var body = await jsonDecode(response.body);
      }
    } on SocketException {
      return {};
    } catch (e) {
      return {};
    }
  }

  Future listDB() async {
    try {
      var response = await http.get(Uri.parse(""));

      if (response.statusCode == 200) {
        var body = await jsonDecode(response.body);
        if (response.statusCode == 200) {
          var body = await jsonDecode(response.body);
          if (body["mesage"] == ["success"]) {
          } else {
            return {"status": "failed", "error": "network error"};
          }
        } else {
          return {"status": "failed", "error": "network error"};
        }
      } else {
        return {"status": "failed", "error": "network error"};
      }
    } on SocketException {
      return {"status": "failed", "error": "network error"};
    } catch (e) {
      return {"status": "failed", "error": "client error"};
    }
  }
}
