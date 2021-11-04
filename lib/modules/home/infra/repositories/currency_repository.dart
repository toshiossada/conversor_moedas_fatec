import '../../domain/entities/currency_info_entity.dart';
import '../../domain/repositories/currency_repository_interface.dart';
import 'datasources/currency_datasource_interface.dart';

class CurrencyRepository implements ICurrencyRepository {
  final ICurrencyDataSource _currencyDataSource;

  CurrencyRepository({required ICurrencyDataSource currencyDataSource})
      : _currencyDataSource = currencyDataSource;

  @override
  Future<CurrencyInfoEntity> getCurrencies() async {
    final result = await _currencyDataSource.getCurrencies();

    return result;
  }
}
