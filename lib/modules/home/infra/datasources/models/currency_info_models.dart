import 'package:converssor_moedas/modules/home/domain/entities/currency_info_entity.dart';

class CurrencyInfoModel extends CurrencyInfoEntity {
  const CurrencyInfoModel({
    required double dollarValue,
    required double euroValue,
  }) : super(
          dollarValue: dollarValue,
          euroValue: euroValue,
        );

  factory CurrencyInfoModel.fromJson(Map<String, dynamic> json) {
    var currencies = json['results']['currencies'];
    return CurrencyInfoModel(
      dollarValue: currencies['USD']['buy']!,
      euroValue: currencies['EUR']['buy']
    );
  }
}
