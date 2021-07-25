import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PassaddView extends GetView {
  
  @override
  Widget build(BuildContext context) {
   GlobalKey<FormState> formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: Text('Add Password')),
      body: Center(
        child: Text(
          'PassaddView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
