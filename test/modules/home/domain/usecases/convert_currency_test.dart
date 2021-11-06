import 'package:converssor_moedas/modules/home/domain/entities/currency_entity.dart';
import 'package:converssor_moedas/modules/home/domain/entities/currency_info_entity.dart';
import 'package:converssor_moedas/modules/home/domain/enums/currency_type_enum.dart';
import 'package:converssor_moedas/modules/home/domain/errors/errors.dart';
import 'package:converssor_moedas/modules/home/domain/repositories/currency_repository_interface.dart';
import 'package:converssor_moedas/modules/home/domain/usecases/convert_currency.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'convert_currency_test.mocks.dart';

@GenerateMocks([ICurrencyRepository])
void main() {
  late ConvertCurrency _usecase;
  final _repository = MockICurrencyRepository();

  setUp(() {
    _usecase = ConvertCurrency(currencyRepository: _repository);
  });

  group('Testes de sucesso', () {
    test('''
          Dado o valor de 4 dolares
          Quando a cotação do dolar for de 6 reais e o euro de 8 reais
          Deve retornar 24 reais, 3 euros e 4 dolars
    ''', () async {
      //prepare
      when(_repository.getCurrencies())
          .thenAnswer((_) async => const CurrencyInfoEntity(
                dollarValue: 6,
                euroValue: 8,
              ));

      //execute
      final result = await _usecase('4', CurrencyTypeEnum.usd);

      // assert
      expect(result, isA<CurrencyEntity>());
      verify(_repository.getCurrencies()).called(1);
      expect(result.real, 24);
      expect(result.euro, 3);
      expect(result.dollar, 4);
    });

    test('''
          Dado o valor de 4 euros
          Quando a cotação do dolar for de 6 reais e o euro de 8 reais
          Deve retornar 32 reais, 4 euros e 5.333333333333333 dolars
    ''', () async {
      //prepare
      when(_repository.getCurrencies())
          .thenAnswer((_) async => const CurrencyInfoEntity(
                dollarValue: 6,
                euroValue: 8,
              ));

      //execute
      final result = await _usecase('4', CurrencyTypeEnum.eur);

      // assert
      expect(result, isA<CurrencyEntity>());
      verify(_repository.getCurrencies()).called(1);
      expect(result.real, 32);
      expect(result.euro, 4);
      expect(result.dollar, 5.333333333333333);
    });

    test('''
          Dado o valor de 16 euros
          Quando a cotação do dolar for de 4 reais e o euro de 8 reais
          Deve retornar 16 reais, 2 euros e 4 dolars
    ''', () async {
      //prepare
      when(_repository.getCurrencies())
          .thenAnswer((_) async => const CurrencyInfoEntity(
                dollarValue: 4,
                euroValue: 8,
              ));

      //execute
      final result = await _usecase('16', CurrencyTypeEnum.brl);

      // assert
      expect(result, isA<CurrencyEntity>());
      verify(_repository.getCurrencies()).called(1);
      expect(result.real, 16);
      expect(result.euro, 2);
      expect(result.dollar, 4);
    });
  });

  group('Teste de falha', () {
    test('''
          Dado informado valor em reais
          Quando o valor for vazio
          Deve lançar excessão ValueIsNullFailure
    ''', () async {
      //arrange
      when(_repository.getCurrencies())
          .thenAnswer((_) async => const CurrencyInfoEntity(
                dollarValue: 6,
                euroValue: 8,
              ));

      //acte
      final result = _usecase('', CurrencyTypeEnum.brl);

      // assert
      expect(result, throwsA(isA<ValueIsNullFailure>()));
    });
    test('''
          Dado informado valor em reais
          Quando o valor não for numerico
          Deve lançar excessão InvalidNumberFailure
    ''', () async {
      //arrange
      when(_repository.getCurrencies())
          .thenAnswer((_) async => const CurrencyInfoEntity(
                dollarValue: 6,
                euroValue: 8,
              ));

      //act
      final result = _usecase('ABC', CurrencyTypeEnum.brl);

      // assert
      expect(result, throwsA(isA<InvalidNumberFailure>()));
    });
    test('''
          Dado informado valor em reais
          Quando um numero negativo
          Deve lançar excessão NegativeValueFailure
    ''', () async {
      //arrange
      when(_repository.getCurrencies())
          .thenAnswer((_) async => const CurrencyInfoEntity(
                dollarValue: 6,
                euroValue: 8,
              ));

      //act
      final result = _usecase('-10', CurrencyTypeEnum.brl);

      // assert
      expect(result, throwsA(isA<NegativeValueFailure>()));
    });
  });
}
