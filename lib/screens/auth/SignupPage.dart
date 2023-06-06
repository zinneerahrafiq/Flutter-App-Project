import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';

class SignupPage extends StatefulWidget {
  static const String routeName = "/signup";

  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();

  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => SignupPage(),
      );
}

class _SignupPageState extends State<SignupPage> {
  bool themee = true;
  ThemeMode _themeMode = ThemeMode.system;
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpassController = TextEditingController();

  void CreateAccount() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cpass = confirmpassController.text.trim();

    if (email == "" || password == "" || cpass == "") {
      log("Please fill all the required fields!");
    } else if (password != cpass) {
      log("Passwords do not match");
    } else {
      try {
        UserCredential userDetails = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userDetails.user != null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Account created'),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                ],
              );
            },
          );
        }
        log("User Created.");
      } on FirebaseAuthException catch (error) {
        log(error.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.teal),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
                padding: EdgeInsets.only(top: 50),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    child: Image.asset("assets/thrift.jpg"),
                    height: 100,
                    width: 100,
                  ),
                )

                // size: 70,
                ),
            Center(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.25,
                    left: 35,
                    right: 35),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              changeTheme(ThemeMode.light);
                            },
                            child: Text('Light')),
                        ElevatedButton(
                            onPressed: () {
                              changeTheme(ThemeMode.dark);
                            },
                            child: Text('Dark')),
                      ],
                    ),
                    TextField(
                      maxLength: 50,
                      controller: emailController,
                      decoration: InputDecoration(
                        label: Text('Email'),
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          color: Colors.teal,
                          fontSize: 20,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'jazil10@gmail.com',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      maxLength: 20,
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        label: Text('Password'),
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          color: Colors.teal,
                          fontSize: 20,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                      ),
                    ),
                    TextField(
                      maxLength: 20,
                      obscureText: true,
                      controller: confirmpassController,
                      decoration: InputDecoration(
                        label: Text('Confirm Password'),
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          color: Colors.teal,
                          fontSize: 20,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Re-enter Password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 60, top: 30)),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: []),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          onPressed: () {
                            CreateAccount();
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.teal.shade800,
                            fixedSize: Size(300, 60),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 27,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.teal.shade800,
                        fixedSize: Size(200, 40),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
