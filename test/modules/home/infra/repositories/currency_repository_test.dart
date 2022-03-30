import 'package:converssor_moedas/modules/home/infra/datasources/models/currency_info_models.dart';
import 'package:converssor_moedas/modules/home/infra/repositories/currency_repository.dart';
import 'package:converssor_moedas/modules/home/infra/repositories/datasources/currency_datasource_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'currency_repository_test.mocks.dart';

@GenerateMocks([ICurrencyDataSource])
void main() {
  late CurrencyRepository _curencyRepository;
  final _currencyDataSource = MockICurrencyDataSource();

  setUp(() {
    _curencyRepository =
        CurrencyRepository(currencyDataSource: _currencyDataSource);
  });

  test('Datasource deve ser chamado', () async {
    //arranje
    when(_currencyDataSource.getCurrencies())
        .thenAnswer((_) async => const CurrencyInfoModel(
              dollarValue: 6,
              euroValue: 8,
            ));
    //act
    var result = await _curencyRepository.getCurrencies();

    //assert
    verify(_currencyDataSource.getCurrencies()).called(1);
    expect(result, isA<CurrencyInfoModel>());
  });
}
