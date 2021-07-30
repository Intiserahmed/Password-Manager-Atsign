import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacred2/app/utils/sacred_text.dart';
import '../controllers/password_controller.dart';
import 'package:uuid/uuid.dart';

class PasswordView extends GetView<PasswordController> {
  @override
  Widget build(BuildContext context) {
    Get.put(PasswordController());

    return Scaffold(
        body: Obx(() {
          if (controller.allAtkeys.length > 0) {
            return Text("data");
          } else {
            return Center(child: Text("${controller.passList[0]['pass']}"));
          }
        }),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => displayAddTaskWindow(),
          label: Text('Add Password'),
          icon: Icon(Icons.add),
        ));
  }

  void displayAddTaskWindow() {
    Get.bottomSheet(
      Container(
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
                      'Add Task',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        hintText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      controller: controller.loginEditingController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      controller: controller.passEditingController,
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
                              );
                            }),
                      ],
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }

  void passSave(String login, String pass) {
    var uuid = Uuid();

    String unikey = SacredText.PASSWORD + uuid.v1().replaceAll('-', '_');

    controller.savePass({'login': login, 'pass': pass, 'sacredkey': unikey}, 1);
  

    /////// Also called function to get back previous screen
    Get.back();
  }
// for update screen it will different screen
  void passUpdate(){
// when you will  select a value it  will automatically hold the selected values and remain the  other values as it  is 



  }

  void deletePass(){

  }
}
