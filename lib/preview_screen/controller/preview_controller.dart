import 'dart:async';

import 'package:get/get.dart';
import 'package:roofa/login/view/login_screen.dart';

class PreviewController extends GetxController{
  @override
  void onInit() {
    Timer(Duration(seconds: 3), () {
      Get.offNamed('/login_screen');
    });
    super.onInit();
  }
}