import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Firebase/firebase.dart';
import '../../../const/const_color.dart';

class ChosenTechnicalForTicketDMController extends GetxController{
  var index = 0.obs;
  Color buttonActive = mainColor;
  Color textButtonActive = Colors.white;
  String? textReply,causeReply;
  final replayText = TextEditingController();
  final replayCause = TextEditingController();
  var listReply;
  PageController? controllerPageView;

  var notification=[
    {"notification":false,},
    {"notification":false,},
    {"notification":false,},
    {"notification":false,},
    {"notification":false,},
  ];

  var timeFrom = DateTime.now().obs;
  var timeTo = DateTime.now().obs;


  var technicalName = ''.obs;
  var  helperTechnical = ''.obs;

  var expectedTime1 = DateTime.now().obs;
  var expectedTime2 = DateTime.now().obs;

  var dayTime = 0.obs;

  Future<String> sendReply() async {
    listReply=FirebaseController.report["reply"];
    listReply.add({
      "Time":DateTime.now(),
      "email":FirebaseController.email,
      "الاسم":FirebaseController.name,
      "الحالة":FirebaseController.report["الحالة"],
      "الجهة":FirebaseController.report["الجهة المستفيدة"],
      "الوصف":"${replayText.text}",
      "notification":notification,
    });
    print(FirebaseController.report.id);
    final send=await FirebaseFirestore.instance.collection("reports").doc(FirebaseController.report.id).update(
        {
          "reply":listReply,
        }).then((value){
      print("تم إضافة رد");
      return "تم إضافة رد";
    });
    if(send.isEmpty){
      print("لم يتم إضافة رد");
      return "لم يتم إضافة رد";
    }
    else{
      return "تم إضافة رد";
    }

  }
  Future<String> sendAssignment() async {
    listReply=FirebaseController.report["tracking"];
    listReply.add({
      "Time":DateTime.now(),
      "email":FirebaseController.email,
      "رقم التذكرة":FirebaseController.report["رقم البلاغ"],
      "نوع الحركة":"إحالة التذكرة لخدمة العملاء",
      "اسم الجهاز":"",
      "نوع الجهاز":"",
      "مدخل التقرير":FirebaseController.name,
      "الحالة":"جديدة",
      "الوصف":"${replayCause.text}",
      "notification":notification,
    });
    print(FirebaseController.report.id);
    final send=await FirebaseFirestore.instance.collection("reports").doc(FirebaseController.report.id).update(
        {
       //   "tracking":listReply,
        //  "الحالة":"معلقة",
         // "نوع الحركة":"إحالة التذكرة لخدمة العملاء",
          "الجهة":"خدمة العملاء",
        }).then((value){
      print("تم تحويل التذكرة  لخدمة العملاء");
      return "تم تحويل التذكرة  لخدمة العملاء";
    });
    if(send.isEmpty){
      print("لم يتم تحويل التذكرة  لخدمة العملاء");
      return "لم يتم تحويل التذكرة  لخدمة العملاء";
    }
    else{
      return "تم تحويل التذكرة  لخدمة العملاء";
    }

  }
  Future<String> chooseTechnical() async {
    listReply=FirebaseController.report["tracking"];
    listReply.add({
      "Time":DateTime.now(),
      "email":FirebaseController.email,
      "رقم التذكرة":FirebaseController.report["رقم البلاغ"],
      "نوع الحركة":"إحالة التذكرة لمركز الصيانة",
      "اسم الجهاز":"",
      "نوع الجهاز":"",
      "مدخل التقرير":FirebaseController.name,
      "الحالة":"تحت الإجراء",
      "الوصف":"${causeReply}",
      "notification":notification,
    });
    print(FirebaseController.report.id);
    final send=await FirebaseFirestore.instance.collection("reports").doc(FirebaseController.report.id).update(
        {

          //"tracking":listReply,
          "الحالة":"تحت الإجراء",
          //"نوع الحركة":"إحاطلة التذكرة لمركز الصيانة",
          "الجهة":"الفنيين",
          "TimeTo":DateTime.parse(expectedTime1.toString()),
          "TimeFor":DateTime.parse(expectedTime2.toString()),
        }).then((value){
      print("تم تحويل التذكرة  لمركز الصيانة");
      return "تم تحويل التذكرة  لمركز الصيانة";
    });
    if(send.isEmpty){
      print("لم يتم تحويل التذكرة  لمركز الصيانة");
      return "لم يتمتحويل التذكرة  لمركز الصيانة";
    }
    else{
      return "تم تحويل التذكرة  لمركز الصيانة";
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
  void changeDayTime(index){
    index == 0? dayTime.value =0:dayTime.value=1;
  }
}