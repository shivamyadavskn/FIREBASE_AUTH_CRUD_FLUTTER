import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireDatabase {
  final firestores = FirebaseFirestore.instance.collection('mealsDetails');

  void update({required String id,
      required String title,
      required String description,
      required String imageLink}) {
    firestores.doc(id).update({
      'title': title,
      'description': description,
      'imageLink': imageLink,
    }).then((value) {
      print("Updated");
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  //delete
Future<void> detetes({required String id})async {
    await firestores.doc(id).delete();
}


Future<void> addRecipes({ required String title,
  required String description,
  required String imageLink ,required BuildContext context})async {
    firestores.doc().set({
      'title': title,
      'Description': description,
      'imageLink': imageLink,
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text("Value Added"),
      ));
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }
}
