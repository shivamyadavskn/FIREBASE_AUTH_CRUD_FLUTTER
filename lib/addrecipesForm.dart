import 'package:flutter/material.dart';
import 'package:quickmeals/databases.dart';

class AddRecipes extends StatefulWidget {
  final String id;
  AddRecipes({ required this.id});

  @override
  State<AddRecipes> createState() => _AddRecipesState();
}

class _AddRecipesState extends State<AddRecipes> {
  TextEditingController title = TextEditingController();
  TextEditingController decsription = TextEditingController();
  TextEditingController imageurl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final database= FireDatabase();

  String? validator(val) {
    if (val!.isEmpty) {
      return "Enter Value";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Add Recipes Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Icon(Icons.label_important,
                  color: Colors.deepPurple, size: 200),
            const Text(
              "Title",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
              TextFormField(
                controller: title,
                validator: validator,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      gapPadding: 6.0,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Decription",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              TextFormField(
                controller: decsription,
                validator: validator,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    )),
              ),
              const SizedBox(height: 20,),
              const Text(
                "imageUrl",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              TextFormField(
                controller: imageurl,
                validator: validator,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    )),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        database.addRecipes(title: title.text, description: decsription.text, imageLink: imageurl.text, context: context);
                      } else {
                        print("Else block");
                      }
                    },
                    child: Container(
                      height: 45,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: () {
                      database.update(id: widget.id, title: title.text, description: decsription.text, imageLink: imageurl.text);
                    },
                    child: Container(
                      height: 45,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.deepPurpleAccent,
                      ),
                      child: const Text(
                        "update",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
