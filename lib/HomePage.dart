import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickmeals/addrecipesForm.dart';
import 'package:quickmeals/addrecipesForm.dart';
import 'package:quickmeals/addrecipesForm.dart';
import 'package:quickmeals/databases.dart';
import 'package:quickmeals/login_register/errorSnackBar.dart';
import 'package:quickmeals/viewPage.dart';

class HomePage extends StatefulWidget {
  final String? email;
  HomePage({super.key, this.email});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final fireStore = FirebaseFirestore.instance.collection('mealsDetails');
  final AuthUser user = AuthUser();
  final databasesdata = FireDatabase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
              onPressed: () {
                user.logout(context: context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => AddRecipes(
                        id: "787",
                      )));
        },
        child: const Icon(CupertinoIcons.plus),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('mealsDetails').snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const Text('PLease Wait')
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot products = snapshot.data!.docs[index];
                    return Container(
                      height: 200,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      color: CupertinoColors.inactiveGray,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            products['title'],
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ViewPage(
                                                products: products,
                                              )));
                                },
                                child: const Text(
                                  "View",
                                  style: TextStyle(
                                    backgroundColor:
                                        CupertinoColors.activeGreen,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // databasesdata.update(
                                  //     id: products.id,
                                  //     title: products['titile'],
                                  //     description: products['description'],
                                  //     imageLink: products['imagelink']);
                                  Navigator.push(context, MaterialPageRoute(builder: (_)=>AddRecipes(id: products.id)));
                                },
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(
                                    backgroundColor:
                                        CupertinoColors.activeGreen,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  databasesdata.detetes(id: products.id);
                                },
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(
                                    backgroundColor:
                                        CupertinoColors.destructiveRed,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
