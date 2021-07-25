import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/id_controller.dart';

class IdView extends GetView<IdController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Text(
          'IdView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

