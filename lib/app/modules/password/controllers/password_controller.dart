import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sacred2/app/services/sdk_service.dart';
import 'package:at_commons/at_commons.dart';
import 'dart:convert';

class PasswordController extends GetxController {
  var allAtkeys = List<dynamic>.empty(growable: true)
      .obs; //  All Atkeys  at individual secondary server
  var isProcessing = false.obs;
  var passList = List<Map<String, dynamic>>.empty(growable: true).obs;
  var infoList = List<Map<String, dynamic>>.empty(growable: true).obs;
  var idList = List<Map<String, dynamic>>.empty(growable: true).obs;

  ClientSdkService clientSdkService = ClientSdkService.getInstance();

  ScrollController scrollController = ScrollController();

  TextEditingController? loginEditingController, passEditingController;
  // domainEditingController;
  var selectedPriority = 1.obs;
  var atClientPreference;

  @override
  void onInit() async {
    super.onInit();
    ClientSdkService.getInstance()
        .getAtClientPreference()
        .then((value) => atClientPreference = value);
    // Fetch Data
    // To Save  Task
    loginEditingController = TextEditingController();
    passEditingController = TextEditingController();
    // domainEditingController = TextEditingController();
    readPasskey();
  }

  // clear the controllers
  void clearTextEditingControllers() {
    loginEditingController!.clear();
    passEditingController!.clear();
    // domainEditingController!.clear();
  }

// Create Operation - Json encode and put operation , with if else and try catch,async function
//  save will be same for all

  void savePass(Map data, int screen) {
    String? atSign = clientSdkService.atsign;
    AtKey atKey = AtKey();
    atKey.key = data['sacredkey'];
    print(atKey.key);
    atKey.sharedWith = atSign;
    String encoded = jsonEncode(data);
    print(encoded);
    clientSdkService.put(atKey, encoded);
    // passing the screen number so only that particular screen  will be updated other will remain unchaged
    readPasskey(screen);
    //  boolean to ensure the value is stored in the  secondary
  }

// Read key Operation - supposed to be async,

  Future<void> readPasskey([int? screen]) async {
    List<AtKey> response;
    String regex = '^(?!cached).*sacredkey.*';

    response = await clientSdkService.getAtKeys(regex);
    response.retainWhere((element) => !element.metadata!.isCached);

    // List<AtKey> response; already have all the keys here.. just need to  filter from here with for loop?
    // Looping through every instance of an AtKey object
    // switch statements here switch if ==1 then execute this
//  make this a function 
    switch (screen) {
      case 1:
        {
          for (AtKey atKey in response) {
            if (atKey.key!.startsWith('pa')) {
              print(atKey.key);
              var value = await readPassValue(atKey);
              Map<String, dynamic> decoded = jsonDecode(value);
              passList.clear();
              passList.add(
                  decoded); //  this will be wrapped in switch statement that the list will be cleared then
              print(decoded['pass']);
            }
          }
        }
        break;

      case 2:
        {
          for (AtKey atKey in response) {
            if (atKey.key!.startsWith('in')) {
              print(atKey.key);
              var value = await readPassValue(atKey);
              Map<String, dynamic> decoded = jsonDecode(value);
              infoList.add(decoded); 
              print(decoded['pass']);
            }
          }
        }
        break;

      case 3:
        {
                  for (AtKey atKey in response) {
            if (atKey.key!.startsWith('id')) {
              print(atKey.key);
              var value = await readPassValue(atKey);
              Map<String, dynamic> decoded = jsonDecode(value);
              idList.add(decoded); 
              print(decoded['pass']);
            }
          }
        }
        break;

      default:
        {
          print("Invalid choice");
        }
        break;
    }

    for (AtKey atKey in response) {
      // We get the current AtKey object that we are looping on
      if (atKey.key!.startsWith('pa')) {
        //
        print(atKey.key);
        var value = await readPassValue(atKey);
        Map<String, dynamic> decoded = jsonDecode(value);
        // Add current AtKey object to our list of strings defined earlier before
        // for loop
        passList.add(
            decoded); //  this will be wrapped in switch statement that the list will be cleared then

        print(decoded['pass']);
      }
    }
  }

  // Read Value Operation
  Future<dynamic> readPassValue(AtKey atKey) async {
    // If an AtKey object exists
    if (atKey != null) {
      // Simply get the AtKey object utilizing the serverDemoService's get method

      return await clientSdkService.get(atKey);
    }
    return '';
  }

// update Operation

  void updatePass(Map data) {}

// delete Operation

  void deletePass(Map data) {}

  // Refresh List
  void refreshList() async {
    //create a get method
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
    loginEditingController!.clear();
    passEditingController!.clear();
    // domainEditingController!.clear();
  }
}
