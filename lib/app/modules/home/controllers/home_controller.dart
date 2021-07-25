import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'PASSWORDS'),
    Tab(text: 'PERSONAL INFO'),
    Tab(text: "ID'S"),
  ];

  TabController? controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    controller!.dispose();
    super.onClose();
  }
}
