import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/const_color.dart';

class ReportTController extends GetxController{
  var index = 0.obs;
  Color buttonActive = mainColor;
  Color textButtonActive = Colors.white;
  String? type_move;
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

  var timeFrom = DateTime.now().obs;
  var timeTo = DateTime.now().obs;


  var technicalName = ''.obs;
  var  helperTechnical = ''.obs;

  var expectedTime = DateTime.now().obs;

  var dayTime = 0.obs;

  void changeDayTime(index){
    index == 0? dayTime.value =0:dayTime.value=1;
  }
}