import 'package:converssor_moedas/modules/splash/splash_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart' as dio;

import 'commons/adapters/http_client/dio_adapter.dart';
import 'commons/adapters/http_client/interceptors/dio_interceptor.dart';
import 'commons/adapters/http_client/interfaces/http_client_adapter.dart';
import 'commons/adapters/localization/localization_helper.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<HttpClientAdapter>((i) => DioAdapter(
          dio: i(),
          insterceptors: [
            i<CustomInterceptors>(),
          ],
        )),
    Bind.factory<CustomInterceptors>((i) => CustomInterceptors()),
    Bind.factory((i) => LocalizationHelper()),
    Bind.factory((i) => dio.Dio(i())),
    Bind.factory<dio.BaseOptions>(
        (i) => dio.BaseOptions(baseUrl: 'https://api.hgbrasil.com')),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
    ModuleRoute('/home/', module: HomeModule()),
  ];
}
