import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/currency_repository_interface.dart';
import 'domain/usecases/convert_currency.dart';
import 'domain/usecases/interfaces/convert_currency_interface.dart';
import 'infra/datasources/currency_datasource.dart';
import 'infra/repositories/currency_repository.dart';
import 'infra/repositories/datasources/currency_datasource_interface.dart';
import 'presentation/pages/about/about_page.dart';
import 'presentation/pages/home/home_controller.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/home/home_store.dart';


class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => HomeStore()),
    Bind.factory((i) => HomeController(
          convertCurrency: i(),
          homeStore: i(),
        )),
    Bind.factory<IConvertCurrency>((i) => ConvertCurrency(
          currencyRepository: i(),
        )),
    Bind.factory<ICurrencyRepository>(
        (i) => CurrencyRepository(currencyDataSource: i())),
    Bind.factory<ICurrencyDataSource>(
        (i) => CurrencyDataSource(httpClient: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (context, args) => const HomePage(),
    ),
    ChildRoute(
      '/about',
      child: (context, args) => const AboutPage(),
    ),
  ];
}
