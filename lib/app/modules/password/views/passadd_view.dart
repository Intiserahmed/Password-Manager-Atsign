import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:sacred2/app/modules/password/controllers/password_controller.dart';
import 'package:sacred2/app/utils/sacred_text.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';

class AddPassWord extends GetView<PasswordController> {
  const AddPassWord({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PasswordController());
    controller.clearTextEditingControllers();
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
                        'Add Password',
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              child: Text('Save'),
                              onPressed: () {
                                passSave(
                                  controller.loginEditingController!.text,
                                  controller.passEditingController!.text,
                                  controller.siteEditingController!.text,
                                  controller.domainEditingController!.text,
                                );
                                ;
                              }),
                        ],
                      )
                    ],
                  ),
                ],
              )),
        ));
  }

  void passSave(String login, String pass, String site, String domain) {
    var uuid = Uuid();

    String unikey = SacredText.PASSWORD + uuid.v1().replaceAll('-', '_');

    controller.savePass({
      'login': login,
      'pass': pass,
      'website': site,
      'domain': domain,
      'sacredkey': unikey
    }, 1);
    Get.back();
  }
}
