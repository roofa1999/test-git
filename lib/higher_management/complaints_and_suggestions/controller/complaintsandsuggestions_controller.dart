import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Firebase/firebase.dart';
import '../../../const/const_color.dart';

class ComplaintsAndSuggestionsController extends GetxController{
  var listReport;
  var listReply;
  final textReply= TextEditingController();
  var index = 0.obs;

  Color buttonActive = mainColor;
  Color textButtonActive = Colors.white;

  PageController? controllerPageView;
  Future<String> sendReply() async {
    listReply=FirebaseController.report["reply"];
    listReply.add({
      "Time":DateTime.now(),
      "email":FirebaseController.email,
      "الاسم":FirebaseController.name,
      "الحالة":FirebaseController.report["الحالة"],
      "الجهة":FirebaseController.report["الجهة المستفيدة"],
      "الوصف":"${textReply.text}",
      "notification":FirebaseController.notification,
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
  Future<bool> fetchDataSuggestions() async {

    //========================================//
    try{
        await FirebaseFirestore.instance.collection("Suggestion").
        get().
        then((value) => {
          listReport=value.docs,
          print("listReport : "+"${listReport.length}"),
        });
        return true;
    }catch(e){
      print(e);
      return false;
    }

  }
  Future<bool> fetchDatacomplaints() async {

    //========================================//
    try{
      await FirebaseFirestore.instance.collection("complaint").
      get().
      then((value) => {
        listReport=value.docs,
        print("listReport : "+"${listReport.length}"),
      });
      return true;
    }catch(e){
      print(e);
      return false;
    }

  }
  @override
  void onInit() {
    controllerPageView = PageController(
        initialPage: 0
    );
    fetchDataSuggestions();
    super.onInit();
  }
  void onClickButton(val){
    index.value = val;
    print(index);
  }

}