import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:roofa/Firebase/firebase.dart';
import 'package:roofa/customer/send_report/controller/send_report_controller.dart';

class DetailsProblemController extends GetxController{
  SendReportVal sendReportVal=SendReportVal();
  final textReply=TextEditingController();
  late String definingProblem="";
  late String extentDamage="";
  var description=TextEditingController();
  bool check(){
    if(definingProblem=="")return false;
    else if(extentDamage=="")return false;
    else if(description.text=="")return false;
    else return true;
  }
  void setVal(String name,String val){
    switch(name){
      case "تحديد المشكلة":
        definingProblem=val;
        break;
      case "مدى الضرر":
        extentDamage=val;
        break;
      case "الوصف":
        description.text=val;
        break;
    }
  }
  String? getVal(String name){
    switch(name){
      case "تحديد المشكلة":
        return definingProblem;
      case "مدى الضرر":
        return extentDamage;
      case "الوصف":
        return description.text;
    }
    return "";
  }

  Future<bool> sendReport() async {
    var notification=[
      {"notification":false,},
      {"notification":false,},
      {"notification":false,},
      {"notification":false,},
      {"notification":false,},
    ];
    if(FirebaseController.email.isNotEmpty){
      print(FirebaseController.email);
      try{
        String generateRandomString= FirebaseController.generateRandomString2(4,3);
        final req=await FirebaseFirestore.instance.collection("reports").add({
          'email':FirebaseController.email,
          'phone':FirebaseController.phoneNumber,
         // 'المستفيد':{
            'الاسم':FirebaseController.name,
            'الجهة المستفيدة':sendReportVal.headquarters,
            'المقر':sendReportVal.beneficiary,
            'المبنى':sendReportVal.roomNumber,//sendReportVal.building,
            'الطابق':sendReportVal.roomType,//sendReportVal.floor,
           // 'نوع الغرفة':sendReportVal.roomType,
          'نوع الغرفة':sendReportVal.floor,//sendReportVal.roomType,
            'رقم الغرفة':sendReportVal.building,//sendReportVal.roomNumber,
            'تحديد المشكلة':definingProblem,
            'مدى الضرر':extentDamage,
            'الوصف':description.text,
            'رقم البلاغ':generateRandomString,
            'Time':DateTime.now(),
          'TimeTo':DateTime.now(),
          'TimeFor':DateTime.now(),
          //'time':"${DateTime.now()}",
          //},
          'نوع الحركة':"",
          'الحالة':"جديدة",
          'القسم':"",
          "الجهة":"خدمة العملاء",
          "notification":notification,
          'tracking':[],
          'reply':[],
        }).then((value) =>
        {
          print("confirm : [ email : "+FirebaseController.email+","+
              'الاسم : '+FirebaseController.name+","+
              'الجهة المستفيدة: '+sendReportVal.headquarters+","+
              'المقر: '+sendReportVal.beneficiary+","+
              'المبنى: '+sendReportVal.building+","+
              'الطابق: '+sendReportVal.floor+","+
              'نوع الغرفة : '+sendReportVal.roomType+","+
              'رقم الغرفة : '+sendReportVal.roomNumber+","+
              'تحديد المشكلة : '+definingProblem+","+
              'مدى الضرر : '+extentDamage+","+
              'الوصف : '+description.text+","+
              'رقم البلاغ : '+generateRandomString+","+
              'الحالة : '+"جديدة"+","+
              'Time :'+"${DateTime.now()}"+" ]"),
        });
        return true;
      }catch(e){
        print(e);
        return false;
      }
    }else{
      print("فشل الارسال");
      return false;
    }

  }

}