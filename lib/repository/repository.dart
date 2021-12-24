import 'dart:convert';
import 'package:flutter_app_tracking/api/call_api.dart';
import 'package:flutter_app_tracking/utils/contant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Repository{
  late Box box;
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }
  Future<String?> getToken()async{
    var value = await storage.read(key: 'token');
    return value;
  }
  Future<void> persistToken(String token) async {
    await storage.write(key: 'token', value: token);
  }
  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }
  Future login(String userName,String password) async {
    var data= {
      'username': userName,
      'password':password
    };
    try{
      final response = await CallAPi().postData(data,'login/');
      var body=json.decode(response.body);
      if (response.statusCode == 200) {
        return body;
      } else if(response.statusCode == 400){
        return body;
      }
      else {
        throw Exception('Failed to post');
      }
    }catch(SocketException){
      print("No Internet");
    }

  }
  Future <bool> fetchData() async {
    await openBox();

     try{
       final response = await CallAPi().postDataWithAuth(null,'mobile/application_list/');
       if (response.statusCode == 200) {
         var body=(json.decode(utf8.decode(response.bodyBytes)));
        // var body= json.decode(response.body);
         Contant.appData=body['data'];
         await addData(Contant.appData);
         // data.map((app)=>application.add(ApplicationModel.fromJson(app))).toList();
         // print("fetdata: $application");
       } else {
         throw Exception('Failed to post');
       }
     }catch(SocketException){
       print("No Internet");
     }
    var getDataFromDb=box.toMap().values.toList();
    if(getDataFromDb.isEmpty){
      Contant.data.add("Empty");
    }else{
      Contant.data=getDataFromDb;
    }
    return Future.value(true);

  }
  Future openBox() async{
  var dir=await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  box= await Hive.openBox('data');
  return;
  
  }
  Future addData(data) async{
    await box.clear();
    for(var d in data){
      box.add(d);

    }
 }

}