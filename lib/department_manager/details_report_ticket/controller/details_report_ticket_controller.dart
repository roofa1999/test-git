import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Firebase/firebase.dart';
import '../../../const/const_color.dart';

class DetailsReportTicketDMController extends GetxController{

  var index = 0.obs;
  Color buttonActive = mainColor;
  Color textButtonActive = Colors.white;
  final replayText = TextEditingController();
  var listReply;
  PageController? controllerPageView;


  Future<String> sendReply() async {
    listReply=FirebaseController.report["reply"];
    listReply.add({
      "Time":DateTime.now(),
      "email":FirebaseController.email,
      "الاسم":FirebaseController.name,
      "الحالة":FirebaseController.report["الحالة"],
      "الجهة":FirebaseController.report["الجهة المستفيدة"],
      "الوصف":"${replayText.text}",
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