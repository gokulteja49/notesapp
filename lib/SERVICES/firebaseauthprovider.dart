

import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/firebase_options.dart';

import 'authprovider.dart';
import 'authexception.dart';
import 'authuser.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;

class Firebaseauthprovider implements Authprovider {
  @override
Future<AuthUser> createuser({required String email, required String password}) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    final user = currentuser;
    if (user != null) {
      return user;
    } else {
      throw UserNotloggedinAuthException();
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      throw WeakpasswordAuthException();
    } else if (e.code == 'email-already-in-use') {
      throw EmailalreadyinuseAuthException();
    } else if (e.code == 'invalid-email') {
      throw InavlidemailAuthException();
    } else {
      // Handle other FirebaseAuthException or rethrow as GenericAuthException
      throw GenericAuthException();
    }
  } 
}

@override
Future<AuthUser> login({required String email, required String password}) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    final user = currentuser;
    if (user != null) {
      return user;
    } else {
      throw UserNotloggedinAuthException();
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      throw WeakpasswordAuthException();
    } else if (e.code == 'email-already-in-use') {
      throw EmailalreadyinuseAuthException();
    } else if (e.code == 'invalid-email') {
      throw InavlidemailAuthException();
    } else {
      // Handle other FirebaseAuthException or rethrow as GenericAuthException
      throw GenericAuthException();
    }
  } catch (e) {
    // Handle non-FirebaseAuthException or rethrow as GenericAuthException
    throw GenericAuthException();
  }
}


  @override
  Future<void> logout() async {
   final user = FirebaseAuth.instance.currentUser;
   if(user != null){
   await FirebaseAuth.instance.signOut();
   }else{
    throw UserNotloggedinAuthException();
   }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotloggedinAuthException();
    }
  }

  @override
  AuthUser? get currentuser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }
  
  @override
  Future<void> initialize() async{
    
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  }
}
