import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RecoveryPasswordController extends GetxController{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String newPassword;

  String? validateRecoveryPass(String val){
    if(val.isEmpty||val.length<5){
      return 'password very weak';
    }else{
      return null;
    }
  }
  String? validateRecoveryConfrimPass(String val){
    if(val.isEmpty||(val != newPassword)){
      return 'password not same';
    }else{
      return null;
    }
  }
}