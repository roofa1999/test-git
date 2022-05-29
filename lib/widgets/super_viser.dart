import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/const_color.dart';
Widget buildInfoTicket({required label,required value}){
  return Expanded(
    child: Row(
      children: [
        Text('$label: ',style: TextStyle(
            fontWeight: FontWeight.bold,
            color: mainColor,
            fontSize: 16.sp
        ),),
        Text('$value',style: TextStyle(
            color: mainColor
        ),),
      ],
    ),
  );

}

Widget buildContainer({
  required height,
  required color,
  required child
}){
  return Container(
      height: height,
      margin:
      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: colorShadowSearch.withOpacity(.23),
              blurRadius: 10,
              offset: Offset(0, 9),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color:color,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15.r),
                      bottomRight: Radius.circular(15.r),
                    )),
              )),
          Expanded(
              flex: 18,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: child,
              )),
        ],
      )
  );

}