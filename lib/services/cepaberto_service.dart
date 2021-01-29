import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_loja_ultimo/models/cepaberto_address.dart';

const token = "e714f856c91b89ed6be0ad6c8fb9c2ad";

class CepAbertoService {

  Future<CepAbertoAddress> getAddressFromCep(String cep) async {
    final cleanCep = cep.replaceAll(".", "").replaceAll("-", "");
    final endpoint = "https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";

    final Dio dio = Dio();

    dio.options.headers[HttpHeaders.authorizationHeader] = "Token token=$token";

    try {
      final response = await dio.get<Map<String, dynamic>>(endpoint);

      if(response.data.isEmpty){
        return Future.error("Cep Invalido");
      }

      final CepAbertoAddress address = CepAbertoAddress.fromMap(response.data);

      return address;
    } on DioError catch (e) {
      return Future.error('erro ao buscar o cep na api CEP_ABERTO erro: $e');
    }
  }
}
