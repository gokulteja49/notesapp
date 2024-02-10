// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:myapp/SERVICES/authservice.dart';
import 'package:myapp/constant/routes.dart';


import 'package:myapp/view/loginview.dart';
import 'package:myapp/view/registerview.dart';

class VerifyEmailview extends StatefulWidget {
  const VerifyEmailview({super.key});

  @override
  State<VerifyEmailview> createState() => _VerifyEmailviewState();
}

class _VerifyEmailviewState extends State<VerifyEmailview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const Text("we've already sent email verification to your email"),
          const Text("if you have'nt click below button"),
          TextButton(
              onPressed: () async {
                await Authservice.firebase().sendEmailVerification();
              },
            
              child: const Text('send email verificaation'),),
              TextButton(onPressed:  () async{
                await Authservice.firebase().logout();
                 if(mounted){
                  Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
                 }

              }, child: const Text('Restart'))
        ],
      ),
    );
  }
}
