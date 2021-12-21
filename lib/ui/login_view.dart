import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_tracking/blocs/auth/auth_bloc.dart';
import 'package:flutter_app_tracking/blocs/auth/auth_event.dart';
import 'package:flutter_app_tracking/blocs/auth/auth_state.dart';
import 'package:flutter_app_tracking/ui/home_view.dart';
import 'package:flutter_app_tracking/utils/colors.dart';
import 'package:flutter_app_tracking/utils/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget{
  @override
  _LoginViewState createState() =>_LoginViewState();

}
class _LoginViewState extends State<LoginView>{

  TextEditingController _userNameController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  bool isPasswordVisible=true;
  int countVisible=0;
  late AuthBloc _authBloc;
  _showMsg(msg){
    _scaffoldKey.currentState!.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor:MyColors.primaryColor,
          content:Text(msg),
        ));
  }

  
  @override
  void initState() {
    _authBloc=BlocProvider.of<AuthBloc>(context);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body:BlocListener<AuthBloc,AuthState>(
        listener:(context,state){
          if(state is UserLoginSuccessState){
             _showMsg("Your Login Is Successful!!");
             Future.delayed(const Duration(milliseconds: 1500), () {
               setState(() {
                 Navigator.pushReplacement(
                   context, MaterialPageRoute(builder: (context) => HomeView(),),);
               });
             });


          }
        },
        child:_loginForm(),
      )

    );
  }
  Widget _msg(){
    return  BlocBuilder<AuthBloc,AuthState>(builder: (context,state){
      if(state is LoginErrorState){
        return Text(state.message);
      }else if(state is LoginLoadingState){
        return Center(child:CircularProgressIndicator() ,);

      }else{
        return Container();
      }

    });
  }
  Widget _loginForm(){
    return Form(
      key: _formKey,
      child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assest/login.gif",width: 200,height:200,),
              SizedBox(height: 30,),
              _msg(),
              SizedBox(height: 30,),
              _usernameField(),
              _passwordField(),
              _loginButton(),
            ],
          ),
    );
}
  Widget  _passwordField(){
    return  Padding(
      padding: EdgeInsets.only(
          left: 20, right: 20, bottom: 10.0, top: 10.0),
      child: TextFormField(
        obscureText: isPasswordVisible,
        keyboardType: TextInputType.visiblePassword,
        controller: _passwordController,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),

        validator: (String? password){
          if(password!.isEmpty)
            return 'Required password' ;
          else
          return null;
        },
        onChanged: (value) {
          debugPrint('Something change in the  Title text field');
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: -6, horizontal: 15),
          suffixIcon: IconButton(
            onPressed: (){
              countVisible=countVisible+1;

              if(countVisible%2==0){
                setState(() {
                  isPasswordVisible=true;
                });
              }else{
                setState(() {
                  isPasswordVisible=false;
                });

              }

            },
            icon: Icon(isPasswordVisible?Icons.visibility_off:Icons.visibility),
          ),

          hintText: 'Enter  Password',
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
                color: Colors.grey, width: 1.0),
            gapPadding: 10,
          ),
          errorBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
                color: Colors.grey, width: 1.0),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
                color: Colors.grey, width: 1.0),
            gapPadding: 10,
          ),
          focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
                color: Colors.grey, width: 1.0),
            gapPadding: 10,
          ),
        ),
      ),
    );
 }
  Widget _usernameField(){
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10.0),
        child: TextFormField(
        keyboardType: TextInputType.text,
        controller: _userNameController,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        validator: (String? username) {
          if (username!.isEmpty)
            return 'Required username';
          else
            return null;
        },
        onChanged: (value) {
          debugPrint('Something change in the  Title text field');
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: -6, horizontal: 15),
          hintText: 'Enter Your username',
          labelStyle: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
                color: Colors.grey, width: 1.0),
            gapPadding: 10,
          ),
          errorBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
                color: Colors.grey, width: 1.0),
            gapPadding: 10,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
                color: Colors.grey, width: 1.0),
            gapPadding: 10,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
                color: Colors.grey, width: 1.0),
            gapPadding: 10,
          ),
        ),
      ),);

 }
  Widget _loginButton(){
    return Padding(
      padding: EdgeInsets.only(
          left: 20, right: 20, bottom: 10.0, top: 20),
      child: Container(
        width: double.infinity,
        height: 45,

        child: ElevatedButton(
          child: Text('${Strings.signIn}',
              style: TextStyle(fontSize: 20, color: Colors.white)),

          style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            elevation: 15.0,

          ),
          onPressed:() async{
            FocusScope.of(context).unfocus();
            if(_formKey.currentState!.validate()){
              // ignore: unnecessary_statements
            _authBloc.add(LoginButtonPress(username:_userNameController.text , password: _passwordController.text));
             /* Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) {
                return HomeView();
              }));
              debugPrint("login validation perfect");
           // _showMsg("YOur login info correct");  */
            }

          },
        ),
      ),
    );
 }

@override
  void dispose() {
    _userNameController.clear();
    _passwordController.clear();
    _authBloc.close();
    super.dispose();

  }

}