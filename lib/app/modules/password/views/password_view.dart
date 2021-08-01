import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacred2/app/modules/password/views/passadd_view.dart';
import '../controllers/password_controller.dart';

class PasswordView extends GetView<PasswordController> {
  @override
  Widget build(BuildContext context) {
    Get.put(PasswordController());

    return Scaffold(
        body: Column(
          children: [
            Expanded(child: Obx(() {
              return ListView.builder(
                
                  itemCount: controller.passlist.length,
                  itemBuilder: (context, index) {
                    var item = controller.passlist[index];
                    return ListTile(
                      leading:IconButton(
                        icon: Icon(Icons.face_unlock_outlined),
                        onPressed: () {},
                      ) ,
                      title: Text("${controller.passlist[index]['domain']}"),
                      subtitle: Text("${controller.passlist[index]['login']}"),
                      trailing: IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () {},
                      ),
                    );
                  });
            }))
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Get.to(AddPassWord()),
          label: Text('Add Password'),
          icon: Icon(Icons.add),
        ));
  }

// for update screen it will different screen
  void passUpdate() {
// when you will  select a value it  will automatically hold the selected values and remain the  other values as it  is
  }

  void deletePass() {}
}
