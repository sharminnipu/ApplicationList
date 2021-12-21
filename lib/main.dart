// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_tracking/blocs/auth/auth_bloc.dart';
import 'package:flutter_app_tracking/blocs/auth/auth_state.dart';
import 'package:flutter_app_tracking/blocs/fetchApplicationDataBloc/fetchAppBloc.dart';
import 'package:flutter_app_tracking/blocs/fetchApplicationDataBloc/fetchAppState.dart';
import 'package:flutter_app_tracking/repository/repository.dart';
import 'package:flutter_app_tracking/ui/home_view.dart';
import 'package:flutter_app_tracking/ui/login_view.dart';
import 'package:flutter_app_tracking/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: MyColors.primaryColor,
      statusBarBrightness:Brightness.dark,//top bar color
      // statusBarIconBrightness: Brightness.dark, // don't use this
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var initialRoute = 'login';
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  var token = await storage.read(key: 'token');
  if (token!=null) {
    initialRoute = 'home';
  }
  else{
    initialRoute = 'login';
  }
  /* Repository repository=Repository();
  var token =repository.getToken();
  if (token!=null) {
      initialRoute = 'home';
      }
      else{
      initialRoute = 'login';
      }   */
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  MyApp({this.initialRoute});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
        BlocProvider(create: (context)=>AuthBloc(LoginInitState(), Repository()),),
        BlocProvider(create: (context)=>FetchAppBloc(InitialState(), Repository()),)
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: MyColors.primaryColor,
          accentColor: MyColors.primaryColor,
        ),
        initialRoute: initialRoute,
        routes: {
          'login': (context) => LoginView(),
          'home': (context) =>HomeView(),
        }
    ),
    );
  }
}

