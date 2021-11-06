import 'package:flutter_modular/flutter_modular.dart';

import '../../../../commons/adapters/localization/localization_helper.dart';

class SplashController {
  final LocalizationHelper _localizationHelper;

  SplashController({
    required LocalizationHelper localizationHelper,
  }) : _localizationHelper = localizationHelper;

  Future<void> init() async {
    await _localizationHelper.configuration([
      'assets/lang',
    ]);

    Future.delayed(const Duration(seconds: 2), () {
      Modular.to.pushReplacementNamed('/home/');
    });
  }
}
