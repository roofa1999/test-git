import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/const_color.dart';

class ReportLogDMController extends GetxController{
  var index = 0.obs;
  Color buttonActive = mainColor;
  Color textButtonActive = Colors.white;

  PageController? controllerPageView;

  @override
  void onInit() {
    controllerPageView = PageController(
        initialPage: 0
    );
    super.onInit();
  }
  void onClickButton(val){
    index.value = val;
    print(index);
  }

}