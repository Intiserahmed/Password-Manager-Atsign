import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sacred2/app/modules/password/views/passadd_view.dart';

import '../controllers/password_controller.dart';

class PasswordView extends GetView<PasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text(
            'PasswordView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Get.toNamed('/passadd'),
          label: Text('Add Password'),
          icon: Icon(Icons.add),
        ));
  }

}
