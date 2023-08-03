import 'package:app_firebase_auth/screens/login/bloc/login_bloc.dart';
import 'package:app_firebase_auth/screens/registration/bloc/registration_bloc.dart';
import 'package:app_firebase_auth/screens/welcome_screen/welcome_screen.dart';
import 'package:app_firebase_auth/services/firebase_aurh_servise.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FireBaseAuthServise(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RegistrationBloc(
              repo: RepositoryProvider.of<FireBaseAuthServise>(context),
            ),
          ),
          BlocProvider(
            create: (context) => LoginBloc(
              repo: RepositoryProvider.of<FireBaseAuthServise>(context),
            ),
          ),
        ],
        child: const MaterialApp(
          home: WelcomeScreen(),
        ),
      ),
    );
  }
}
