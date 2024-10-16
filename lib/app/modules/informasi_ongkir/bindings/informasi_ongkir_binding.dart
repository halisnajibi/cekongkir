import 'package:get/get.dart';

import '../controllers/informasi_ongkir_controller.dart';

class InformasiOngkirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InformasiOngkirController>(
      () => InformasiOngkirController(),
    );
  }
}
