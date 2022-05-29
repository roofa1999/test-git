import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:roofa/Firebase/notification.dart';
import '../../../Firebase/firebase.dart';

class HomePageDMController extends GetxController{
  late String name;
  late String typeUser;
  int numberNotification=0;
  List<Notifications> notification=[
    Notifications(numText: 0,number: 0),
    Notifications(numText: 1,number: 0),
    Notifications(numText: 2,number: 0),
    Notifications(numText: 4,number: 0),
    Notifications(numText: 5,number: 0),
  ];
  Future<bool> fetchDataProfile() async {
    final user = await FirebaseAuth.instance.currentUser;
    if(user != null){
      await FirebaseController.fetchDataUser2(user);
      name=FirebaseController.name;
      typeUser=FirebaseController.typeUser;
      return true;
    }else{
      print("user null");
      return false;
    }
  }
  Future<bool> fetchNotification() async {
    //========================================//
    try{
      notification=[
        Notifications(numText: 0,number: 0),
        Notifications(numText: 1,number: 0),
        Notifications(numText: 2,number: 0),
        Notifications(numText: 4,number: 0),
        Notifications(numText: 5,number: 0),
      ];
      await FirebaseFirestore.instance.collection("reports").
     // where("email",isEqualTo: FirebaseController.email).
      get().
      then((value) => {
        value.docs.forEach((element) {
          if(element["الجهة"]=="مدير القسم"&&
              element["الحالة"]=="معتمدة"&&
              !element["notification"][2]["notification"])
                      notification[3].number++;
          else if(!element["notification"][2]["notification"]) notification[0].number++;
          if(element["الحالة"]=="معتمدة"&&element["notification"][4]["notification"]) notification[4].number++;
          element["tracking"].forEach((track) {
              if(track["الحالة"]=="معتمدة"&&track["notification"][2]["notification"]) notification[4].number++;
              if(!track["notification"][2]["notification"]){
                if(track["الحالة"]=="مغلقة") notification[1].number++;
                else if(track["الحالة"]=="مرفوضة") notification[2].number++;
              }
          });
        }),
        numberNotification=0,
        notification.forEach((element) {
          (element.number>0)?numberNotification++:"";
        }),
        print("تذاكر محولة : "+"${notification[0].number}"),
        print("تذاكر مغلقة : "+"${notification[1].number}"),
        print("تذاكر مرفوضة : "+"${notification[2].number}"),
        print("تذاكر جديدة : "+"${notification[3].number}"),
        print("تذاكر محولة اليك : "+"${notification[4].number}"),
        print("number Notification :"+"${numberNotification}"),
      });
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchDataProfile();
    super.onInit();
  }
}