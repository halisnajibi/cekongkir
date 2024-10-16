import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../../../data/models/provinsi_model.dart';
import '../../../data/models/kota_model.dart';
import 'package:dio/dio.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CEK ONGKIR'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            DropdownSearch<Provinsi>(
              popupProps: PopupProps.menu(
                  showSearchBox: true,
                  itemBuilder: (context, item, isSelected) => ListTile(
                        title: Text("${item.province}"),
                      )),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Provinsi Asal",
                  border: OutlineInputBorder(),
                ),
              ),
              asyncItems: (String filter) async {
                var response = await Dio().get(
                    "https://api.rajaongkir.com/starter/province",
                    queryParameters: {
                      "key": "e48a02b1f3d5cddebd66fda95c3a386d"
                    });
                return Provinsi.fromJsonList(
                    response.data["rajaongkir"]["results"]);
              },
              onChanged: (value) =>
                  controller.provAsalID.value = value?.provinceId ?? "0",
            ),
            SizedBox(
              height: 10,
            ),
            DropdownSearch<Kota>(
              popupProps: PopupProps.menu(
                  showSearchBox: true,
                  itemBuilder: (context, item, isSelected) => ListTile(
                        title: Text("${item.type} ${item.cityName}"),
                      )),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Kota/Kabupaten Asal",
                  border: OutlineInputBorder(),
                ),
              ),
              asyncItems: (String filter) async {
                var response = await Dio().get(
                    "https://api.rajaongkir.com/starter/city?province=${controller.provAsalID}",
                    queryParameters: {
                      "key": "e48a02b1f3d5cddebd66fda95c3a386d"
                    });
                return Kota.fromJsonList(
                    response.data["rajaongkir"]["results"]);
              },
              onChanged: (value) =>
                  controller.cityAsalID.value = value?.cityId ?? "0",
            ),
            Divider(),
            DropdownSearch<Provinsi>(
              popupProps: PopupProps.menu(
                  showSearchBox: true,
                  itemBuilder: (context, item, isSelected) => ListTile(
                        title: Text("${item.province}"),
                      )),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Provinsi Tujuan",
                  border: OutlineInputBorder(),
                ),
              ),
              asyncItems: (String filter) async {
                var response = await Dio().get(
                    "https://api.rajaongkir.com/starter/province",
                    queryParameters: {
                      "key": "e48a02b1f3d5cddebd66fda95c3a386d"
                    });
                return Provinsi.fromJsonList(
                    response.data["rajaongkir"]["results"]);
              },
              onChanged: (value) =>
                  controller.provTujuanID.value = value?.provinceId ?? "0",
            ),
            SizedBox(
              height: 10,
            ),
            DropdownSearch<Kota>(
              popupProps: PopupProps.menu(
                  showSearchBox: true,
                  itemBuilder: (context, item, isSelected) => ListTile(
                        title: Text("${item.type} ${item.cityName}"),
                      )),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Kota/Kabupaten Tujuan",
                  border: OutlineInputBorder(),
                ),
              ),
              asyncItems: (String filter) async {
                var response = await Dio().get(
                    "https://api.rajaongkir.com/starter/city?province=${controller.provTujuanID}",
                    queryParameters: {
                      "key": "e48a02b1f3d5cddebd66fda95c3a386d"
                    });
                return Kota.fromJsonList(
                    response.data["rajaongkir"]["results"]);
              },
              onChanged: (value) =>
                  controller.cityTujuanID.value = value?.cityId ?? "0",
            ),
            SizedBox(
              height: 10,
            ),
            DropdownSearch<Map<String, dynamic>>(
              items: [
                {
                  "code": "jne",
                  "name": "JNE",
                },
                {
                  "code": "pos",
                  "name": "POS INDONESIA",
                },
                {
                  "code": "tiki",
                  "name": "TIKI",
                }
              ],
              popupProps: PopupProps.menu(
                  itemBuilder: (context, item, isSelected) => ListTile(
                        title: Text("${item['name']}"),
                      )),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Jasa Pengiriman",
                  border: OutlineInputBorder(),
                ),
              ),
              dropdownBuilder: (context, selectedItem) =>
                  Text("${selectedItem?["name"] ?? 'Pilih'}"),
              onChanged: (value) => controller.jasper.value = value?['code'],
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
                controller: controller.beratC,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Berat (gram)",
                  border: OutlineInputBorder(),
                )),
            SizedBox(
              height: 10,
            ),
            Obx(() => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.cekOngkir();
                  }
                },
                child: Text(controller.isLoading.isFalse
                    ? "CEK ONGKIR"
                    : 'LOADING..'))),
            // Obx(() => Column(
            //       children: [
            //         controller.result.isEmpty
            //             ? Text('Informasi belum ada')
            //             : Column(
            //                 children: controller.result
            //                     .map((e) => ListTile(
            //                           title:
            //                               Text("${e.service!.toUpperCase()}"),
            //                           subtitle: Column(
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                             children: [
            //                               Text("${e.cost![0].etd}"),
            //                               Text("Rp ${e.cost![0].value}"),
            //                             ],
            //                           ),
            //                         ))
            //                     .toList(),
            //               )
            //       ],
            //     ))
          ],
        ));
  }
}
