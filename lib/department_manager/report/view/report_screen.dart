import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:roofa/department_manager/home_page/view/home_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../const/const_color.dart';
import '../../../const/text_app.dart';
import '../../../const_pdf.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/material_text.dart';
import 'package:intl/intl.dart' as intl;

class ReportDMScreen extends StatelessWidget {
List<dynamic> c =  reportInformation
['report_ticnicals'];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("التقرير"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              Get.back();
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.off(()=>HomeScreenDM());
                },
                icon: Icon(
                  Icons.home,
                  size: 30.r,
                ))
          ],
        ),
        body: SingleChildScrollView( // هذه مثل اللListView  تعطي لل column سكرول لاعلى واسفل
          child: Column( // عناصر بشكل عمودي
            children: [
              GestureDetector( // عند الكبس على هذا الزر يجب تحميل التقارير
                onTap: ()async{
               await launch(getReportFile);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5
                  ),
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  height: Get.width / 7.5,
                  child: SvgPicture.asset('images/download.svg'), // وصع الصورة بدقة عالية
                  //صورة تحميل التقرير بصيغة  svg
                ),
              ),
              Container( // هنا كالعادة ارسم شكل كونتينر التذكرة واضع المعلومات بداخله row وبداخلها نصوص
                margin:
                EdgeInsets.symmetric(horizontal: 12.w,
                    vertical: 10.h),
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
                child: LayoutBuilder(
                  builder: (context, constrains) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Container(
                              height: Get.height - 100.h,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15.r),
                                    bottomRight: Radius.circular(15.r),
                                  )),
                            )),
                        Expanded(
                            flex: 18,
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Wrap(
                                            children: [
                                              Text(
                                                'رقم  التذكرة: ',
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontWeight: FontWeight
                                                        .bold,
                                                    fontSize: 15.sp),
                                              ),
                                              Text(
                                                '[${reportInformation['ticket_id']}]',
                                                style: TextStyle(
                                                    color: mainColor,
                                                    height: 1.5),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Wrap(
                                            children: [
                                              Text(
                                                'تاريخ البلاغ: ',
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 15.sp),
                                              ),
                                              Text(
                                                '${intl.DateFormat.yMEd()
                                                    .add_jms()
                                                    .format(
                                                    reportInformation['ticket_date'])}',
                                                style: TextStyle(
                                                    color: mainColor,
                                                    height: 1.5),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Wrap(
                                        children: [
                                          Text(
                                            'الوصف : ',
                                            style: TextStyle(
                                                color: mainColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp),
                                          ),
                                          Text(
                                            '${reportInformation['ticket_description']}',
                                            style: TextStyle(
                                                color: mainColor,
                                                height: 1.5),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Wrap(
                                        children: [
                                          Text(
                                            'رقم القاعة: ',
                                            style: TextStyle(
                                                color: mainColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp),
                                          ),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 6.r,
                                                backgroundColor: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                '${reportInformation['room_number']}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Wrap(
                                        children: [
                                          Text(
                                            'نوع القاعة: ',
                                            style: TextStyle(
                                                color: mainColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp),
                                          ),
                                          Text(
                                            '${reportInformation['room_type']}',
                                            style: TextStyle(
                                                color: mainColor,
                                                height: 1.5),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Wrap(
                                        children: [
                                          Text(
                                            'المبنى : ',
                                            style: TextStyle(
                                                color: mainColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp),
                                          ),
                                          Text(
                                            '${reportInformation['ticket_building']}',
                                            style: TextStyle(
                                                color: mainColor,
                                                height: 1.5),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'وصف المشكلة : ',
                                        style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      ),
                                      Container(
                                        alignment:
                                        AlignmentDirectional.center,
                                        padding: EdgeInsets.all(12.r),
                                        decoration: BoxDecoration(
                                            color: Color(0xffF3F3F3),
                                            borderRadius:
                                            BorderRadius.circular(15.r)),
                                        child: Text(
                                          '${ticketInformation['ticket_problem_description']}',
                                          style: TextStyle(
                                              color: mainColor, height: 1.5),
                                        ),
                                      ),
                                      SizedBox(height: 10.h,),
                                      Row(
                                        children: [
                                          Text(
                                            'الفنيين : ',
                                            style: TextStyle(
                                                color: mainColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp),
                                          ),
                                          Row(
                                            children: c.map((e) => Text('$e ,',style: TextStyle(
                                                color: mainColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500
                                            ),)).toList(),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                        child: Divider(
                                          thickness: 1,
                                          color: mainColor.withOpacity(.5),
                                        ),
                                      ),
                                      Text('تتبع التذكرة',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 17.sp
                                        ),),
                                      Text('وصف الحركة : ',style: TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.bold
                                      ),),
                                      Container(
                                        alignment:
                                        AlignmentDirectional.center,
                                        padding: EdgeInsets.all(12.r),
                                        decoration: BoxDecoration(
                                            color: Color(0xffF3F3F3),
                                            borderRadius:
                                            BorderRadius.circular(15.r)),
                                        child: Text(
                                          'تم   استبدال كيبل ال اتش دي التالف بأخر جديد',
                                          style: TextStyle(
                                              color: mainColor, height: 1.5),
                                        ),
                                      ),
                                      SizedBox(height: 10.h,),
                                      Row(
                                        children: [
                                          Text('الحركة : ',style: TextStyle(
                                              color: mainColor,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          Text('صيانة',style: TextStyle(
                                            color: mainColor,
                                          ),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('التاريخ : ',style: TextStyle(
                                              color: mainColor,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          Text('${
                                              intl.DateFormat.yMEd()
                                                  .add_jms()
                                                  .format(
                                                  reportInformation['ticket_date'])
                                          }',style: TextStyle(
                                            color: mainColor,
                                          ),),
                                        ],
                                      ),
                                      Text('وصف الحركة : ',style: TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.bold
                                      ),),
                                      Container(
                                        alignment:
                                        AlignmentDirectional.center,
                                        padding: EdgeInsets.all(12.r),
                                        decoration: BoxDecoration(
                                            color: Color(0xffF3F3F3),
                                            borderRadius:
                                            BorderRadius.circular(15.r)),
                                        child: Text(
                                          'تم   استبدال كيبل ال اتش دي التالف بأخر جديد',
                                          style: TextStyle(
                                              color: mainColor, height: 1.5),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text('الحركة : ',style: TextStyle(
                                              color: mainColor,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          Text('تم الإنجاز',style: TextStyle(
                                            color: mainColor,
                                          ),),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('التاريخ : ',style: TextStyle(
                                              color: mainColor,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          Text('${
                                              intl.DateFormat.yMEd()
                                                  .add_jms()
                                                  .format(
                                                  reportInformation['ticket_date'])
                                          }',style: TextStyle(
                                            color: mainColor,
                                          ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
