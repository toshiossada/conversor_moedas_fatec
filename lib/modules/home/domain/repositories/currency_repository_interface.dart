import '../entities/currency_info_entity.dart';

abstract class ICurrencyRepository {
  Future<CurrencyInfoEntity> getCurrencies();
}
