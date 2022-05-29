import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
//import 'package:roofa/customer/Firebase/firebase.dart';
import 'package:roofa/new_user_signup/view/new_user_screen.dart';
import 'package:roofa/recovery_password/view/recovery_password_screen.dart';
import 'package:roofa/sign_in/controller/signin_controller.dart';
import 'package:roofa/user_profile/view/user_profile_screen.dart';
import 'package:roofa/widgets/background.dart';
import 'package:roofa/widgets/custom_text_field.dart';
import 'package:roofa/widgets/gradient_fab.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Firebase/firebase.dart';
import '../../const/text_app.dart';
import '../../customer/home_page/view/home_screen.dart';
import '../../customer_services/home_page/view/home_page.dart';
import '../../department_manager/home_page/view/home_page.dart';
import '../../higher_management/homepage/view/home_screen.dart';
import '../../technical/home_screen/view/home_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

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
                  "تسجيل الدخول",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Color(0xff707070)),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 80),
                  child: GetBuilder<SignInController>(
                    init: SignInController(),
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
                                left: Radius.circular(50),
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
                                    Image.asset(
                                      "images/email.png",
                                      width: 40,
                                      height: 40,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (val){
                                          return _.validateEmail(val!);
                                        },
                                        onChanged: (val){_.email=val;},
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          hintText: "البريد الالكتروني",
                                          hintStyle: TextStyle(
                                            color: Color(0xff707070),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 30),
                                  ],
                                ),
                                Divider(
                                  height: 20,
                                  thickness: 1,
                                  color: Color(0xFF707070).withOpacity(0.3),
                                ),
                                CustomTextField(
                                  title: "كلمة المرور",
                                  imagePath: "images/password.png",
                                  onchange: (val){_.password=val;},
                                  obscureText: true,
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
                                  final newUser = await _.auth.signInWithEmailAndPassword(
                                      email: _.email, password: _.password).then((value) async => {
                                    if(_.formKey.currentState!.validate()){
                                      print("done log in"),
                                      /************************/
                                      goToPageSign(_.email, value.user),
                                      /***********************/

                                      /*if(FirebaseController.checkType(_.email).contains("student")){
                                        Get.off(()=>HomeScreen()),
                                      }else if(FirebaseController.checkType(_.email).contains("manager")){
                                        await FirebaseController.fetchDataUser2(value.user!),
                                        if(FirebaseController.typeUser.contains("خدمة العملاء")){
                                          Get.off(()=>HomeScreenCS()),
                                        }else if(FirebaseController.typeUser.contains("الفنيين")){
                                          Get.off(()=>HomeScreenT()),
                                        }else if(FirebaseController.typeUser.contains("الإدارة العليا")){
                                          Get.off(()=>HomeScreenHM()),
                                        }else if(FirebaseController.typeUser.contains("مدير القسم")){
                                          Get.off(()=>HomeScreenDM()),
                                        }else {
                                          Get.off(()=>UserProfileScreen()),
                                        }
                                      }
                                      else{
                                        Get.off(()=>UserProfileScreen()),
                                      }*/


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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 15.0
                    ),
                    child: TextButton(
                        onPressed: () async {

                          if(! await launch(urlUniversity)){
                            Get.snackbar("Error", "Check your Internet");
                          }
                          // Get.to(RecoveryPasswordScreen());
                        },
                        child: Text(
                          'نسيت كلمة المرور',
                          style: TextStyle(color: Color(0xff28A2CF)),
                        )),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     right: 15.0
                  //   ),
                  //   child: TextButton(
                  //       onPressed: () {
                  //         Get.to(NewUserSignUpScreen());
                  //       },
                  //       child: Text(
                  //         'ليس لدي حساب',
                  //         style: TextStyle(color: Color(0xff28A2CF)),
                  //       )),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  goToPageSign(String email,User? user) async {
    if(FirebaseController.checkType(email).contains("student")){
      Get.off(()=>HomeScreen());
    }else if(FirebaseController.checkType(email).contains("manager")){
    await FirebaseController.fetchDataUser2(user!);
    if(FirebaseController.typeUser.contains("خدمة العملاء")){
    Get.off(()=>HomeScreenCS());
    }else if(FirebaseController.typeUser.contains("الفنيين")){
    Get.off(()=>HomeScreenT());
    }else if(FirebaseController.typeUser.contains("الإدارة العليا")){
    Get.off(()=>HomeScreenHM());
    }else if(FirebaseController.typeUser.contains("مدير القسم")){
    Get.off(()=>HomeScreenDM());
    }else {
    Get.off(()=>UserProfileScreen());
    }
    }
    else{
    Get.off(()=>UserProfileScreen());
    }
  }
  goToPage(String email) async {
    if(FirebaseController.checkType(email).contains("student")){
      Get.off(()=>HomeScreen());
    }else if(FirebaseController.checkType(email).contains("manager")){
      if(FirebaseController.typeUser.contains("خدمة العملاء")){
        Get.off(()=>HomeScreenCS());
      }else if(FirebaseController.typeUser.contains("الفنيين")){
        Get.off(()=>HomeScreenT());
      }else if(FirebaseController.typeUser.contains("الإدارة العليا")){
        Get.off(()=>HomeScreenHM());
      }else if(FirebaseController.typeUser.contains("مدير القسم")){
        Get.off(()=>HomeScreenDM());
      }else {
        Get.off(()=>UserProfileScreen());
      }
    }
    else{
      Get.off(()=>UserProfileScreen());
    }
  }
}
