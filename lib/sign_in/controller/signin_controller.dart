import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignInController extends GetxController{
GlobalKey<FormState> formKey = GlobalKey<FormState>();
final auth = FirebaseAuth.instance;
late String email;
late String password;
String? validateEmail(String val){
  if((val.isEmpty)||(!val.isEmail)){
    return 'Email error';
  }else{
    return null;
  }
}
}