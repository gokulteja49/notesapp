// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:myapp/SERVICES/authexception.dart';
import 'package:myapp/SERVICES/authservice.dart';

import 'package:myapp/constant/routes.dart';
import 'package:myapp/utilites/errordialog.dart';

import "dart:developer" as devtools show log;

class Loginview extends StatefulWidget {
  const Loginview({Key? key}) : super(key: key);

  @override
  State<Loginview> createState() => _LoginViewState();
}

class _LoginViewState extends State<Loginview> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter your email here',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter your password here',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await Authservice.firebase()
                    .login(email: email, password: password);
                final user = Authservice.firebase().currentuser;
                if (user?.isEmailVerified ?? false) {
                  if (mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      notesRoute,
                      (route) => false,
                    );
                  }
                } else {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyemailroute, (route) => false);
                }
              } on UserNotFoundAuthException {
                if (mounted) {
                  await showErrorDialog(context, 'user not found');
                }
              } on WrongpasswordAuthException {
                if (mounted) {
                  await showErrorDialog(context, 'Wrong PsASSWORD');
                }
              } on GenericAuthException {
                if (mounted) {
                  await showErrorDialog(context, "AUTHENTICATION ERROR");
                }
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Not registered yet? Register here!'),
          )
        ],
      ),
    );
  }
}
