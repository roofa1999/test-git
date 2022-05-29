import 'package:get/get.dart';

class PhoneNumberController extends GetxController{

  String? validatePhone(String val){
    if((val.isEmpty)||(!val.isPhoneNumber)){
      return 'Phone error';
    }else{
      return null;
    }
  }
}