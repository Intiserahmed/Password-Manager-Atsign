import 'package:get/get.dart';

import 'package:sacred2/app/modules/Id/views/id_view.dart';
import 'package:sacred2/app/modules/home/views/home_view.dart';
import 'package:sacred2/app/modules/onboarding/onboarding.dart';
import 'package:sacred2/app/modules/password/views/passadd_view.dart';
import 'package:sacred2/app/modules/password/views/password_view.dart';
import 'package:sacred2/app/modules/payment/views/personal_info_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = '/onboarding';

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
    ),
    GetPage(
      name: _Paths.PASSWORD,
      page: () => PasswordView(),
    ),
    GetPage(
      name: _Paths.PERSONAL_INFO,
      page: () => PaymentView(),
    ),
    GetPage(
      name: _Paths.ID,
      page: () => IdView(),
    ),
        GetPage(
      name: '/passadd',
      page: () => PassaddView(),
    ),
        GetPage(
      name: '/onboarding',
      page: () => Onbording(),
    ),
  ];
}
