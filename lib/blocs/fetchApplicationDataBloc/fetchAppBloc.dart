import 'package:flutter_app_tracking/blocs/fetchApplicationDataBloc/fetchAppEvent.dart';
import 'package:flutter_app_tracking/blocs/fetchApplicationDataBloc/fetchAppState.dart';
import 'package:flutter_app_tracking/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FetchAppBloc extends Bloc<FetchAppEvent,FetchAppState>{
  Repository repo;
  FetchAppBloc(FetchAppState initialState,this.repo) : super(initialState);

  @override
  Stream<FetchAppState> mapEventToState(FetchAppEvent fetchEvent) async*{
    if(fetchEvent is DoFetchAppEvent){
      yield LoadingState();
      try{
        var applicationModel=await repo.fetchData();
        yield FetchSuccess(applicationModel: applicationModel);

      }catch(e){
        yield ErrorState(message: e.toString());

      }
    }
  }

}
