// import 'package:flutter/cupertino.dart';
import 'dart:ui';

import 'package:expiry_date_tracker/components/register_user.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:expiry_date_tracker/widgets/form_container_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expiry_date_tracker/components/home_page.dart';
import 'package:expiry_date_tracker/providers/firebase_auth_provider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  bool _isSigning=false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }



  void navigateToRegister(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterPage()));

  }

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("ExpiryWatch Login"),
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 30),
                FormContainerWidget(
                  hintText: "Email",
                  controller: _emailController,
                  isPasswordField: false,
                ),
                const SizedBox(height: 20),
                FormContainerWidget(
                  hintText: "Password",
                  controller: _passwordController,
                  isPasswordField: true,
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: _signIn,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child:_isSigning? const CircularProgressIndicator(color:Colors.white): const Text("Login")),
                  ),
                ),
                const SizedBox(height: 5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const Text("Dont have an account?"),
                  TextButton(onPressed: navigateToRegister, child: const Text("Register")),
                ],)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {

    setState(() {
      _isSigning=true;
    });
    

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
       _isSigning=false;
    });
   

    if (user != null) {
      print("User Signed In");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => const HomePage()),
        ),
      );
    } else {
      print("Error! Unable to sign in");
      // setState(() {
      //   const SnackBar(content: Text("Invalid credentials!",style: TextStyle(color: Colors.red),),);
      // });
      
    }
  }
}
