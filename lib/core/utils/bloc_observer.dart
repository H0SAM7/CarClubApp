import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserever implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log("change=$change");
  }

  @override
  void onClose(BlocBase bloc) {
    log("close=$bloc");
  }

  @override
  void onCreate(BlocBase bloc) {
    log("cearte=$bloc");
  }
  
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // TODO: implement onEvent
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
  }
}
