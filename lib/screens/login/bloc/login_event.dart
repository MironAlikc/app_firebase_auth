part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class SendLoginDataEvent extends LoginEvent {
  final String email;
  final String password;
  SendLoginDataEvent({
    required this.email,
    required this.password,
  });
}

class ResetPasswordEvent extends LoginEvent {
  final String email;
  ResetPasswordEvent({required this.email});
}
