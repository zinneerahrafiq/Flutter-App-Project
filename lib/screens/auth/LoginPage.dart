import 'dart:developer';

import 'package:ecom/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();

  static Route route() => MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => LoginPage(),
      );
}

class _LoginPageState extends State<LoginPage> {
  bool themee = true;
  ThemeMode _themeMode = ThemeMode.system;
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == "" || password == "") {
      log("Please Fill all the fields!");
    } else {
      try {
        UserCredential userDetails = await FirebaseAuth.instance
            .signInWithCredential(EmailAuthProvider.credential(
          email: email,
          password: password,
        ));
        if (userDetails.user != null) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Logging in'),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, "/"); // Navigate to LoginPage
                    },
                  ),
                ],
              );
            },
          );
        }
        log("Login Successful.");
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
                    child: Icon(Icons.shopping_cart),
                    height: 80,
                    width: 80,
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
                    Padding(padding: EdgeInsets.only(left: 60, top: 30)),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          onPressed: () async {
                            login();
                          },
                          child: Text('Log In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w100)),
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
