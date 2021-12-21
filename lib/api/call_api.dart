import 'dart:convert';
import 'package:flutter_app_tracking/repository/repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CallAPi {

  final  String _url="http://heal.dev.mpower-social.com/api/";

  postData(data,apiUrl) async{

    var fullUrl=_url+apiUrl;
    return http.post(fullUrl,
        body:data);
  }
  postDataWithAuth(data,apiUrl) async{
    var fullUrl=_url+apiUrl;
    var token= await  _getToken();
    return http.post(fullUrl,
        body:jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'JWT $token',
        });

  }
  _getToken() async {
    final _repo = Repository();
    final token = await _repo.getToken();
    print("token : $token");
    return token;
  }

}