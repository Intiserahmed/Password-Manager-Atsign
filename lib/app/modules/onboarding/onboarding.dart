import 'package:flutter/material.dart';
import 'package:at_onboarding_flutter/at_onboarding_flutter.dart';
import 'package:at_utils/at_logger.dart';
import 'package:sacred2/app/modules/home/views/home_view.dart';
import 'package:sacred2/app/services/sdk_service.dart';
import 'package:sacred2/app/utils/constants.dart';

class Onbording extends StatefulWidget {
  @override
  OnbordingState createState() => OnbordingState();
}

class OnbordingState extends State<Onbording> {
  var atClientPrefernce;
  var _logger = AtSignLogger('Scaredkey');
  @override
  void initState() {
    ClientSdkService.getInstance()
        .getAtClientPreference()
        .then((value) => atClientPrefernce = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => Center(
            child: TextButton(
                onPressed: () async {
                  Onboarding(
                    context: context,
                    atClientPreference: atClientPrefernce,
                    domain: MixedConstants.ROOT_DOMAIN,
                    appColor: Color.fromARGB(255, 240, 94, 62),
                    onboard: (value, atsign) {
                      ClientSdkService.getInstance().atClientServiceMap = value;
                      _logger.finer('Successfully onboarded $atsign');
                    },
                    onError: (error) {
                      _logger.severe('Onboarding throws $error error');
                    },
                    nextScreen: HomeView(),
                    appAPIKey: '477b-876u-bcez-c42z-6a3d'
                  );
                },
                child: Text(AppStrings.scan_qr)),
          ),
        ),
      ),
    );
  }
}
