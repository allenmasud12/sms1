import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sms1/number-added.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({Key? key}) : super(key: key);

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('data/iunityhZVPYgEUCYBwde/number')
          .snapshots(),
      builder: (ctx, streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final documents = streamSnapshot.data!.docs;
        return ListView.builder(
          key: UniqueKey(),
          reverse: true,
          itemCount: documents.length,
          itemBuilder: (ctx, index) => NumberAdded(
            documents[index]['data'],
            documents[index]['message'],
          ),
        );
      },
    );
  }
}
