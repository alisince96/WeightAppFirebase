import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weight_app_firebase/Auth/Auth.dart';
import 'package:weight_app_firebase/DatabaseServices/DatabaseServices.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is CheckLogin) {
      yield LoadingState();
      try {
        bool isLoggedIn = await Auth.login();
        if (isLoggedIn == true) {
          yield LoginSuccess();
        } else {
          yield LoginError(error: "Failed to login");
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
