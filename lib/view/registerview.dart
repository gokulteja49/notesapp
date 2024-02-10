// ignore_for_file: unused_import


import 'package:flutter/material.dart';
import 'package:myapp/SERVICES/authexception.dart';
import 'package:myapp/SERVICES/authservice.dart';

import 'package:myapp/constant/routes.dart';
import 'package:myapp/utilites/errordialog.dart';
import 'package:myapp/view/loginview.dart';

import "dart:developer" as devtools show log;

class Registerview extends StatefulWidget {
  const Registerview({super.key});

  @override
  State<Registerview> createState() => _RegisterviewState();
}

class _RegisterviewState extends State<Registerview> {
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
        title: const Text("Register"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'enter your email'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            decoration: const InputDecoration(hintText: 'enter your password'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                Authservice.firebase().createuser(email: email, password: password);
                await Authservice.firebase().createuser(email: email, password: password);
                       Authservice.firebase().sendEmailVerification();
                  Navigator.of(context).pushNamed(verifyemailroute);
              } on WeakpasswordAuthException {
                 if (mounted) {
                    await showErrorDialog(context, "weak password");
                  }
              } 
              on EmailalreadyinuseAuthException{
                if (mounted) {
                    await showErrorDialog(context, 'email already used');
                  }
              }on InavlidemailAuthException {
                 if (mounted) {
                    await showErrorDialog(context, 'invalid email');
                  }
              } on  GenericAuthException {
                 if (mounted) {
                    await showErrorDialog(context, 'Failed to register');
                  }
              }
              
            },
            child: const Text('register'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text("Already registred?! Login"))
        ],
      ),
    );
  }
}
