import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:roofa/login/view/login_screen.dart';
import 'package:roofa/new_user_signup/controller/new_user_controller.dart';
import 'package:roofa/widgets/background.dart';
import 'package:roofa/widgets/custom_text_field.dart';
import 'package:roofa/widgets/gradient_fab.dart';

import '../../pin_code/view/pin_code_screen.dart';
late String verificationId1;
class NewUserSignUpScreen extends StatelessWidget {
  const NewUserSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "إنشاء حساب",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Color(0xff707070)),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 80),
                  child: GetBuilder<NewUserController>(
                    init: NewUserController(),
                    builder: (_) => Form(
                      key: _.formKey,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black38,
                              ),
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(150),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 2,
                                  offset: Offset(5, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        validator: (val) {
                                          return _.validateUserName(val!);
                                        },
                                        onChanged: (val){_.name=val;},
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                              Icons.account_circle_rounded),
                                          border: UnderlineInputBorder(),
                                          hintText: "اسم المستخدم",
                                          hintStyle: TextStyle(
                                            color: Color(0xff707070),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                      child: IntlPhoneField(
                                        showCountryFlag: true,
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                          hintText: 'رقم الهاتف',
                                          prefixIcon: Icon(Icons.phone_android,color: Colors.red,),
                                          border: UnderlineInputBorder(),
                                        ),
                                        initialCountryCode: 'SA',
                                        disableLengthCheck: true,
                                        onChanged: (phone) {
                                          print(phone.completeNumber);
                                          _.phone=phone;
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                  ],
                                ),

                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        validator: (val) {
                                          return _.validateEmail(val!);
                                        },
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        onChanged: (val){_.email=val;},
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.email),
                                          border: UnderlineInputBorder(),
                                          hintText: "البريد الالكتروني",
                                          hintStyle: TextStyle(
                                            color: Color(0xff707070),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                        validator: (val) {},
                                        onChanged: (val){_.password=val;},
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.lock),
                                          enabledBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          hintText: "كلمة المرور",
                                          hintStyle: TextStyle(
                                            color: Color(0xff707070),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: -20,
                            child: GradientFloatingActionButton(
                              onPressed: () async {
                                //print(_.auth.currentUser);
                                try {
                                 /* await _.auth.verifyPhoneNumber(
                                    phoneNumber: _.phone.completeNumber,
                                    verificationCompleted: (phoneAuthCredential) async {
                                      print("phoneAuthCredential");
                                      print(phoneAuthCredential);
                                      print("phoneAuthCredential");
                                      //signInWithPhoneAuthCredential(phoneAuthCredential);
                                      },
                                    verificationFailed: (verificationFailed) async {print(verificationFailed);},
                                    codeSent: (verificationId, resendingToken) async {
                                        verificationId1 = verificationId;
                                        print("verificationId");
                                        print(verificationId);
                                        print("verificationId");

                                    },
                                    codeAutoRetrievalTimeout: (verificationId) async {
                                      print("verificationId1");
                                      print(verificationId);
                                      print("verificationId1");
                                    },
                                  );*/
                                  final newUser = await _.auth.createUserWithEmailAndPassword(
                                      email: _.email, password: _.password).then((value) async => {
                                    await FirebaseAuth.instance.currentUser!.updateDisplayName(_.name),
                                 // FirebaseAuth.instance.signInWithPhoneNumber(_.phone.completeNumber),
                                    if(_.formKey.currentState!.validate()){
                                      await _.addUser(),
                                     //Get.off(()=>PinCodeScreen(_.phone)),
                                    }
                                  });
                                } catch (e) {
                                  print(e);
                                }
                              },
                              icon: Icons.arrow_forward,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: TextButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    child: Text(
                      'لديك حساب بالفعل',
                      style: TextStyle(color: Color(0xff28A2CF)),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
