import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable{
  @override
  List<Object?> get props =>[];
}
class StartEvent extends AuthEvent{}
class LoginButtonPress extends AuthEvent{
  final String username;
  final String password;

  LoginButtonPress({required this.username,required this.password});

}