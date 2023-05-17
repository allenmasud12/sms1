import 'package:flutter/material.dart';

import 'new-messages.dart';
import 'number_screen.dart';

class Screen extends StatelessWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: NumberScreen()
            ),
            NewMessages(),
          ],
        ),
      ),
    );
  }
}
