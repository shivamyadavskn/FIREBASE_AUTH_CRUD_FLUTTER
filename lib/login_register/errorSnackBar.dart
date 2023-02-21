import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickmeals/HomePage.dart';
import 'package:quickmeals/login_register/loginpage.dart';


class AuthUser {
  FirebaseAuth user = FirebaseAuth.instance;

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential x = await user.signInWithEmailAndPassword(
          email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text("LoggedIn id:${x.user?.uid}"),
      ));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage(email: x.user!.email,)));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text(e.code.toString()),
      ));
      print(e.code);
    }
  }

  //logoutPage
  void logout({required BuildContext context}) async {
    await user.signOut();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      content: Text("USER lOGOUT"),
    ));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LoginPage()));
  }

//create Regsiter
  void register(
      {required String email,
      required String password,
      required String confirmpassword,
      required BuildContext context}) async {
    try {
      if (password == confirmpassword) {
        UserCredential response = await user.createUserWithEmailAndPassword(
            email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(response.user!.email.toString()),
        ));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomePage(email: response.user?.email,)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Not Matched Password"),
        ));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(e.code),
      ));
    }
  }
}
