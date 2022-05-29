import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roofa/insert_phone_number/controller/phonenumber_controller.dart';
import 'package:roofa/user_profile/view/user_profile_screen.dart';
import 'package:roofa/widgets/background.dart';
import 'package:roofa/widgets/custom_dialog.dart';
import 'package:roofa/widgets/gradient_fab.dart';
import 'package:roofa/widgets/show_alert_dialog.dart';


class InsertPhoneNumberScreen extends StatelessWidget {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
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
                  "أدخل رقم الجوال",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Color(0xff707070),
                      ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 80),
                    child: Container(
                      height: 70,
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
                      child: GetBuilder<PhoneNumberController>(
                        init: PhoneNumberController(),
                        builder: (_)=>Form(
                          key: keyForm,
                          child: Row(
                            children: [
                              Expanded(
                                child: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: TextFormField(
                                    validator: (val){
                                      return _.validatePhone(val!);
                                    },
                                    style: TextStyle(fontSize: 27),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      hintText: "5XXXXXXXX",
                                      hintStyle: TextStyle(
                                        color: Color(0xff707070),
                                        fontSize: 27,
                                      ),
                                      // border: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.horizontal(
                                      //     left: Radius.circular(50),
                                      //   ),
                                      // ),
                                    ),
                                  ),
                                ),
                              ),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Row(
                                  children: [
                                    SizedBox(width: 30),
                                    //ToDo: Use package numberPhone To Code Country
                                    Text(
                                      "+966",
                                      style: TextStyle(
                                        fontSize: 27,
                                        color: Color(0xff447A78),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      height: 45,
                                      width: 0.5,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ),
                  ),
                  Positioned(
                    left: 60,
                    top: 7,
                    child: GradientFloatingActionButton(
                      onPressed: () {
                        if(keyForm.currentState!.validate()){
                         Get.off(()=>UserProfileScreen());
                         showCustomDialog(text: 'تم تعديل رقم الهاتف بنجاح');

                        }

                      },
                      icon: Icons.arrow_forward,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
