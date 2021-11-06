
import 'package:converssor_moedas/app_module.dart';
import 'package:converssor_moedas/commons/adapters/http_client/http_response.dart';
import 'package:converssor_moedas/commons/adapters/http_client/interfaces/http_client_adapter.dart';
import 'package:converssor_moedas/modules/home/home_module.dart';
import 'package:converssor_moedas/modules/home/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localization/localization.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:modular_test/modular_test.dart';

import '../../../../../utils/testable_widget.dart';
import 'home_page_test.mocks.dart';

@GenerateMocks([IHttpClientAdapter, IModularNavigator])
main() {
  final _httpMock = MockIHttpClientAdapter();
  final _navigatorMock = MockIModularNavigator();

  setUp(() async {
    initModules([
      AppModule(),
      HomeModule()
    ], replaceBinds: [
      Bind.instance<IHttpClientAdapter>(_httpMock),
    ]);
    Localization.setTranslationDirectories(['assets/lang']);
    await Localization.configuration(selectedLanguage: 'pt_BR');
    Modular.navigatorDelegate = _navigatorMock;
  });
  group('Teste campos', () {
    testWidgets('''
          Dado o valor de 10 reais no campo txtReal
          Quando a cotação do dolar estiver 5 e a do euro 6
          Deve Escrever no campo txtDolar o valor de 02.00 e n
            o campo txtEuro o valor de 01.67
    ''', (tester) async {
      //arrange
      await tester.pumpWidget(testableWidget(const HomePage()));
      await tester.pump();
      final responsePayload = {
        "results": {
          "currencies": {
            "source": "BRL",
            "USD": {"name": "Dollar", "buy": 5.0},
            "EUR": {"name": "Euro", "buy": 6.0},
          }
        }
      };

      when(_httpMock.get(any, queryParameters: {'format': 'json'})).thenAnswer(
          (_) async => HttpResponse(statusCode: 200, data: responsePayload));

      //act
      var txtBrl = find.byKey(const Key('txtBrl'));
      var txtUsd = find.byKey(const Key('txtUsd'));
      var txtEur = find.byKey(const Key('txtEur'));
      expect(txtBrl, findsOneWidget);
      expect(txtUsd, findsOneWidget);
      expect(txtEur, findsOneWidget);
      await tester.enterText(txtBrl, '10');
      await tester.pumpAndSettle();
      // assert
      expect(find.text("10"), findsOneWidget);
      expect(find.text("01.67"), findsOneWidget);
      expect(find.text("02.00"), findsOneWidget);
    });
  });

  group('Teste appBar', () {
    testWidgets('''
          Dado a tela de login
          Quando o usuario clickar no logo
          Deve redirecionar para tela de 'about'
    ''', (tester) async {      
      //arrange
      await tester.pumpWidget(testableWidget(const HomePage()));
      when(_navigatorMock.pushNamed(any)).thenAnswer((_) async => {});

      //act
      var btnLogo = find.byType(GestureDetector);

      expect(btnLogo, findsOneWidget);
      await tester.tap(btnLogo);
      await tester.pump();

      // assert
      verify(_navigatorMock.pushNamed(any)).called(1);
    });
  });
}
