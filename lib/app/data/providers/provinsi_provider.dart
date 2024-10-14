import 'package:get/get.dart';

import '../models/provinsi_model.dart';

class ProvinsiProvider extends GetConnect {
  Future<List<Provinsi?>> getProvinsi() async {
    final response = await get('https://api.rajaongkir.com/starter/province');
    return Provinsi.fromJsonList(response.body);
  }
}
