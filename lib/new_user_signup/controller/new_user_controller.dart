import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';
//import 'package:roofa/customer/Firebase/firebase.dart';

import '../../Firebase/firebase.dart';

class NewUserController extends GetxController{
final formKey = GlobalKey<FormState>();
final auth = FirebaseAuth.instance;
late String name;
late String email;
late PhoneNumber phone;
late String password;
Future<bool> addUser() async {
  if(FirebaseController.checkType(email).contains("student")){
    await FirebaseFirestore.instance.collection("user_student").add({
      'name':name,
      'email':email,
      //'password':password,
      'phone':phone.completeNumber,
      'type':"كلية الحاسب الالي ونظم المعلومات",
    }).then((value) => {
      print("confirm : [ name:"+name+",email:"+email+",phone:"+phone.completeNumber+",type:"+"كلية الحاسب الالي ونظم المعلومات"+" ]"),
    });
    return true;
  }else{
    print("هذا الحساب ليس لطالب");
    return false;
  }

}
String? validateEmail(String val){
  if((val.isEmpty)||(!val.isEmail)){
    return 'Email error';
  }else{
    return null;
  }
}

String? validateUserName(String val){
  if(val.trim().isEmpty){
    return 'Username error';
  }else{
    return null;
  }
}
}