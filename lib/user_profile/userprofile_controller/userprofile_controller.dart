import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:roofa/customer/Firebase/firebase.dart';

import '../../Firebase/firebase.dart';

class UserProfileController extends GetxController{
  late String name;
  late String email;
  late String typeUser;
  late String phoneNumber;

  late String firstEmail,lastEmail;
  Future<bool> fetchDataProfile() async {
    final user = await FirebaseAuth.instance.currentUser;
    if(user != null){
      await FirebaseController.fetchDataUser2(user);
      name=FirebaseController.name;
      email=FirebaseController.email;
      typeUser=FirebaseController.typeUser;
      phoneNumber=FirebaseController.phoneNumber;
      return true;
    }else{
      print("user null");
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