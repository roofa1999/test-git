import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roofa/login/controller/login_controller.dart';
import 'package:roofa/pin_code/view/pin_code_screen.dart';
import 'package:roofa/widgets/background.dart';
import 'package:roofa/widgets/gradient_fab.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text("أدخل البريد الجامعي ",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Color(0xff707070))),
              ),
              GetBuilder<LoginController>(
                init: LoginController(),
                builder: (_) => Form(
                  key: _.formKey,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.20,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) {
                            return _.validateEmail(val!);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50.0),
                              topLeft: Radius.circular(50.0),
                            )),
                          ),
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width / 8.75,
                        top: 5,
                        child: GradientFloatingActionButton(
                          onPressed: () {
                            if (_.formKey.currentState!.validate()) {
                              Get.offNamed('/pincode_screen');
                            }
                          },
                          icon: Icons.arrow_forward,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
