import 'package:app_firebase_auth/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/registration_bloc.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();
  String? errorText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registration'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controllerEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email@email.com',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                onChanged: (val) {
                  if (controllerConfirmPassword.text != val) {
                    errorText = 'Пароли не совпадают';
                  } else {
                    errorText = null;
                  }
                  setState(() {});
                },
                controller: controllerPassword,
                decoration: InputDecoration(
                  errorText: errorText,
                  border: const OutlineInputBorder(),
                  hintText: 'Passwor',
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                onChanged: (val) {
                  if (controllerPassword.text != val) {
                    errorText = 'Пароли не совпадают';
                  } else {
                    errorText = null;
                  }
                  setState(() {});
                },
                controller: controllerConfirmPassword,
                decoration: InputDecoration(
                  errorText: errorText,
                  border: const OutlineInputBorder(),
                  hintText: 'Confirm Passwor',
                ),
              ),
              const SizedBox(height: 25),
              BlocListener<RegistrationBloc, RegistrationState>(
                listener: (context, state) {
                  if (state is RegistrationSucces) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScren()));
                  }
                  if (state is RegistrationError) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text(
                          state.errorText,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  }
                },
                child: ElevatedButton(
                  onPressed: controllerPassword.text.isEmpty &&
                          controllerConfirmPassword.text.isEmpty &&
                          controllerEmail.text.isEmpty
                      ? null
                      : () {
                          BlocProvider.of<RegistrationBloc>(context)
                              .add(SendDataEvent(
                            email: controllerEmail.text,
                            password: controllerPassword.text,
                          ));
                        },
                  child: const Text('Registration'),
                ),
              ),
            ],
          ),
        ));
  }
}
