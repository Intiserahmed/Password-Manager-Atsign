import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/personal_info_controller.dart';

class PaymentView extends GetView<PersonalInfoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Payment is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
