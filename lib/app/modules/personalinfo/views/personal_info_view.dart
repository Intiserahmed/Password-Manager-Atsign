import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sacred2/app/modules/password/controllers/password_controller.dart';

class PaymentView extends GetView<PasswordController> {
  @override
  Widget build(BuildContext context) {
    Get.put(PasswordController());

    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Obx(() {
            return ListView.builder(
                itemCount: controller.infoList.length,
                itemBuilder: (context, index) {
                  var item = controller.infoList[index];
                  return Card(
                    child: ListTile(
                      title: Text(
                          "${controller.infoList[index]['login']}.......${controller.infoList[index]['pass']}........${controller.infoList[index]['sacredkey']}"),
                    ),
                  );
                });
          }))
        ],
      ),
    );
  }
}
