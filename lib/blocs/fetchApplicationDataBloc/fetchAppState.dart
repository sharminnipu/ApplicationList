import 'package:equatable/equatable.dart';
import 'package:flutter_app_tracking/model/application_model.dart';

class FetchAppState extends Equatable{
  @override

  List<Object?> get props => [];

}
class InitialState extends FetchAppState{}
class LoadingState extends FetchAppState{}
class FetchSuccess extends FetchAppState{
  var applicationModel;
 // List<ApplicationModel> applicationModels;
  FetchSuccess({this.applicationModel});
}
class ErrorState extends FetchAppState{
  String message;
  ErrorState({required this.message});
}
