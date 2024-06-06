import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
// import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:expiry_date_tracker/models/expiry_data.dart';
import 'package:expiry_date_tracker/providers/notification_provider.dart';

final dformatter = DateFormat("dd-MM-yyyy");

class UpdateItem extends StatefulWidget {
  const UpdateItem({super.key, this.item});

  final ExpiryData? item;

  @override
  State<UpdateItem> createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
  final TextEditingController _itemNameController = TextEditingController();

  @override
  void dispose() {
    _itemNameController.dispose();

    super.dispose();
  }

  DateTime? _selectedEndDate;
  void datePicker() async {
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

  void updateItem() async {
    final firestore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;

    // const uuid = Uuid();
    // int uniqueId = uuid.v4().hashCode;

    if (_itemNameController.text.isNotEmpty && _selectedEndDate != null) {
      await firestore.collection(uid!).doc("${widget.item!.uuid}").update(
        {
          "itemname": _itemNameController.text,
          "expirydate": _selectedEndDate,
        },
      );
      final NotificationProvider notificationProvider = NotificationProvider();
      notificationProvider.scheduleNotification(
        widget.item!.uuid!,
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
          backgroundColor: const Color.fromARGB(255, 48, 231, 7),
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("Please fill all fields")),
      // );
      Fluttertoast.showToast(
          msg: "Invalid fields!",
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Item"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 40.0, left: 10, right: 10),
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
        decoration: BoxDecoration(
            color: theme.colorScheme.primary,
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
                      margin: const EdgeInsets.only(left: 5),
                      child: const Text(
                        "Enter the new item name",
                      ),
                    ),
                  ],
                ),
                TextField(
                  maxLength: 50,
                  controller: _itemNameController,
                  style: theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                      hintText: "old name: ${widget.item!.itemName}",
                      hintStyle: theme.textTheme.bodyLarge,
                      // hintStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.tertiary),
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
                      margin: const EdgeInsets.only(left: 5),
                      child: const Text(
                        "Select the item expiry date",
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 50),
                GestureDetector(
                  onTap: () => datePicker(),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            _selectedEndDate == null
                                ? "old date: ${dformatter.format(widget.item!.expiryDate!)}"
                                : dformatter.format(_selectedEndDate!),
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: const Icon(Icons.calendar_month),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            const Center(
              child: Text(
                  "Note: Expiry reminders are sent 5 days before the selected date at 12 pm"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: updateItem,
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Update Item",
                        // style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        _selectedEndDate = null;
                        _itemNameController.text = "";
                      },
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Reset",
                        // style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
