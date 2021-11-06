import '../../../../commons/adapters/http_client/interfaces/http_client_adapter.dart';
import '../../../../commons/erros.dart';
import '../repositories/datasources/currency_datasource_interface.dart';
import 'models/currency_info_models.dart';

class CurrencyDataSource implements ICurrencyDataSource {
  final IHttpClientAdapter _httpClient;

  CurrencyDataSource({
    required IHttpClientAdapter httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<CurrencyInfoModel> getCurrencies() async {
    try {
      var response = await _httpClient
          .get('/finance', queryParameters: {'format': 'json'});

      var result = CurrencyInfoModel.fromJson(response.data);
      return result;
    } catch (e) {
      throw DatasourceError(
        message: 'Erro ao tentar buscar dados externos',
      );
    }
  }
}
