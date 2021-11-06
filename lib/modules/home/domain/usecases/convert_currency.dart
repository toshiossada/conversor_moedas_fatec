import '../entities/currency_entity.dart';
import '../enums/currency_type_enum.dart';
import '../errors/errors.dart';
import '../repositories/currency_repository_interface.dart';
import 'interfaces/convert_currency_interface.dart';

class ConvertCurrency extends IConvertCurrency {
  final ICurrencyRepository _currencyRepository;

  ConvertCurrency({
    required ICurrencyRepository currencyRepository,
  }) : _currencyRepository = currencyRepository;

  @override
  Future<CurrencyEntity> call(String value, CurrencyTypeEnum type) async {
    if (value.isEmpty) {
      throw ValueIsNullFailure(message: 'Valor não pode ser vazio');
    } else if (double.tryParse(value) == null) {
      throw InvalidNumberFailure(message: 'Digite um numero valido');
    } else if (double.parse(value) < 0) {
      throw NegativeValueFailure(message: 'Valor não pode ser negativo');
    }

    var dValue = double.parse(value);
    var currencies = await _currencyRepository.getCurrencies();

    switch (type) {
      case CurrencyTypeEnum.brl:
        return CurrencyEntity(
          dollar: dValue / currencies.dollarValue,
          euro: dValue / currencies.euroValue,
          real: dValue,
        );
      case CurrencyTypeEnum.usd:
        var real = dValue * currencies.dollarValue;
        return CurrencyEntity(
          dollar: dValue,
          euro: real / currencies.euroValue,
          real: real,
        );
      case CurrencyTypeEnum.eur:
        var real = dValue * currencies.euroValue;
        return CurrencyEntity(
          dollar: real / currencies.dollarValue,
          euro: dValue,
          real: real,
        );
      default:
        return const CurrencyEntity(dollar: 0, euro: 0, real: 0);
    }
  }
}
