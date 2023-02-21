import 'package:flutter/material.dart';
import 'package:quickmeals/login_register/errorSnackBar.dart';
import 'package:quickmeals/login_register/loginpage.dart';


class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final AuthUser _AuthUser = AuthUser();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController confirmpassword = TextEditingController();
    String? validator(val) {
      if (val!.isEmpty) {
        return "Enter Value";
      } else {
        return null;
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Register Page"),
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
              TextFormField(
                controller: email,
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
              TextFormField(
                controller: password,
                validator: validator,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                )),
              ),
              TextFormField(
                controller: confirmpassword,
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter value confirm";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                )),
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // login(email: email.text, password: password.text);
                    _AuthUser.register(
                        email: email.text,
                        password: password.text,
                        context: context,
                        confirmpassword: confirmpassword.text);
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
                    "Register",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => LoginPage()));
                  },
                  child: const Text("Login Page"))
            ],
          ),
        ),
      ),
    );
  }
}
