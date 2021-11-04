import '../../entities/currency_entity.dart';
import '../../enums/currency_type_enum.dart';

abstract class IConvertCurrency {
  Future<CurrencyEntity> call(
    String value,
    CurrencyTypeEnum type,
  );
}
