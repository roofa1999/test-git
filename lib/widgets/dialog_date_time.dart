import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roofa/Customer/supervise_reports/controller/supervise_controller.dart';
import 'package:roofa/const/const_color.dart';

import 'material_text.dart';

class DalogDateTime extends StatelessWidget {
  final controller = Get.put(SuperviserReportController());
  var onChange;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Container(
          margin:
          EdgeInsets.symmetric(horizontal: 50.w),
          padding: EdgeInsets.all(12.0),
          width: Get.width,
          height: 250.h,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: mainColor, width: 2),
              borderRadius:
              BorderRadius.circular(20.r)),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: MaterialText(
                    text: 'عرض البيانات من فتره زمنية',
                    fontSize: 13.sp,
                    color: mainColor,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold),
              ),
              MaterialText(
                text: 'من',
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
              SizedBox(height: 10.h,),
              Obx(
                  ()=>Expanded(
                      child: Material(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50.r),
                                boxShadow: [
                                  BoxShadow(
                                      color: colorShadowSearch.withOpacity(.56),
                                      offset: Offset(0,4),
                                      blurRadius: 10
                                  )
                                ]
                            ),
                            child: DateTimePicker(
                              initialValue: controller.timeFrom.value.toString(),
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2050),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.date_range_sharp),
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 0
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0
                                    )

                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 0
                                    )

                                ),
                              ),
                            ),
                          ))
                  ),
              ),
              SizedBox(height: 10.h,),
              MaterialText(
                text: 'إلى',
                color: mainColor,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
              SizedBox(height: 10.h,),
              Expanded(
                  child: Material(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.r),
                            boxShadow: [
                              BoxShadow(
                                  color: colorShadowSearch.withOpacity(.56),
                                  offset: Offset(0,4),
                                  blurRadius: 10
                              )
                            ]
                        ),
                        child: DateTimePicker(
                          initialValue: controller.timeTo.value.toString(),
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.date_range_sharp),
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0
                                )

                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 0
                                )

                            ),
                          ),
                        ),
                      ))
              ),
              SizedBox(height: 10.h,),
              GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    margin: EdgeInsets.symmetric(
                      horizontal: 50.w,
                      vertical: 15.h
                    ),
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(50.r)
                    ),
                    child: MaterialText(
                        text: 'تأكيد',
                      color: Colors.white,
                        fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
