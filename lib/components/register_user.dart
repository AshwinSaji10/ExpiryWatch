// import 'package:flutter/cupertino.dart';
import 'package:expiry_date_tracker/providers/firebase_auth_provider.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:expiry_date_tracker/widgets/form_container_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:expiry_date_tracker/components/home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  // TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void navigateToLogin() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(context) {
    final theme=Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Register"),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              // const SizedBox(height: 30),
              // FormContainerWidget(
              //   hintText: "Username",
              //   controller: _usernameController,
              //   isPasswordField: false,
              // ),
              const SizedBox(height: 20),
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
                onTap: _signUp,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(child: Text("Register")),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                      onPressed: navigateToLogin, child: const Text("Login")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    // String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      // print("User successfully created");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) => const HomePage()),
        ),
      );
    } else {
      Fluttertoast.showToast(
          msg: "Unable to create user",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
