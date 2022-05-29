import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateEmail(String val){
    if((val.isEmpty)||(!val.trim().isEmail)){
      return 'Email error';
    }else{
      return null;
    }
  }
}