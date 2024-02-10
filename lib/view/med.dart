



import 'package:flutter/material.dart';
import 'package:myapp/SERVICES/authservice.dart';
import 'package:myapp/constant/routes.dart';

import 'package:myapp/enums/menuaction.dart';

class Notesview extends StatefulWidget {
  const Notesview({super.key});

  @override
  State<Notesview> createState() => _NotesviewState();
}

class _NotesviewState extends State<Notesview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main ui"),backgroundColor: Colors.black,actions: [
        PopupMenuButton<MenuAction>(onSelected: (value) async {
          switch (value){
            
            case MenuAction.logout:
            final shouldLogut = await showLogutDialog(context);
            
              if(shouldLogut){
               await  Authservice.firebase().logout();
               if(mounted){
                 Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (_) => false);
               }
              
              }
          }
       },
       itemBuilder: (context){
          return  const [ PopupMenuItem<MenuAction>(value: MenuAction.logout,child:Text("logout"),)];
         
        },)
      ],),
      
    );
  }
}


Future<bool> showLogutDialog(BuildContext context){
 return showDialog<bool>(context: context, builder: (context){
   return AlertDialog(
     title: const  Text("Logut"),
     content: const Text("Are you sure? You want to logut"),
     actions: [
      TextButton(onPressed: (){ Navigator.of(context).pop(false);}, child: const  Text("Cancel")),
      TextButton(onPressed: (){ Navigator.of(context).pop(true);}, child: const  Text("Logut"))
     ],
   ) ;
  }).then((value) => value ?? false);
}