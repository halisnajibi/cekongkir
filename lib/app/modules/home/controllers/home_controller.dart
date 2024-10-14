import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/ongkir_model.dart';

class HomeController extends GetxController {
  TextEditingController beratC = TextEditingController();
  List<Ongkir> result = [];
  RxBool isLoading = false.obs;
  RxString provAsalID = "0".obs;
  RxString cityAsalID = "0".obs;
  RxString provTujuanID = "0".obs;
  RxString cityTujuanID = "0".obs;
  RxString jasper = "".obs;

  void cekOngkir() async {
    if (provAsalID != '0' &&
        provTujuanID != '0' &&
        cityAsalID != '0' &&
        cityTujuanID != '0' &&
        jasper != '' &&
        beratC.text != '') {
      try {
        isLoading.value = true;
        final response = await http.post(
            Uri.parse("https://api.rajaongkir.com/starter/cost"),
            headers: {
              'content-type': 'application/x-www-form-urlencoded',
              'key': 'e48a02b1f3d5cddebd66fda95c3a386d',
            },
            body: {
              'origin': cityAsalID.value,
              'destination': cityTujuanID.value,
              'weight': beratC.text,
              'courier': jasper.value,
            });
        isLoading.value = false;
        List ongkir = jsonDecode(response.body)['rajaongkir']['results'][0]
            ['costs'] as List;
        result = Ongkir.fromJsonList(ongkir);
        Get.defaultDialog(
            title: "ONGKOS KIRIM",
            content: Column(
              children: result
                  .map((e) => ListTile(
                        title: Text("${e.service!.toUpperCase()}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${e.cost![0].etd} Hari"),
                            Text("Rp ${e.cost![0].value}"),
                          ],
                        ),
                      ))
                  .toList(),
            ));
      } catch (e) {
        print(e);
        Get.defaultDialog(
            title: "Error", middleText: "Tidak dapat mengecek ongkir");
      }
    } else {
      Get.defaultDialog(title: "Error", middleText: "Data input belum lengkap");
      print(provAsalID);
      print(provTujuanID);
      print(cityAsalID);
      print(cityTujuanID);
      print(jasper);
    }
  }
}
