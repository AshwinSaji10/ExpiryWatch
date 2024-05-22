import 'package:expiry_date_tracker/components/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expiry_date_tracker/components/add_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void addButton() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AddItems()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.only(right: 30,left:60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "ExpiryWatch",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                          (Route<dynamic> route) => false);
                    },
                    child: const Text("Sign Out"),
                  )
                ],
              ),
            ),
            Column(
              children: [
                ElevatedButton(onPressed: () {}, child: const Text("Hello")),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: addButton,
            child: const Text("+", style: TextStyle(fontSize: 20))),
      ),
    );
  }
}
