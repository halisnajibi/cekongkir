import 'package:cekongkir/app/data/models/informasi_model.dart';
import 'package:cekongkir/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/ongkir_model.dart';
import '../controllers/informasi_ongkir_controller.dart';

class InformasiOngkirView extends GetView<InformasiOngkirController> {
  final List<Ongkir> ongkirList;
  final Informasi? detailInformasi;
  final HomeController homeC = HomeController();
  InformasiOngkirView(
      {required this.ongkirList, required this.detailInformasi});
  @override
  Widget build(BuildContext context) {
    print(detailInformasi!.destinationDetails!.province);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Ongkir'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${detailInformasi!.originDetails!.province}"),
                    Icon(Icons.arrow_forward_ios_outlined),
                    Text("${detailInformasi!.destinationDetails!.province}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${detailInformasi!.originDetails!.cityName}"),
                    Text("${detailInformasi!.destinationDetails!.cityName}"),
                  ],
                )
              ],
            ),
          ),
          Divider(),
          Column(
            children: ongkirList
                .map((e) => ListTile(
                      title: Text('${e.description} - ${e.service}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${e.cost![0].etd}"),
                          Text("Rp ${e.cost![0].value}"),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
