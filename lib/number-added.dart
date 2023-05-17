import 'package:flutter/material.dart';

class NumberAdded extends StatelessWidget {
 final String data;
 final String message;
 final bool is_sent;

 NumberAdded(
     this.data,
     this.message,
     this.is_sent
 );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$data',
            style: TextStyle(
            fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
            Text(message,style: TextStyle(
              fontSize: 16,
              color: Colors.red
            ),),
            Text("Sent: $is_sent",style: TextStyle(
                fontSize: 16,
                color: is_sent ? Colors.green.shade800 : Colors.black,
            ),)
          ],
        ),
      ),
    );
  }
}
