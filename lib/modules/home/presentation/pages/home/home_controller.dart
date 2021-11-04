import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../domain/enums/currency_type_enum.dart';
import '../../../domain/usecases/interfaces/convert_currency_interface.dart';
import 'home_store.dart';

class HomeController {
  final IConvertCurrency _convertCurrency;
  final HomeStore homeStore;

  final txtReais = TextEditingController();
  final txtDolars = TextEditingController();
  final txtEuros = TextEditingController();
  Timer? _debounce;
  NumberFormat formatter = NumberFormat("00.00");

  HomeController({
    required IConvertCurrency convertCurrency,
    required this.homeStore,
  }) : _convertCurrency = convertCurrency;

  _search(String value, CurrencyTypeEnum type) {
    homeStore.setLoad(true);
    if (_debounce != null && _debounce!.isActive) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        if (value.isNotEmpty) {
          var currencies = await _convertCurrency(value, type);

          if ((type != CurrencyTypeEnum.usd)) {
            txtDolars.text = formatter.format(currencies.dollar);
          }
          if ((type != CurrencyTypeEnum.brl)) {
            txtReais.text = formatter.format(currencies.real);
          }
          if ((type != CurrencyTypeEnum.eur)) {
            txtEuros.text = formatter.format(currencies.euro);
          }
        } else {
          txtDolars.text = '';
          txtReais.text = '';
          txtEuros.text = '';
        }
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        homeStore.setLoad(false);
      }
    });
  }

  Future onRealChanged(String v) async {
    _search(v, CurrencyTypeEnum.brl);
  }

  Future onDolarChanged(String v) async {
    _search(v, CurrencyTypeEnum.usd);
  }

  Future onEuroChanged(String v) async {
    _search(v, CurrencyTypeEnum.eur);
  }
}
