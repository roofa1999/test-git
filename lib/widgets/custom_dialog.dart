import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Future showCustomDialog({text = ''}){
  return Get.dialog(
    Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin:const EdgeInsets.symmetric(
            horizontal: 15
          ),
          width: double.infinity,
          height: 156,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0)
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('images/done_dialog.svg'),
              Material(
                color: Colors.transparent,
                child: Text('${text}',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff707070)
                ),),
              )
            ],
          ),
        ),
      ),
    )
  );
}
