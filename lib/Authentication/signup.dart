import 'package:flutter/material.dart';
import 'package:test1/Authentication/login.dart';
import 'package:test1/model/users.dart';

import '../services/database_helper.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final username = TextEditingController();
  final password = TextEditingController();
  final conformPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isVisible = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  //
                  const ListTile(
                    title: Text("Register new Account",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8 ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.3)
                    ),
                    child: TextFormField(
                      controller: username,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Username is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Username",
                      ),
                    ),
                  ),

                  //password field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8 ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.3)
                    ),
                    child: TextFormField(
                        controller: password,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Password is required";
                          }
                          return null;
                        },
                        obscureText: !isVisible,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.lock),
                            border: InputBorder.none,
                            hintText: "Password",
                            suffixIcon: IconButton(
                                onPressed: () {

                                  setState(() {
                                    isVisible= !isVisible;
                                  });
                                  //
                                }, icon: Icon(isVisible
                                ? Icons.visibility
                                : Icons.visibility_off)))
                    ),
                  ),

                  // Confirm password filed
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8 ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.3)
                    ),
                    child: TextFormField(
                        controller: conformPassword,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Password is required";
                          }else if(password.text != conformPassword.text){
                            return "Password doesn't match";
                          }
                          return null;
                        },
                        obscureText: !isVisible,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.lock),
                            border: InputBorder.none,
                            hintText: "Password",
                            suffixIcon: IconButton(
                                onPressed: () {

                                  setState(() {
                                    isVisible= !isVisible;
                                  });
                                  //
                                }, icon: Icon(isVisible
                                ? Icons.visibility
                                : Icons.visibility_off)))
                    ),
                  ),

                  //login button
                  const SizedBox(height: 10),
                  Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.deepPurple),
                      child: TextButton(
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              // login method
                              final db = DatabaseHelper();
                              db.signup(Users(usrName: username.text,
                                  usrPassword: password.text))
                                  .whenComplete(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const LoginScreen()));
                                  });
                            }
                          },
                          child: const Text(
                            "SIGN UP",
                            style: TextStyle(color: Colors.white),
                          ))
                  ),

                  //SignUp Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(onPressed: () {
                        //Navigation to Sign Up
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                          child: const Text("LOGIN"))
                    ],)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

