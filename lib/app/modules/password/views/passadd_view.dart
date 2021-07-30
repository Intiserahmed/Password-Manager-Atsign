import 'package:flutter/material.dart';
import 'package:at_commons/at_commons.dart';
import 'package:get/get.dart';
import 'package:sacred2/app/modules/password/model/datamodel.dart';
import 'package:sacred2/app/services/sdk_service.dart';
import 'package:sacred2/app/utils/sacred_text.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class PassaddView extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? login;
  String? pass;
  String? domain;
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Password')),
      body: SafeArea(
        child: Center(
          child: Form(
            key: formkey,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.approval),
                      hintText: 'Username',
                      labelText: 'Name',
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Specify name of the dish' : null,
                    onChanged: (value) {
                      login = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.approval),
                      hintText: 'Password',
                      labelText: 'Description',
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Provide a description' : null,
                    onChanged: (value) {
                      pass = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.approval),
                      hintText: 'Website',
                      labelText: 'Website link',
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Add some ingredients' : null,
                    onChanged: (value) {
                      domain = value;
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    child: Text('Add Password'),
                    onPressed: () => _update(context),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _update(BuildContext context) async {
    ClientSdkService clientSdkService = ClientSdkService.getInstance();
    String? atSign = clientSdkService.atsign;
    // If all of the necessary text form fields have been properly
    // populated
    final FormState? form = formkey.currentState;
    if (form!.validate()) {
      // The information inputted by the authenticated atsign
      // Each field's value is separated by a constant.splitter
      // which is defined as @_@ so when a recipe is shared and received by
      // another secondary server, the at_cookbook app will understand how to
      // distribute the values correctly into their respectful fields

      // Instantiating an AtKey object and specifying its attributes with the
      // recipe title and the atsign that created it
      AtKey atKey = AtKey();
      atKey.key = SacredText.PASSWORD + uuid.v1().replaceAll('-', '_');
      atKey.sharedWith = atSign;
      PasswordSacred? passw;
      passw!.domain =domain;
      passw.login =login;
      passw.pass =pass;
      passw.sacredkey= atKey.key;
      var string = passw.toJson();

      String values = jsonEncode(string);
      // Utilizing the put method to take the AtKey object and its values
      // and 'put' it on the secondary server of the authenticated atsign
      // (the atsign currently logged in)
      await clientSdkService.put(atKey, values);

      // This will take the authenticated atsign from the add_dish page back
      // to the home screen
      Navigator.pop(context);
    } else {
      // If the authenticated atsign has not properly populated the
      // text form fields, this statement will be printed
      print('Not all text fields have been completed!');
    }
  }
}
