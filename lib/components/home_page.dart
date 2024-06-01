import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expiry_date_tracker/components/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expiry_date_tracker/components/add_items.dart';
// import 'package:flutter/widgets.dart';
import 'package:expiry_date_tracker/models/expiry_data.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void addButton() async {
    // final User? user = auth.currentUser;
    // final uid = user?.uid;
    // final itemCollection = FirebaseFirestore.instance.collection(uid!);
    // print(uid);

    // QuerySnapshot querySnapshot = await itemCollection.get();
    // List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    // for (var doc in documents) {
    //   print(doc.data());
    // }
    setState(() {
      Navigator.push(
          context, CupertinoPageRoute(builder: (context) => const AddItems()));
    });
  }

  // void deleteItem(){

  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.only(right: 30, left: 60),
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
            // Text(uid),
            Expanded(
              child: StreamBuilder<List<ExpiryData>>(
                stream: _readData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if ((snapshot.data!).isEmpty) {
                    return const Center(child: Text("No items yet"));
                  }
                  final items = snapshot.data;
                  // formatter=DateFormat('dd mm yy');
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: items!.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(127, 68, 137, 255),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ListTile(
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  final User? user = auth.currentUser;
                                  final uid = user?.uid;
                                  final itemCollection = FirebaseFirestore
                                      .instance
                                      .collection(uid!);
                                  itemCollection.doc(item.itemName!).delete();
                                  Fluttertoast.showToast(
                                      msg: "Item deleted",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor:
                                          const Color.fromARGB(255, 231, 18, 7),
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                              GestureDetector(
                                child: const Icon(Icons.arrow_forward_ios),
                                onTap: () {},
                              ),
                            ],
                          ),
                          title: Text(item.itemName!),
                          subtitle: Text(formatter.format(item.expiryDate!)),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 80)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addButton,
          child: const Text(
            "+",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Stream<List<ExpiryData>> _readData() {
    final User? user = auth.currentUser;
    final uid = user?.uid;

    final itemCollection = FirebaseFirestore.instance.collection(uid!);
    // print(itemCollection);

    return itemCollection.snapshots().map((querySnapshot) => querySnapshot.docs
        .map(
          (item) => ExpiryData.fromSnapshot(item),
        )
        .toList());
  }
}
