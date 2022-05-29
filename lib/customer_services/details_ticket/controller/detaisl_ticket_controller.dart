import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Firebase/firebase.dart';
import '../../../const/const_color.dart';

class DetailsTicketCSController extends GetxController{

  var index = 0.obs;
  Color buttonActive = mainColor;
  Color textButtonActive = Colors.white;
  String? textReply,causeReply;
  var listReply;
  PageController? controllerPageView;
  var notification=[
    {"notification":false,},
    {"notification":false,},
    {"notification":false,},
    {"notification":false,},
    {"notification":false,},
  ];

  Future<String> sendReply() async {
    listReply=FirebaseController.report["reply"];
    listReply.add({
      "Time":DateTime.now(),
      "email":FirebaseController.email,
      "الاسم":FirebaseController.name,
      "الحالة":FirebaseController.report["الحالة"],
      "الجهة":FirebaseController.report["الجهة المستفيدة"],
      "الوصف":"${textReply}",
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
  Future<String> sendRefusal() async {
    listReply=FirebaseController.report["tracking"];
    listReply.add({
      "Time":DateTime.now(),
      "email":FirebaseController.email,
      "رقم التذكرة":FirebaseController.report["رقم البلاغ"],
     // "نوع الحركة":"لم يتم الإنجاز",
      "اسم الجهاز":"",
      "نوع الجهاز":"",
      "مدخل التقرير":FirebaseController.name,
      "الحالة":"مرفوضة",
      "الوصف":"${causeReply}",
      "notification":notification,
    });
    print(FirebaseController.report.id);
    final send=await FirebaseFirestore.instance.collection("reports").doc(FirebaseController.report.id).update(
        {
       //   "tracking":listReply,
          "الحالة":"مرفوضة",
         // "نوع الحركة":"لم يتم الإنجاز",
        }).then((value){
      print("تم ارسال سبب رفض التذكرة");
      return "تم ارسال سبب رفض التذكرة";
    });
    if(send.isEmpty){
      print("لم يتم ارسال سبب رفض التذكرة");
      return "لم يتم ارسال سبب رفض التذكرة";
    }
    else{
      return "تم ارسال سبب رفض التذكرة";
    }

  }
  Future<String> sendAssignment() async {
    listReply=FirebaseController.report["tracking"];
    listReply.add({
      "Time":DateTime.now(),
      "email":FirebaseController.email,
      "رقم التذكرة":FirebaseController.report["رقم البلاغ"],
      //"نوع الحركة":"إحالة التذكرة لمركز الصيانة",
      "اسم الجهاز":"",
      "نوع الجهاز":"",
      "مدخل التقرير":FirebaseController.name,
      "الحالة":"جديدة",
      "الوصف":"${causeReply}",
      "notification":notification,

    });
    print(FirebaseController.report.id);
    final send=await FirebaseFirestore.instance.collection("reports").doc(FirebaseController.report.id).update(
        {
          "الجهة":"مدير القسم",
        //  "tracking":listReply,
        "الحالة":"معتمدة",
          "notification":FirebaseController.notification,
         // "نوع الحركة":"إحالة التذكرة لمركز الصيانة",
        }).then((value){
      print("تم تحويل التذكرة لقسم الصيانة");
      return "تم تحويل التذكرة لقسم الصيانة";
    });
    if(send.isEmpty){
      print("لم يتم تحويل التذكرة لقسم الصيانة");
      return "لم يتم تحويل التذكرة لقسم الصيانة";
    }
    else{
      return "تم تحويل التذكرة لقسم الصيانة";
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
}