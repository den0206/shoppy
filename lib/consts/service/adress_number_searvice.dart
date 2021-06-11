import 'package:dio/dio.dart';
import 'package:shoppy/another_shop/model/adress.dart';
import 'dart:convert';

class AdressNumberService {
  Future<Address> getAdDressFromCep(String cep) async {
    final cleanCep = cep.replaceAll(".", "").replaceAll("-", "");
    final endpoint =
        "https://zipcloud.ibsnet.co.jp/api/search?zipcode=$cleanCep";
    print(endpoint);

    final Dio dio = Dio();

    try {
      final response = await dio.get(endpoint);
      if (response.data.isEmpty) {
        return Future.error("Error Is empty Cer");
      }

      final adress = Address.fromMap(jsonDecode(response.data));

      print(adress.city);
      return adress;
    } on DioError catch (e) {
      print(e.message);
      return Future.error("Error Cep");
    }
  }
}
