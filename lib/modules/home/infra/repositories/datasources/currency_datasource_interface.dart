import '../../datasources/models/currency_info_models.dart';

abstract class ICurrencyDataSource {
  Future<CurrencyInfoModel> getCurrencies();
}
