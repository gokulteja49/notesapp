import 'package:myapp/SERVICES/authuser.dart';
abstract class Authprovider{
  Future<void> initialize();
  AuthUser? get currentuser;
  Future<AuthUser> login({
    required String email,
    required String password
  });
  Future<AuthUser> createuser({
     required String email,
    required String password
  });
  Future<void> logout();
  Future<void> sendEmailVerification();
}