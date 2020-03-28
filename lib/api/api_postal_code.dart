import 'package:dio/dio.dart';
import 'package:xlo/models/address.dart';
import 'package:xlo/repositories/api_error.dart';
import 'package:xlo/repositories/api_response.dart';

Future<ApiResponse> getAddressFromAPI(String postalCode) async {
  final String endpoint =
      'http://viacep.com.br/ws/${postalCode.replaceAll('.', '').replaceAll('-', '')}/json/';

  try {
    final Response response = await Dio().get<Map>(endpoint);
    if (response.data.containsKey('erro') && response.data['erro']) {
      return ApiResponse.error(
          error: ApiError(code: -1, message: 'CEP Inválido!'));
    }

    final Address address = Address(
      place: response.data['logradouro'],
      city: response.data['localidade'],
      district: response.data['bairro'],
      federativeUnity: response.data['uf'],
      postalCode: response.data['cep'],
    );

    return ApiResponse.success(result: address);
  } on DioError {
    return ApiResponse.error(
        error: ApiError(code: -1, message: 'Falha ao contactar via CEP!'));
  }
}
