# Application List

A new Flutter application.

## Introduction

This project is a starting point for a Flutter application with Bloc pattern.

Story:
One user wants to see all of his developed application or website from a
single application. He has API to provide the information. But he needs a mobile
application for android and IOS for offline and online use. If any application is
installed in his device it’ll open from that application rather than go to website link.

## Features
- [Login](#login)
- [Show List of application](#show-list)
- [Show Details of application](#edit-note)
- [Any application is installed it’ll open from this application]("browser")

## Architecture
  B.L.o.C. stands for Business Logic Components (or simply blocs from here on out). This pattern was first revealed at Dart Conference 2018, aka DartConf, and it's purpose is to make UI business logic highly reusable. Specifically at DartConf, it was presented as a nice way to share all UI logic between Flutter and AngularDart.

  The bloc pattern's mantra is that widgets should be as dumb as possible, and the business logic should live in separate components. This in itself isn't unique, compared to other approaches, but the devil is in the details. In general, blocs are what they are for two main reasons:

  Their public API consists of simple inputs and outputs only.
  Blocs should be injectable, which means platform agnostic. This means you can use the same blocs for Flutter, AngularDart, on the server, etc.

## Working process

#Events
Events tell BLoC to do something. An event can be fired from anywhere, such as from a UI widget. External events, such as changes in network connectivity, changes in sensor readings, etc., look like this:

class RotateEvent {
  final double angle;

  const RotateEvent(this.angle);

  @override
  List<Object> get props => [angle];
}
#BLoC
BLoC is a man in the middle. All the business logic sits inside the BLoC file. It simply accepts events, performs the logic, and outputs the states. Here’s how it looks:

class TransformationBloc
    extends Bloc<TransformationEvent, TransformationState> {
  TransformationBloc() : super(RotatedState(angle: 0);

  @override
  Stream<TransformationState> mapEventToState(
      TransformationEvent event) async* {
    if (event is RotateEvent) {
      yield RotatedState(angle: event.angle);
    }
  }
}
#States
States represent the information to be processed by any widget. A widget changes itself based on the state.

class RotatedState {
  final double angle;

  const RotatedState({@required this.angle});

  @override
  List<Object> get props => [angle];
}

## Plugin used
 - http
 - collection
 - flutter_secure_storage
 - external_app_launcher
 - flutter_bloc
 - equatable
 -hive_flutter
 -url_launcher





