import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roofa/recovery_password/controller/recoverypass_controller.dart';
import 'package:roofa/sign_in/view/sign_in_screen.dart';
import 'package:roofa/user_profile/view/user_profile_screen.dart';
import 'package:roofa/widgets/background.dart';
import 'package:roofa/widgets/custom_dialog.dart';
import 'package:roofa/widgets/custom_text_field.dart';
import 'package:roofa/widgets/gradient_fab.dart';
import 'package:roofa/widgets/show_alert_dialog.dart';

class RecoveryPasswordScreen extends StatelessWidget {
  const RecoveryPasswordScreen({Key? key}) : super(key: key);

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
                  "استعادة كلمة المرور",
                  style: Theme.of(context).textTheme.headline4!.copyWith(color: Color(0xff707070)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 80),
                child: GetBuilder<RecoveryPasswordController>(
                  init: RecoveryPasswordController(),
                  builder: (_)=>Form(
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
                              CustomTextField(
                                onchange: (val){
                                  _.newPassword = val;
                                },
                                validate: (val){
                                  return _.validateRecoveryPass(val);
                                },
                                title: "كلمة المرور الجديدة",
                                imagePath: "images/password.png",
                                obscureText: true,
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                                color: Color(0xFF707070).withOpacity(0.3),
                              ),
                              CustomTextField(
                                validate: (val){
                                  return _.validateRecoveryConfrimPass(val);
                                },
                                title: "التأكد من كلمة المرور الجديدة",
                                imagePath: "images/password.png",
                                obscureText: true,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: -20,
                          child: GradientFloatingActionButton(
                            onPressed: () async{
                              if(_.formKey.currentState!.validate()){
                                bool update = false;
                                await FirebaseAuth.instance.currentUser?.updatePassword(_.newPassword).then((value) => update = true);
                                if(update){
                                  Get.off(()=>UserProfileScreen());
                                  showCustomDialog(text: 'تم تغيير كلمة السر بنجاح');
                                }
                              }
                            },
                            icon: Icons.arrow_forward,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
