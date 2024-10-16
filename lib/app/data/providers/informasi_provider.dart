import 'package:get/get.dart';

import '../models/informasi_model.dart';

class InformasiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Informasi.fromJson(map);
      if (map is List)
        return map.map((item) => Informasi.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Informasi?> getInformasi(int id) async {
    final response = await get('informasi/$id');
    return response.body;
  }

  Future<Response<Informasi>> postInformasi(Informasi informasi) async =>
      await post('informasi', informasi);
  Future<Response> deleteInformasi(int id) async =>
      await delete('informasi/$id');
}
