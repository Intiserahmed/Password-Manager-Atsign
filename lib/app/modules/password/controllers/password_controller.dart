import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacred2/app/services/sdk_service.dart';
import 'package:at_commons/at_commons.dart';
import 'dart:convert';

class PasswordController extends GetxController {
  var allAtkeys = List<dynamic>.empty(growable: true)
      .obs; //  All Atkeys  at individual secondary server
  var isProcessing = false.obs;
  var all = 0;
  var passlist = List<Map<String, dynamic>>.empty(growable: true).obs;
  var infoList = List<Map<String, dynamic>>.empty(growable: true).obs;
  var idList = List<Map<String, dynamic>>.empty(growable: true).obs;

  ClientSdkService clientSdkService = ClientSdkService.getInstance();

  ScrollController scrollController = ScrollController();

  TextEditingController? loginEditingController,
      passEditingController,
      siteEditingController,
      domainEditingController;
  // domainEditingController;
  var selectedPriority = 1.obs;
  var atClientPreference;

  @override
  void onInit() {
    super.onInit();
    readPasskey(10);

    ClientSdkService.getInstance()
        .getAtClientPreference()
        .then((value) => atClientPreference = value);
    // Fetch Data
    // To Save  Task
    loginEditingController = TextEditingController();
    passEditingController = TextEditingController();
    siteEditingController = TextEditingController();
    domainEditingController = TextEditingController();

    // domainEditingController = TextEditingController();
  }

  // clear the controllers
  void clearTextEditingControllers() {
    loginEditingController!.clear();
    passEditingController!.clear();
    siteEditingController!.clear();
    domainEditingController!.clear();
  }

// Create Operation - Json encode and put operation , with if else and try catch,async function
//  save will be same for all
  // Read Value Operation
  Future<dynamic> readPassValue(AtKey atKey) async {
    // If an AtKey object exists
    if (atKey != null) {
      // Simply get the AtKey object utilizing the serverDemoService's get method

      return await clientSdkService.get(atKey);
    }
    return '';
  }

  Future<void> deletePass(String sacredkey, int screen) async {
    String? atSign = clientSdkService.atsign;

    AtKey atKey = AtKey();
    atKey.key = sacredkey;
    atKey.sharedWith = atSign;

    print(sacredkey);
    print(atKey.key);
    print(atKey);
    var result = await clientSdkService.delete(atKey);
    if (result == true) {
      if (screen == 1) {
        clearTextEditingControllers();
        passlist.clear();
        readPasskey(1);
      }
      if (screen == 2) {
        clearTextEditingControllers();
        infoList.clear();
        readPasskey(2);
      }
      if (screen == 3) {
        clearTextEditingControllers();
        idList.clear();
        readPasskey(3);
      }
    } else {
      print("not executed");
    }
  }

  Future<void> savePass(Map data, int screen) async {
    String? atSign = clientSdkService.atsign;
    AtKey atKey = AtKey();
    atKey.key = data['sacredkey'];
    print(atKey.key);
    atKey.sharedWith = atSign;
    String encoded = jsonEncode(data);
    print(encoded);

    var result = await clientSdkService.put(atKey,
        encoded); //  boolean to ensure the value is stored in the  secondary

    //// The bug it is only clearing the needed one
    if (result == true) {
      if (screen == 1) {
        clearTextEditingControllers();
        passlist.clear();
        readPasskey(1);
      }
      if (screen == 2) {
        clearTextEditingControllers();
        infoList.clear();
        readPasskey(2);
      }
      if (screen == 3) {
        clearTextEditingControllers();
        idList.clear();
        readPasskey(3);
      }
    } else {
      print("not executed");
    }
  }

// new read function - pass screen nnumber to executte
  Future<void> readPasskey(int screen) async {
    // List<AtKey> response; already have all the keys here.. just need to  filter from here with for loop?
    // Looping through every instance of an AtKey object
    List<AtKey> response;
    String regex = '^(?!cached).*sacredkey.*';

    response = await clientSdkService.getAtKeys(regex);
    response.retainWhere((element) => !element.metadata!.isCached);
    for (AtKey atKey in response) {
      // We get the current AtKey object that we are looping on
      // switch statements here switch if ==1 then  e
      if (screen == 10 || screen == 1) {
        if (atKey.key!.startsWith('pa')) {
          //
          print(atKey.key);
          var value = await readPassValue(atKey);
          Map<String, dynamic> _decoded = jsonDecode(value);
          // Add current AtKey object to our list of strings defined earlier before
          // for loop
          passlist.add(
              _decoded); //  this will be wrapped in switch statement that the list will be cleared then

          print(_decoded['pass']);
        }
      }
      if (screen == 10 || screen == 2) {
        if (atKey.key!.startsWith('in')) {
          //
          print(atKey.key);
          var value = await readPassValue(atKey);
          Map<String, dynamic> _decoded = jsonDecode(value);
          // Add current AtKey object to our list of strings defined earlier before
          // for loop
          infoList.add(
              _decoded); //  this will be wrapped in switch statement that the list will be cleared then

          print(_decoded['pass']);
        }
      }
      if (screen == 10 || screen == 3) {
        if (atKey.key!.startsWith('id')) {
          //
          print(atKey.key);
          var value = await readPassValue(atKey);
          Map<String, dynamic> _decoded = jsonDecode(value);
          // Add current AtKey object to our list of strings defined earlier before
          // for loop
          idList.add(
              _decoded); //  this will be wrapped in switch statement that the list will be cleared then

          print(_decoded['pass']);
        }
      }
    }
  }

// update Operation

  void updatePass(Map data) {}

// delete Operation

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
    loginEditingController!.clear();
    passEditingController!.clear();
    siteEditingController!.clear();
    domainEditingController!.clear();
  }
}
