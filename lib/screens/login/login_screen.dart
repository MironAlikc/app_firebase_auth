import 'package:app_firebase_auth/screens/home_screen/home_screen.dart';
import 'package:app_firebase_auth/screens/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerEmailforReset = TextEditingController();
  final storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
              controller: controllerPassword,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Passwor',
              ),
            ),
            const SizedBox(height: 25),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSucces) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScren()));
                }
                if (state is LoginError) {
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
                onPressed: () async {
                  await storage.write(
                      key: 'email', value: controllerEmail.text);
                  BlocProvider.of<LoginBloc>(context).add(SendLoginDataEvent(
                    email: controllerEmail.text,
                    password: controllerPassword.text,
                  ));
                },
                child: const Text('Login'),
              ),
            ),
            const SizedBox(height: 25),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: TextField(
                      controller: controllerEmailforReset,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Passwor',
                      ),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context).add(
                              ResetPasswordEvent(
                                  email: controllerEmailforReset.text),
                            );
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.send))
                    ],
                  ),
                );
              },
              child: const Text('Забыли пароль'),
            ),
          ],
        ),
      ),
    );
  }
}
