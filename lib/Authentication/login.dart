import 'package:flutter/material.dart';
import 'package:test1/Authentication/signup.dart';
import 'package:test1/model/users.dart';
import 'package:test1/services/database_helper.dart';

import '../screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final username = TextEditingController();
  final password = TextEditingController();

  //
  bool isVisible = false;

  bool isLoginTrue  = false;

  final db = DatabaseHelper();

  login () async {
    var response = await db.login(Users(usrName: username.text, usrPassword: password.text));
    if (response == true){
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }else{
      setState(() {
        isLoginTrue =true;
      });
    }
  }

  //
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
         child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
                children: [
            
                  //username field
                  Image.asset(
                  "assets/login.png",
                      width : 350,
                  ),
                  const SizedBox(height: 15),
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
            
                  const SizedBox(height: 10),
                  //login button
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
                                login();
                              }
                            },
                            child: const Text(
                              "LOGIN",
                              style: TextStyle(color: Colors.white),
                        ))
                  ),
            
                  //SignUp Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const Text("Don't have an account?"),
                      TextButton(onPressed: () {
                        //Navigation to Sign Up
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()));
                      },
                          child: const Text("SIGN UP"))
                  ],
                  ),

                  isLoginTrue? const Text (
                    "Username or password is incorrect",
                    style: TextStyle(color: Colors.red),
                  )
                      :const SizedBox(),
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}
