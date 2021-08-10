part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoadingState extends LoginState {}

class LoginError extends LoginState {
  final String error;
  LoginError({this.error});
}

class LoginSuccess extends LoginState {
  final String error;
  LoginSuccess({this.error});
}
