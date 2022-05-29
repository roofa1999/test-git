import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:roofa/const/const_color.dart';
import 'package:roofa/preview_screen/controller/preview_controller.dart';
import 'package:roofa/widgets/background.dart';

class PreviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: GetBuilder<PreviewController>(
          init: PreviewController(),
          builder: (_)=>Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                  'images/logo.svg'
              ),
              CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(mainColor)
              )
            ],
          ),
        )
      ),
    );
  }
}
