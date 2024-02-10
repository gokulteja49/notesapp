
import 'package:flutter/material.dart';
import 'package:myapp/SERVICES/authservice.dart';
import 'package:myapp/constant/routes.dart';
import 'package:myapp/view/loginview.dart';
import 'package:myapp/view/registerview.dart';
import 'package:myapp/view/verifyemail.dart';
import 'package:myapp/view/med.dart';
// ignore: unused_import
import "dart:developer" as devtools show log; 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
     
      home: const Homepage(),
      routes: {
        loginRoute:(context) => const Loginview(),
        registerRoute:(context) => const  Registerview(),
        notesRoute:(context) => const Notesview(),
        verifyemailroute :(context) => const VerifyEmailview(),
      },
    );
  }
}
class Homepage extends StatelessWidget {
  const Homepage
({super.key});

  @override
  Widget build(BuildContext context) {
   
    return FutureBuilder(
      future: Authservice.firebase().initialize(),
      builder:(context, snapshot) {
        switch(snapshot.connectionState){
           case ConnectionState.done:
            final user = Authservice.firebase().currentuser;
            if(user!=null){
              if(user.isEmailVerified){
               return const Notesview();
                }
               else {
              return const VerifyEmailview();
            } 
            }else{
              return const Loginview();
            }
            
         
      default:
      return const CircularProgressIndicator();
       
       }
      },
    );

    
  }
 
}

