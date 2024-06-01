// import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:expiry_date_tracker/providers/firebase_auth_provider.dart';
// import 'package:expiry_date_tracker/components/login_page.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:expiry_date_tracker/providers/notification_provider.dart';

final formatter = DateFormat("dd-MM-yyyy");

class AddItems extends StatefulWidget {
  const AddItems({super.key});
  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  // DateTime? _selectedStartDate = null;

  TextEditingController _itemNameController = TextEditingController();

  @override
  void dispose() {
    _itemNameController.dispose();

    super.dispose();
  }

  DateTime? _selectedEndDate = null;
  void datePicker(String time) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 10, now.month, now.day);
    final lastDate = DateTime(now.year + 10, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      // if (time == "start") {
      //   _selectedStartDate = pickedDate;
      // } else {
      _selectedEndDate = pickedDate;
      // }
    });
  }

  void addItem() async {
    final firestore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;

    if (_itemNameController.text.isNotEmpty && _selectedEndDate != null) {
      await firestore.collection(uid!).doc(_itemNameController.text).set(
        {
          "itemname": _itemNameController.text,
          "expirydate": _selectedEndDate,
        },
      );
      final NotificationProvider notificationProvider = NotificationProvider();
      notificationProvider.scheduleNotification(
        'Expiry Reminder',
        '${_itemNameController.text} is expiring soon!',
        _selectedEndDate!,
      );
      // notificationProvider.checkPendingNotificationRequests();
      Fluttertoast.showToast(
          msg: "Item added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 48, 231, 7),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("Please fill all fields")),
      // );
      Fluttertoast.showToast(
          msg: "Empty fields!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    // Navigator.pop(context);
  }

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Add a new item"),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 40.0, left: 10, right: 10),
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
          decoration: BoxDecoration(
              color: const Color.fromARGB(118, 68, 137, 255),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container( 
                        margin: const EdgeInsets.only(left:5),
                        child:
                      const Text("Enter the item name")),
                    ],
                  ),
                  TextField(
                    maxLength: 50,
                    controller: _itemNameController,
                    decoration: InputDecoration(
                      hintText: "Eg: Laptop warranty",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container( 
                        margin: const EdgeInsets.only(left:5),
                        child:
                      const Text("Select the item expiry date")),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Text(_selectedStartDate == null
                  //         ? "Start Date"
                  //         : formatter.format(_selectedStartDate!)),
                  //     IconButton(
                  //         onPressed: () => datePicker("start"),
                  //         icon: const Icon(Icons.calendar_month))
                  //   ],
                  // ),
                  // const SizedBox(width: 50),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container( 
                          margin: const EdgeInsets.only(left:10),
                          child:
                          Text(_selectedEndDate == null
                            ? "No Date Selected"
                            : formatter.format(_selectedEndDate!))),
                        IconButton(
                            onPressed: () => datePicker("end"),
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ),
                  )
                ],
              ),
              Center( 
                child:
                const Text("Note: Expiry reminders are sent 5 days before the selected date at 12 noon")),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: addItem,
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(147, 68, 137, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(child: Text("Add Item")),
                    ),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedEndDate = null;
                        _itemNameController.text = "";
                      });
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(147, 68, 137, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(child: Text("Reset")),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
