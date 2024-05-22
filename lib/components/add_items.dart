import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class AddItems extends StatefulWidget {
  const AddItems({super.key});
  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  // DateTime? _selectedStartDate = null;
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

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 40.0, left: 10, right: 10),
          child: Column(
            children: [
              const TextField(
                maxLength: 50,
                decoration: InputDecoration(
                    label: Text("Enter item name"),
                    border: OutlineInputBorder()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  Row(
                    children: [
                      Text(_selectedEndDate == null
                          ? "Select the Expiry Date"
                          : formatter.format(_selectedEndDate!)),
                      IconButton(
                          onPressed: () => datePicker("end"),
                          icon: const Icon(Icons.calendar_month))
                    ],
                  )
                ],
              ),
              ElevatedButton(onPressed: (){}, child: const Text("Add Item")),
              ElevatedButton(onPressed: (){}, child: const Text("Reset"))
            ],
          ),
        ),
      ),
    );
  }
}
