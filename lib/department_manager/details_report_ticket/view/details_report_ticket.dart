import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:roofa/department_manager/details_report_ticket/controller/details_report_ticket_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Firebase/controller.dart';
import '../../../Firebase/firebase.dart';
import '../../../Firebase/reports.dart';
import '../../../const/const_color.dart';
import '../../../const/text_app.dart';
import '../../../const_pdf.dart';
import '../../../technical/report_screen/view/report_screen.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/material_text.dart';
import '../../../widgets/super_viser.dart';
import '../../home_page/view/home_page.dart';
import 'package:intl/intl.dart' as intl;

class DetailsReportTicketDMScreen extends StatelessWidget {
   Color color;
   bool isShow;
   int? index;
   DetailsReportTicketDMScreen({this.index ,this.color = Colors.green,this.isShow = false});
   final controller = Get.put(DetailsReportTicketDMController());
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("تفاصيل التذكرة"),
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
        body: Column(
          children: [
            Obx(
                    ()=>Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.w
                        ),
                        width: 235.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.r),
                            boxShadow: [
                              BoxShadow(
                                  color: colorShadowSearch.withOpacity(.23),
                                  blurRadius: 10,
                                  offset: Offset(0, 4))
                            ]),
                        child:  Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.onClickButton(0);
                                    controller.controllerPageView!
                                        .animateToPage(
                                        0,
                                        duration: Duration(milliseconds: 800),
                                        curve: Curves.decelerate
                                    );
                                  },
                                  child: AnimatedContainer(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: controller.index.value == 0
                                            ? mainColor
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(50.r)),
                                    child: Text(
                                      'بيانات التذكرة',
                                      style: TextStyle(
                                        color: controller.index.value == 0
                                            ? controller.textButtonActive
                                            : mainColor,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 800),
                                  ),
                                )),
                            Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.onClickButton(1);
                                    controller.controllerPageView!
                                        .animateToPage(
                                        1,
                                        duration: Duration(milliseconds: 800),
                                        curve: Curves.decelerate
                                    );

                                  },
                                  child: AnimatedContainer(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: controller.index.value == 1
                                            ? mainColor
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(50.r)),
                                    child: Text(
                                      'تتبع التذكرة',
                                      style: TextStyle(
                                        color: controller.index.value == 1
                                            ? controller.textButtonActive
                                            : mainColor,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 800),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),


                  ],
                )
            ),
            Obx(
                ()=>controller.index.value == 1?GestureDetector( // عند الكبس على هذا الزر يجب تحميل التقارير
            onTap: ()async{
            await launch(getArchivmentFile);
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
            ):SizedBox()
            ),
            Expanded(
              child: PageView(
                controller: controller.controllerPageView,
                onPageChanged: (val){
                  controller.index.value = val;
                },
                children: [
                  DetailsTicketPageDM(
                    controller: controller,
                    color: color,
                    isShow: isShow,
                    index: index,
                  ),
                  CompositionAndChangesDM(

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsTicketPageDM extends StatelessWidget {
    DetailsTicketPageDM({
    Key? key,
    required this.controller,
    required this.color, this.isShow = false, this.index,
  }) : super(key: key);

  final DetailsReportTicketDMController controller;
   final Color? color;
  final bool isShow;
  final int? index;

   List c = ticketInformationDM['reporter_helper'];
var nameTicket = "معاينة";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
    future:FirebaseController.getReport(Report.reportNumber),
    builder: (context,snapShot){
    if(!snapShot.hasData){
    return Center(child: CircularProgressIndicator());
    }else{
      return ListView(
        children: [
          Container(
            width: 10,
            height: Get.height-100.h,
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
            child: LayoutBuilder(
              builder: (context, constrains) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: color,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Text(
                                      "${
                                          (  FirebaseController.report["نوع الحركة"]=="")?'بيانات التذكرة':"التذكرة "+FirebaseController.report["نوع الحركة"]
                                      }",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: mainColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: ()async{
                                            await launch(getTicketFile);
                                          },
                                          child: SvgPicture.asset('images/print.svg'),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
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
                                            FirebaseController.report["رقم البلاغ"],
                                           // '${ticketCompositionAndChangesInformationDM['ticket_id']}',
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
                                            'تاريخ التذكرة: ',
                                            style: TextStyle(
                                                color: mainColor,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 15.sp),
                                          ),
                                          Text(
                                            FirebaseController.formatTimestamp(FirebaseController.report["Time"]),
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
                                        'الجهة/القسم : ',
                                        style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      ),
                                      Text(
                                        FirebaseController.report["الجهة المستفيدة"],
                                       // '${ticketInformation['ticket_target']}',
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
                                        'المقر: ',
                                        style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            FirebaseController.report["المقر"],
                                           // '${ticketCompositionAndChangesInformationDM['ticket_position']}',
                                            style: TextStyle(
                                              color: mainColor,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    children: [
                                      Text(
                                        'رقم القاعة : ',
                                        style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      ),
                                      Text(
                                        FirebaseController.report["رقم الغرفة"],
                                       // '${ticketCompositionAndChangesInformationDM['ticket_room_number']}',
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
                                        FirebaseController.report["المبنى"],
                                       // '${ticketCompositionAndChangesInformationDM['ticket_building']}',
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
                                        'الدور : ',
                                        style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      ),
                                      Text(
                                        FirebaseController.report["الطابق"],
                                        //'${ticketCompositionAndChangesInformationDM['ticket_floor']}',
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
                                  Text(
                                    'الحالة : ',
                                    style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp),
                                  ),
                                  CircleAvatar(
                                    radius: 5.r,
                                    backgroundColor: color,
                                  ),
                                  SizedBox(width: 10.w,),
                                  Text(
                                    FirebaseController.report["الحالة"],
                                   // '${ticketCompositionAndChangesInformationDM['ticket_status']}',
                                    style: TextStyle(
                                        color: color,
                                        height: 1.5),
                                  ),
                                ],
                              ),
                              (nameTicket=="تركيبات وتبديلات"
                                  ||
                                  nameTicket=="إزالة وفك"
                              )
                                  ?Row(
                                children: [
                                  Wrap(
                                    children: [
                                      Text(
                                        'رقم الجوال : ',
                                        style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      ),
                                      Text(
                                        '${ticketCompositionAndChangesInformationDM['ticket_phone_number']}',
                                        style: TextStyle(
                                            color: mainColor,
                                            height: 1.5),
                                      ),
                                    ],
                                  ),
                                ],
                              ):SizedBox(),
                              (nameTicket=="تركيبات وتبديلات"
                                  ||
                                  nameTicket=="إزالة وفك"
                              ) ?Row(
                                children: [
                                  Wrap(
                                    children: [
                                      Text(
                                        'اسم الجهاز : ',
                                        style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      ),
                                      Text(
                                        '${ticketCompositionAndChangesInformationDM['device_name']}',
                                        style: TextStyle(
                                            color: mainColor,
                                            height: 1.5),
                                      ),
                                    ],
                                  ),
                                ],
                              ):SizedBox(),
                              (nameTicket=="تركيبات وتبديلات"
                                  ||
                                  nameTicket=="إزالة وفك"
                              )  ? Row(
                                children: [
                                  Wrap(
                                    children: [
                                      Text(
                                        'نوع الجهاز : ',
                                        style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      ),
                                      Text(
                                        '${ticketCompositionAndChangesInformationDM['device_type']}',
                                        style: TextStyle(
                                            color: mainColor,
                                            height: 1.5),
                                      ),
                                    ],
                                  ),
                                ],
                              ):SizedBox(),
                              (nameTicket=="تركيبات وتبديلات"
                                  ||
                                  nameTicket=="إزالة وفك"
                              )  ?Row(
                                children: [
                                  Wrap(
                                    children: [
                                      Text(
                                        'الرقم التسلسلي للجهاز : ',
                                        style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      ),
                                      Text(
                                        '${ticketCompositionAndChangesInformationDM['device_serial_number']}',
                                        style: TextStyle(
                                            color: mainColor,
                                            height: 1.5),
                                      ),
                                    ],
                                  ),
                                ],
                              ):SizedBox(),
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
                                      FirebaseController.report["الوصف"],//  '${ticketCompositionAndChangesInformationDM['ticket_problem_description']}',
                                      style: TextStyle(
                                          color: mainColor, height: 1.5),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              (FirebaseController.report["الجهة"]=="الفنيين")?
                              Row(
                                children: [
                                  Text(
                                    'الفني المسؤول : ',
                                    style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp),
                                  ),
                                  Text(
                                    '${
                                        ticketCompositionAndChangesInformationDM['reporter_name']
                                    }',
                                    style: TextStyle(
                                      color: mainColor,
                                    ),
                                  ),

                                ],
                              ):SizedBox(),
                              (FirebaseController.report["الجهة"]=="الفنيين")?
                              Row(
                                children: [
                                  Text(
                                    'الفنيين المساعدين : ',
                                    style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp),
                                  ),
                                  Row(
                                    children: c.map((e) => Text('$e,',style: TextStyle(
                                        color: mainColor
                                    ),)).toList(),
                                  )

                                ],
                              ):SizedBox(),
                              (FirebaseController.report["الجهة"]=="الفنيين")?
                              Row(
                                children: [
                                  Text('التاريخ والوقت المتوقع لإنجاز المهمة',style: TextStyle(
                                      color: mainColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp
                                  ),),
                                ],
                              ):SizedBox(),
                              (FirebaseController.report["الجهة"]=="الفنيين")?
                              Row(
                                children: [
                                  Text(
                                    '${intl.DateFormat.yMd().format(
                                        ticketCompositionAndChangesInformationDM['ticket_date_finish_from'])}',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp
                                    ),),
                                  Text('  إلى  ',style: TextStyle(
                                      color: mainColor,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  Text(
                                    '${intl.DateFormat.yMd().add_j().format(
                                        ticketCompositionAndChangesInformationDM['ticket_date_finish_to'])}',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp
                                    ),),
                                ],
                              ):SizedBox(),
                            ],
                          ),
                        )),
                  ],
                );
              },
            ),
          ),
        ],
      );
    }});
    }
  }


class CompositionAndChangesDM extends StatelessWidget {
  final Color? color;
  const CompositionAndChangesDM({Key? key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List listTracking=FirebaseController.report["tracking"];
    return  ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: listTracking.length,
      itemBuilder: (context, index) {
        return GetBuilder<DetailsReportTicketDMController>(
          builder: (_) {
            return buildContainer(
                height: Get.width * 0.9,
                color: statusReport[Controllert.colorState("${listTracking[index]['الحالة']}")]['name'][1],
                child: (listTracking[index]["الحالة"]=="تحت الإجراء")?
                Column(
                  children: [
                    buildInfoTicket(label: 'رقم  التذكرة',
                        value: listTracking[index]["رقم التذكرة"]),
                    buildInfoTicket(label: 'التاريخ',
                        value: FirebaseController.formatTimestamp(listTracking[index]["Time"]/*intl.DateFormat.yMEd().add_jm().format(c[2]['report_date_time']*/)),
                    buildInfoTicket(label: 'نوع الحركة',
                        value: listTracking[index]["نوع الحركة"]),
                    buildInfoTicket(label: 'اسم الجهاز',
                        value: listTracking[index]["اسم الجهاز"]),
                    buildInfoTicket(label: 'نوع الجهاز',
                        value: listTracking[index]["نوع الجهاز"]),
                    buildInfoTicket(label: 'الوصف',
                        value: ''),
                    Expanded(
                        flex: 2,
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: Color(0xffF3F3F3),
                                borderRadius: BorderRadius.
                                circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: colorShadowSearch.
                                      withOpacity(.16),
                                      offset: Offset(0,9),
                                      blurRadius: 10
                                  )
                                ]
                            ),
                            child: Text(listTracking[index]["الوصف"],style: TextStyle(
                                color: mainColor
                            ),)
                        )),
                    buildInfoTicket(label: 'مدخل التقرير',
                        value: listTracking[index]["مدخل التقرير"]),
                  ],
                ):
                Column(
                  children: [
                    buildInfoTicket(label: 'رقم  التذكرة',
                        value: listTracking[index]["رقم التذكرة"]),
                    buildInfoTicket(label: 'التاريخ',
                        value: FirebaseController.formatTimestamp(listTracking[index]["Time"]/*intl.DateFormat.yMEd().add_jm().format(c[2]['report_date_time']*/)),
                    buildInfoTicket(label: 'نوع الحركة',
                        value: listTracking[index]["نوع الحركة"]),
                    buildInfoTicket(label: 'الوصف',
                        value: ''),
                    Expanded(
                        flex: 2,
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: Color(0xffF3F3F3),
                                borderRadius: BorderRadius.
                                circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: colorShadowSearch.
                                      withOpacity(.16),
                                      offset: Offset(0,9),
                                      blurRadius: 10
                                  )
                                ]
                            ),
                            child: Text(listTracking[index]["الوصف"],style: TextStyle(
                                color: mainColor
                            ),)
                        )),
                    buildInfoTicket(label: 'مدخل التقرير',
                        value: listTracking[index]["مدخل التقرير"]),
                  ],
                )
            );
          },
        );
      },
      separatorBuilder: (context, index) => const SizedBox(),
    );
  }
}
