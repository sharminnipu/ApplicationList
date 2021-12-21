import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_tracking/utils/contant.dart';
import 'package:url_launcher/url_launcher.dart';

class ListItemView extends StatefulWidget{
  final  listItem;
  ListItemView({this.listItem});

  @override
 _ListItemViewState createState()=>_ListItemViewState();

}
class _ListItemViewState extends State<ListItemView>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Application Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width : MediaQuery.of(context).size.width,
            height: 200 ,
              child:Image.network("${Contant.url}"+"${widget.listItem['logo_img']}"),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(padding: EdgeInsets.all(15),
            child: Text("${widget.listItem['applicant_name']}",textAlign: TextAlign.center,)),
          Padding(padding: EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: (){
              appOpen(widget.listItem['package_name'],widget.listItem['applicant_name'],widget.listItem['weblink']);
            },
            child: Text("Go Application"),
          ),),
          Padding(padding: EdgeInsets.all(15),
              child: Text("${widget.listItem['introduction']}",textAlign: TextAlign.center,)),
       ],
    )
      ),
    );

  }
  void appOpen(String packageName,String applicationName,String webLink) async{

    if(packageName==null|| packageName==""){
      if(webLink!=null){
        _launchInBrowser(webLink);
      }else{
        print("Web link also null");
      }
    }else{
      bool isInstalls= await LaunchApp.isAppInstalled(
        androidPackageName: '$packageName',
        iosUrlScheme: '$applicationName://',
      );
      if(isInstalls){
        await LaunchApp.openApp(
          androidPackageName: '$packageName',//androdi appa open
          iosUrlScheme: '$applicationName://',//iso app open
        );
      }else{
        if(webLink!=null){
          _launchInBrowser(webLink);
        }
      }

    }


  }
  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    )) {
      throw 'Could not launch $url';
    }
  }

}

