import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UpdateItem extends StatefulWidget {
  const UpdateItem({super.key});

  @override
  State<UpdateItem> createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold( 
        body:Center( 
          child:Text("Update items")
        )
      );
  }
}