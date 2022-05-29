import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:roofa/login/view/login_screen.dart';
import 'package:roofa/pin_code/controller/pincode_controller.dart';
import 'package:roofa/user_profile/view/user_profile_screen.dart';
import 'package:roofa/widgets/background.dart';
//final user = FirebaseAuth.instance.currentUser;
class PinCodeScreen extends StatelessWidget {
  final controller = Get.put(PinCodeController());
  PinCodeScreen(PhoneNumber phone){
   controller.phone=phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder(
        future: controller.f(),// controller.sendCode(),
        builder: (context,snapShot){
         if(!snapShot.hasData){
            return Center(child: CircularProgressIndicator());
         }else{
            return Background(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'أدخل رمز التحقق',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ادخل الرمز المرسل على البريد الالكتروني المكون من 6 ارقام ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  GetBuilder<PinCodeController>(
                      init: PinCodeController(),
                      builder: (_)=>Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PinCodeTextField(
                          appContext: context,
                          mainAxisAlignment: MainAxisAlignment.center,
                          animationType: AnimationType.fade,
                          onChanged: (val) async {
                            _.valueUserEnter = val.toString();
                            if(_.valueUserEnter == _.valuePinCode){
                              PhoneAuthCredential phoneAuthCredential =
                              PhoneAuthProvider.credential(
                                  verificationId: controller.verificationId1, smsCode: val);
                              await FirebaseAuth.instance.currentUser?.updatePhoneNumber(phoneAuthCredential).then((value) => Get.off(UserProfileScreen()));

                              //Get.off(UserProfileScreen());
                            }
                          },
                          length: 6,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.circle,
                            fieldWidth: 50,
                            activeFillColor: Colors.greenAccent,
                            inactiveColor: Colors.grey,
                            fieldOuterPadding: EdgeInsets.all(3),
                            activeColor: Colors.greenAccent,
                            inactiveFillColor: Colors.grey,
                            selectedColor: Colors.grey,
                            selectedFillColor: Colors.greenAccent,
                          ),
                        ),
                      )
                  ),
                  TextButton(
                    onPressed: () async{
                     // uploadingData("a","b","c",true);
                      //var snapshot=await FirebaseFirestore.instance.collection("products").snapshots();
                      //print(user?.email);
                      controller.sendCode();
                      print(controller.phone.completeNumber);
                      // Get.off(()=>LoginScreen());
                    },
                    child: Text(
                      'إعادة ارسال رمز التحقق',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        }
      )
    );
  }
  Future<void> uploadingData(String _productName, String _productPrice,
      String _imageUrl, bool _isFavourite) async {
    var add=await FirebaseFirestore.instance.collection("products").add({
      'productName': _productName,
      'productPrice': _productPrice,
      'imageUrl': _imageUrl,
      'isFavourite': _isFavourite,
      'isFavourite1': _isFavourite,
      'isFavourite2': _isFavourite,
    });
    print(add.id);
  }
}

