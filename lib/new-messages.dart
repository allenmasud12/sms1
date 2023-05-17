import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final controller = TextEditingController();
  final controller1 = TextEditingController();
  var enterData = '';
  var enterMessage = '';

  void inputData() async {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('number').add({
      'data': enterData.startsWith("01") ? "+88$enterData" : enterData,
      'is_sent': false,
      'message': "OTP: $enterMessage"
    });
    controller.clear();
    controller1.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(9),
      child: Column(
        children: [
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Number'),
            onChanged: (value) {
              setState(() {
                enterData = value;
              });
            },
          ),
          TextField(
            controller: controller1,
            decoration: InputDecoration(labelText: 'message'),
            onChanged: (value) {
              setState(() {
                enterMessage = value;
              });
            },
          ),
          TextButton(
            onPressed: enterData.trim().isEmpty ? null : inputData,
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
