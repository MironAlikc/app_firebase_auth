import 'package:app_firebase_auth/services/firebase_aurh_servise.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc({required this.repo}) : super(RegistrationInitial()) {
    on<SendDataEvent>((event, emit) {
      try {
        repo.registation(email: event.email, password: event.password);
        emit(RegistrationSucces());
      } catch (e) {
        emit(RegistrationError(errorText: e.toString()));
      }
    });
  }
  final FireBaseAuthServise repo;
}
