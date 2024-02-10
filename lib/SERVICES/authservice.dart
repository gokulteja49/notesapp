

import 'package:myapp/SERVICES/firebaseauthprovider.dart';


import 'authprovider.dart';
import 'authuser.dart';



class Authservice  implements Authprovider{
  final Authprovider provider;
  const Authservice(this.provider);
  factory Authservice.firebase()=> Authservice(Firebaseauthprovider());
  
  @override
  Future<AuthUser> createuser({required String email, required String password}) => provider.createuser(email: email, password: password);
  
  @override
  
  AuthUser? get currentuser => provider.currentuser;
  
  @override
  Future<AuthUser> login({required String email, required String password}) => provider.login(email: email, password: password);
  
  @override
  Future<void> logout() => provider.logout();
  
  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();
  
  @override
  Future<void> initialize() => provider.initialize();

}