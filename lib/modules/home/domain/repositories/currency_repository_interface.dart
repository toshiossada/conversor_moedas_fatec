import 'package:converssor_moedas/modules/home/domain/entities/currency_info_entity.dart';

abstract class ICurrencyRepository {
  Future<CurrencyInfoEntity> getCurrencies();
}
