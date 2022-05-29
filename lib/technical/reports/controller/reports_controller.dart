import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Firebase/firebase.dart';
import '../../../const/const_color.dart';

class ReportsTController extends GetxController{
  var index = 0.obs;
  Color buttonActive = mainColor;
  Color textButtonActive = Colors.white;
  String? typeMove="",textReport="",state="";
  var listReply;
  bool check(){
    if(typeMove=="")return false;
    else if(textReport=="")return false;
    else return true;
  }
  PageController? controllerPageView;

  Future<String> sendAssignment() async {
    String state="";
    if(typeMove=="تم الإنجاز") state="مغلقة";
    else if(typeMove=="لم يتم الإنجاز") state="معلقة";
    else if(typeMove=="معاينة") state="تحت الإجراء";
    listReply=FirebaseController.report["tracking"];
    listReply.add({
      "Time":DateTime.now(),
      "email":FirebaseController.email,
      "رقم التذكرة":FirebaseController.report["رقم البلاغ"],
      "نوع الحركة":typeMove,
      "اسم الجهاز":"",
      "نوع الجهاز":"",
      "مدخل التقرير":FirebaseController.name,
      "الحالة":state,
      "الوصف":"${textReport}",
      "notification":FirebaseController.notification,
    });
    print(FirebaseController.report.id);
    final send=await FirebaseFirestore.instance.collection("reports").doc(FirebaseController.report.id).update(
        {
          "tracking":listReply,
          "الحالة":state,
          "نوع الحركة":typeMove,
          "notification":FirebaseController.notification,
        }).then((value){
      print("تم إضافة حركة");
      return "تم إضافة حركة";
    });
    if(send.isEmpty){
      print("لم يتم إضافة حركة");
      return "لم يتم إضافة حركة";
    }
    else{
      return "تم إضافة حركة";
    }

  }
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