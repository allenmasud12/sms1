import 'package:flutter/material.dart';

class NumberAdded extends StatelessWidget {
 final int data;
 final String message;

 NumberAdded(
     this.data,
     this.message
     );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$data',
        style: TextStyle(
        fontSize: 20,
          fontWeight: FontWeight.bold
        ),),
        Text(message,style: TextStyle(
          fontSize: 16,
          color: Colors.red
        ),)
      ],
    );
  }
}
