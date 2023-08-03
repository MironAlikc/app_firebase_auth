import 'package:app_firebase_auth/services/firebase_aurh_servise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.repo}) : super(LoginInitial()) {
    on<SendLoginDataEvent>((event, emit) async {
      try {
        await repo.login(
          email: event.email,
          password: event.password,
        );
        emit(LoginSucces());
      } catch (e) {
        emit(LoginError(
          errorText: e.toString(),
        ));
      }
    });
    on<ResetPasswordEvent>((event, emit) async {
      try {
        await repo.ressetPasword(email: event.email);
        emit(LoginSuccesSentEmail());
      } catch (e) {
        emit(LoginError(errorText: e.toString()));
      }
    });
  }

  final FireBaseAuthServise repo;
}
