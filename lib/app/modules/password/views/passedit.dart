import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:sacred2/app/modules/password/controllers/password_controller.dart';
import 'package:get/get.dart';

class EditPassWord extends GetView<PasswordController> {
  const EditPassWord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PasswordController());
    var _data = Get.arguments;
    controller.loginEditingController!.text = _data[0];
    controller.passEditingController!.text = _data[1];
    controller.siteEditingController!.text = _data[2];
    controller.domainEditingController!.text = _data[3];
    String sacredkey = _data[4];
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            color: Colors.white,
          ),
          child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Password',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Login',
                        ),
                        controller: controller.loginEditingController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        controller: controller.passEditingController,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Website',
                        ),
                        controller: controller.siteEditingController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Domain',
                        ),
                        controller: controller.domainEditingController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              child: Text('Update'),
                              onPressed: () {
                                passUpdate(
                                    controller.loginEditingController!.text,
                                    controller.passEditingController!.text,
                                    controller.siteEditingController!.text,
                                    controller.domainEditingController!.text,
                                    sacredkey);
                                ;
                              }),
                          ElevatedButton(
                              child: Text('Delete'),
                              onPressed: () {
                                passDelete(sacredkey);
                              }),
                        ],
                      )
                    ],
                  ),
                ],
              )),
        ));
  }

  void passUpdate(
      String login, String pass, String site, String domain, String key) {
    String unikey = key;

    controller.savePass({
      'login': login,
      'pass': pass,
      'website': site,
      'domain': domain,
      'sacredkey': unikey
    }, 1);
    Get.back();
  }

  void passDelete(var key) {
    controller.deletePass(key, 1);
    Get.back();
  }
}
