// @dart=2.9
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_tracking/blocs/fetchApplicationDataBloc/fetchAppBloc.dart';
import 'package:flutter_app_tracking/blocs/fetchApplicationDataBloc/fetchAppEvent.dart';
import 'package:flutter_app_tracking/blocs/fetchApplicationDataBloc/fetchAppState.dart';
import 'package:flutter_app_tracking/model/application_model.dart';
import 'package:flutter_app_tracking/repository/repository.dart';
import 'package:flutter_app_tracking/ui/list_item_details_view.dart';
import 'package:flutter_app_tracking/ui/login_view.dart';
import 'package:flutter_app_tracking/utils/contant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


var result =Contant.data.groupListsBy((element) => element['application_type_name']);
class HomeView extends StatefulWidget{

  @override
  _HomeViewState createState() =>_HomeViewState();

}
class _HomeViewState extends State<HomeView> {
 FetchAppBloc _fetchAppBloc;


  @override
  void initState() {

    _fetchAppBloc=BlocProvider.of<FetchAppBloc>(context);
    _fetchAppBloc.add(DoFetchAppEvent());
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Application List"),
        actions: [
          IconButton(onPressed:(){
          Repository().deleteToken();
          Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginView(),),);

          }, icon: Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
          child:
          BlocBuilder<FetchAppBloc,FetchAppState>(builder: (context,state){
            if(state is InitialState)
            {
              return CircularProgressIndicator();
            }
            else if(state is LoadingState){
              return CircularProgressIndicator();
            }
            else if(state is FetchSuccess){
              var listData=state.applicationModel;
              print("listview $listData");
              return listData?ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    String key = result.keys.elementAt(index);
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.all(15),
                          child: Text("${key}",
                          style: TextStyle(fontWeight: FontWeight.bold),),),
                          Container(
                            height: 150,
                            child:
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:result[key].length,
                              itemBuilder: (c, i) {
                                var data=result[key][i];

                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ListItemView(
                                      listItem:data ,
                                    )));
                                  },
                                  child:  Card(
                                    elevation: 8.0,
                                    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                    child: Container(
                                      width: 150,
                                      child:Column(
                                        children: [
                                          Container(
                                            width: 150,
                                            height: 100,
                                            child:Image.network("${Contant.url}"+"${data['logo_img']}"),
                                          ),

                                          Text("${data['applicant_name']}"),
                                        ],
                                      ) ,

                                    ),

                                  ),
                                );
                              },

                            ),),

                        ]);
                  }
              ):Center(child: Text("No Data"),) ;
            }
            else if(state is ErrorState){
               return  Text(state.message);
            }

          }),

    ),
    );

  }





@override
void dispose() {
  _fetchAppBloc.close();
  super.dispose();
}

}