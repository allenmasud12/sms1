import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms1/number-added.dart';
import 'package:flutter_sms/flutter_sms.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({Key? key}) : super(key: key);

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  List<Map<dynamic, dynamic>> numbers = [];

  @override
  void initState() {
    super.initState();
    checkForOtpRequest();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('number').snapshots(),
      builder: (ctx, streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final documents = streamSnapshot.data!.docs;
        numbers = documents
            .map((e) => {
          "data": e["data"],
          "message": e["message"],
          "is_sent": e['is_sent'],
          "id": e.id
        })
            .toList();
        return ListView.builder(
          key: UniqueKey(),
          reverse: true,
          itemCount: documents.length,
          itemBuilder: (ctx, index) => NumberAdded(
            documents[index]['data'],
            documents[index]['message'],
            documents[index]['is_sent'],
          ),
        );
      },
    );
  }

  void checkForOtpRequest() async {
    print("CHECKING FOR OTP REQUEST");
    print("current list size: ${numbers.length}");

    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i]['is_sent'] == false) {
        print("sending sms to: ${numbers[i]['data']}");

        List<String> recipients = [numbers[i]['data']];
        String message = numbers[i]['message'];

        await sendSMS(message: message, recipients: recipients);

        await FirebaseFirestore.instance
            .collection("number")
            .doc(numbers[i]["id"])
            .update({"is_sent": true});

        setState(() {
          numbers[i]['is_sent'] = true;
        });
      }
    }

    await Future.delayed(const Duration(seconds: 3));
    checkForOtpRequest();
  }
}
