import 'package:firebase_auth/firebase_auth.dart';
import 'package:houseshare/helper/helper_function.dart';
import 'package:houseshare/service/database_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // register
  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        // call our database service to update the user data.
        await DatabaseService(uid: user.uid).savingUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // signout
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }

  static Future<String> getAccessToken() async {
    final accessTokenUri =
        Uri.parse('https://api.kroger.com/v1/connect/oauth2/token');

    final accessTokenResponse = await http.post(
      accessTokenUri,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization":
            "Basic aG91c2VzaGFyZS00MzUyZTgxMmIwYTI1ZDA1ZjZjZjYzOWZhZGZhZjI1MTI2NzUwMzY5MzY2NzkyMjU0NzpwQTAteEVtd0h5QXlwclpqbWNTdi02elVoSUM4ajlHaUZ6UzdrMlFp"
      },
      body: {"grant_type": "client_credentials", "scope": "product.compact"},
    );

    final Map<String, dynamic> data = jsonDecode(accessTokenResponse.body);
    return data['access_token'];
  }
}
