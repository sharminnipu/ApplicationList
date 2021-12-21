import 'package:flutter_app_tracking/blocs/auth/auth_event.dart';
import 'package:flutter_app_tracking/blocs/auth/auth_state.dart';
import 'package:flutter_app_tracking/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
   Repository repository;
  AuthBloc(AuthState initialState,this.repository) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvent authEvent) async*{
    if(authEvent is StartEvent){
      yield LoginInitState();
    }else if(authEvent is LoginButtonPress){
      yield LoginLoadingState();
      var data= await repository.login(authEvent.username, authEvent.password);
      if(data['token']!=null){
        repository.persistToken(data['token']);
        yield UserLoginSuccessState();
      }else if(data['non_field_errors']!=null){
        var result=data['non_field_errors'][0];
        yield LoginErrorState(message: result);
      }

    }else{
      yield LoginErrorState(message: "Authentication Error");
    }

  }


}
