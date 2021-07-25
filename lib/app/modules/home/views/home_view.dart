import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sacred2/app/modules/Id/views/id_view.dart';
import 'package:sacred2/app/modules/password/views/password_view.dart';
import 'package:sacred2/app/modules/payment/views/personal_info_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController _tabx = Get.put(HomeController());
    return Scaffold(
        appBar: AppBar(
          title: Text('HomeView'),
          bottom: TabBar(
            isScrollable: true,
            controller: _tabx.controller,
            tabs: _tabx.myTabs,
          ),
        ),
        body: TabBarView(
          controller: _tabx.controller,
          children: [
            PasswordView(),
            PaymentView(),
            IdView(),
          ],
        ),
        drawer: Drawer(),);
  }
}
