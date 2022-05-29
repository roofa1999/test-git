import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:roofa/const/picker.dart';
import 'package:roofa/customer_services/home_page/view/home_page.dart';
import 'package:roofa/widgets/custom_dialog.dart';

import '../../../Firebase/controller.dart';
import '../../../Firebase/firebase.dart';
import '../../../Firebase/reports.dart';
import '../../../const/const_color.dart';
import '../../../const/text_app.dart';
import 'package:intl/intl.dart' as intl;

import '../../../widgets/material_text.dart';
import '../controller/detaisl_ticket_controller.dart';

class DetailsTicketCSScreen extends StatefulWidget {
  @override
  State<DetailsTicketCSScreen> createState() => _DetailsTicketCSScreenState();
}

class _DetailsTicketCSScreenState extends State<DetailsTicketCSScreen> {
  final controller = Get.put(DetailsTicketCSController());
  Map? map;
  String? actionSend;
  Future<void> sendReply() async {
    actionSend=await controller.sendReply();
  }
  Future<void> sendRefusal() async {
    actionSend=await controller.sendRefusal();
  }
  Future<void> sendAssignment() async {
    actionSend=await controller.sendAssignment();
  }

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
                  Get.off(()=>HomeScreenCS());
                },
                icon: Icon(
                  Icons.home,
                  size: 30.r,
                ))
          ],
        ),
        body: FutureBuilder(
            future:FirebaseController.getReport(Report.reportNumber),
            builder: (context,snapShot){
            if(!snapShot.hasData){
            return Center(child: CircularProgressIndicator());
            }else{
              return ListView(
                children: [
                  Container(
                    height: Get.height /1.6,
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
                                      color: Colors.grey,
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
                                              flex: 2,
                                              child: SizedBox()),
                                          Text(
                                            'بيانات التذكرة',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: mainColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Expanded(child: SizedBox()),
                                          GestureDetector(
                                            onTap: (){
                                              Get.dialog(Center(
                                                child: Container(
                                                  padding: EdgeInsets.all(15.r),
                                                  width: Get.width,
                                                  height: Get.height / 2.5,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        15.r),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      MaterialText(
                                                        text:
                                                        'إضافة رد على التذكرة',
                                                        color: mainColor,
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                      SizedBox(height: 25.h,),

                                                      Expanded(
                                                        flex: 5,
                                                        child: Container(
                                                          decoration: BoxDecoration(

                                                              color: Color(
                                                                  0xffF3F3F3),
                                                              borderRadius: BorderRadius
                                                                  .only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                      15.r),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                      15.r)),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: colorShadowSearch
                                                                        .withOpacity(
                                                                        .65),
                                                                    blurRadius:
                                                                    10,
                                                                    offset:
                                                                    Offset(0,
                                                                        4)),
                                                              ]),
                                                          child: Column(
                                                            children: [
                                                              Expanded(
                                                                  child: Card(
                                                                    shadowColor: Colors
                                                                        .transparent,
                                                                    margin: EdgeInsets
                                                                        .zero,
                                                                    elevation: 0.0,
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                      children: [
                                                                        IconButton(
                                                                            onPressed:
                                                                                () {},
                                                                            icon: Icon(
                                                                                Icons
                                                                                    .delete_forever_outlined)),
                                                                        IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              Picker.pickerFile();
                                                                                },
                                                                            icon: Icon(
                                                                                Icons
                                                                                    .attach_file_outlined)),
                                                                        IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              Picker.showChoiceDialog(context);
                                                                                },
                                                                            icon: Icon(
                                                                                Icons
                                                                                    .camera_alt_outlined)),
                                                                      ],
                                                                    ),
                                                                  )),
                                                              Expanded(
                                                                flex: 4,
                                                                child: Card(
                                                                  shadowColor: Colors
                                                                      .transparent,
                                                                  elevation: 0.0,
                                                                  color: Colors
                                                                      .transparent,
                                                                  child: Padding(
                                                                    padding:
                                                                    EdgeInsets
                                                                        .all(10
                                                                        .r),
                                                                    child:
                                                                    TextFormField(
                                                                      onChanged: (val){
                                                                        controller.textReply= val;
                                                                      },
                                                                      maxLines: 3,
                                                                      textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                      decoration:
                                                                      InputDecoration(
                                                                        border: InputBorder
                                                                            .none,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 15.h,),
                                                      Expanded(
                                                        child:
                                                        GestureDetector(
                                                          onTap: () {
                                                            actionSend="";
                                                            sendReply();
                                                            Get.back();
                                                            showCustomDialog(
                                                              text: (actionSend!="")?actionSend:'تم إضافة رد على التذكرة',
                                                            );
                                                            Timer(Duration(
                                                                seconds: 1),
                                                                    (){
                                                                  Get.back();
                                                                  setState(() {

                                                                  });
                                                                });
                                                          },
                                                          child:
                                                          Container(
                                                            alignment:
                                                            Alignment
                                                                .center,
                                                            width: 206.w,
                                                            height: 60.h,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                mainColor,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    50.r)),
                                                            child:
                                                            MaterialText(
                                                              text:
                                                              'ارسال',
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize:
                                                              15.sp,
                                                              color: Colors
                                                                  .white,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: Get.width/4.5,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(50.r),
                                                  border: Border.all(
                                                      color: mainColor
                                                  )
                                              ),
                                              child: Text('إضافة رد',style: TextStyle(
                                                  color: mainColor
                                              ),),
                                            ),
                                          ),
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
                                                      "${FirebaseController.report["رقم البلاغ"]}",
                                                    //'${ticketInformationDM['ticket_id']}',
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
                                                //'${ticketInformation['ticket_target']}',
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
                                                    //'${ticketInformationDM['ticket_position']}',
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
                                                //'${ticketInformationDM['ticket_room_number']}',
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
                                                //'${ticketInformationDM['ticket_building']}',
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
                                                //'${ticketInformationDM['ticket_floor']}',
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
                                            backgroundColor: Colors.grey,
                                          ),
                                          SizedBox(width: 10.w,),
                                          Text(
                                              FirebaseController.report["الحالة"],
                                            //'${ticketInformationDM['ticket_status']}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                height: 1.5),
                                          ),
                                        ],
                                      ),
                                    /*  Row(
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
                                                  FirebaseController.report["phone"],
                                                //'${ticketInformationDM['ticket_phone_number']}',
                                                style: TextStyle(
                                                    color: mainColor,
                                                    height: 1.5),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),*/
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
                                                FirebaseController.report["الوصف"],
                                              //'${ticketInformationDM['ticket_problem_description']}',
                                              style: TextStyle(
                                                  color: mainColor, height: 1.5),
                                            ),
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
                  (FirebaseController.report["الحالة"]!="مرفوضة")?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Get.dialog(Center(
                              child: Container(
                                padding: EdgeInsets.all(15.r),
                                width: Get.width,
                                height: Get.height / 1.5,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(
                                      15.r),
                                ),
                                child: Column(
                                  children: [
                                    MaterialText(
                                      text:
                                      'سبب رفض التذكرة',
                                      color: mainColor,
                                      fontSize: 20.sp,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                    SizedBox(height: 25.h,),

                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(
                                                0xffF3F3F3),
                                            borderRadius: BorderRadius
                                                .only(
                                                bottomRight: Radius
                                                    .circular(
                                                    15.r),
                                                bottomLeft: Radius
                                                    .circular(
                                                    15.r)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: colorShadowSearch
                                                      .withOpacity(
                                                      .65),
                                                  blurRadius:
                                                  10,
                                                  offset:
                                                  Offset(0,
                                                      4)),
                                            ]),
                                        child: Column(
                                          children: [
                                            Expanded(
                                                child: Card(
                                                  shadowColor: Colors
                                                      .transparent,
                                                  margin: EdgeInsets
                                                      .zero,
                                                  elevation: 0.0,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                    children: [
                                                      IconButton(
                                                          onPressed:
                                                              () {
                                                              },
                                                          icon: Icon(
                                                              Icons
                                                                  .delete_forever_outlined)),
                                                      IconButton(
                                                          onPressed:
                                                              () {
                                                            Picker.pickerFile();
                                                              },
                                                          icon: Icon(
                                                              Icons
                                                                  .attach_file_outlined)),
                                                      IconButton(
                                                          onPressed:
                                                              () {
                                                            Picker.showChoiceDialog(context);
                                                              },
                                                          icon: Icon(
                                                              Icons
                                                                  .camera_alt_outlined)),
                                                    ],
                                                  ),
                                                )),
                                            Expanded(
                                              flex: 4,
                                              child: Card(
                                                shadowColor: Colors
                                                    .transparent,
                                                elevation: 0.0,
                                                color: Colors
                                                    .transparent,
                                                child: Padding(
                                                  padding:
                                                  EdgeInsets
                                                      .all(10
                                                      .r),
                                                  child:
                                                  TextFormField(
                                                    onChanged: (val){
                                                      controller.causeReply=val;

                                                    },
                                                    textDirection:
                                                    TextDirection
                                                        .rtl,
                                                    decoration:
                                                    InputDecoration(
                                                      border: InputBorder
                                                          .none,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15.h,),
                                    Expanded(
                                      child:
                                      GestureDetector(
                                        onTap: () {
                                          actionSend="";
                                          sendRefusal();
                                          Get.back();
                                          showCustomDialog(
                                            text: (actionSend!="")?actionSend:'تم ارسال سبب رفض التذكرة',
                                          );
                                          Timer(Duration(
                                              seconds: 1),
                                                  (){
                                                Get.back();
                                                setState(() {

                                                });
                                              });
                                        },
                                        child:
                                        Container(
                                          alignment:
                                          Alignment
                                              .center,
                                          width: 206.w,
                                          height: 60.h,
                                          decoration: BoxDecoration(
                                              color:
                                              mainColor,
                                              borderRadius:
                                              BorderRadius
                                                  .circular(
                                                  50.r)),
                                          child:
                                          MaterialText(
                                            text:
                                            'ارسال',
                                            fontWeight:
                                            FontWeight
                                                .bold,
                                            fontSize:
                                            15.sp,
                                            color: Colors
                                                .white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8.r),
                            margin: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Text('رفض التذكرة',style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp
                            ),),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            actionSend="";
                            sendAssignment();
                            showCustomDialog(
                              text: (actionSend!="")?actionSend:'تم تحويل التذكرة لقسم الصيانة',
                            );
                            showCustomDialog(
                                text: 'تم تحويل التذكرة لقسم الصيانة'
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8.r),
                            margin: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Text('تحويل لصيانة',style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp
                            ),),
                          ),
                        ),
                      ),
                    ],
                  )
                  :SizedBox(),
                  Column(
                    children: List.generate(FirebaseController.report["reply"].length, (index) => Container(
                      margin:
                      EdgeInsets.symmetric(vertical: 11.h, horizontal: 11.w),
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color(0xffF3F3F3),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Wrap(
                                    children: [
                                      Text(
                                        '${intl.DateFormat.yMMMMd()
                                            .add_jms()
                                            .format(DateTime.now())}',
                                        style: TextStyle(
                                            fontSize: 9.sp,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        ' | من قسم',
                                        style: TextStyle(
                                            fontSize: 9.sp,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        (FirebaseController.report["reply"][index]["القسم"]!=null)
                                            ?"${FirebaseController.report["reply"][index]["القسم"]}"
                                            :' ',
                                       // ' الصيانة ',
                                        style: TextStyle(
                                            fontSize: 9.sp,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        ' | الحالة',
                                        style: TextStyle(
                                            fontSize: 9.sp,
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        FirebaseController.report["reply"][index]["الحالة"],
                                        //' مغلقة ',
                                        style: TextStyle(
                                            fontSize: 9.sp,
                                            color: statusReport[Controllert.colorState("${FirebaseController.report['الحالة']}")]['name'][1],),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                    'نسعد بتواصلكم معنا عبر التذاكر الالكترونية',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    FirebaseController.report["reply"][index]["الوصف"],
                                   // 'يرجى إنشاء تذكرة طلب صيانة للمستلزمات التعلمية  من ايقونة انشاء بلاغ جديد ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xff28A2CF),
                                        fontSize: 8.sp),
                                  ),
                                  Text(
                                    'نسعى لخدمتكم دوماً',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xff28A2CF),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'وحدةً'+'${FirebaseController.report["reply"][index]["الوحدة"]}',
                                        //'وحدة خدمة الصيانةً',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xff28A2CF),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Expanded(
                            child: Column(
                              children: [
                                SvgPicture.asset('images/user-circle.svg'),
                                Text(
                                  FirebaseController.report["reply"][index]["الاسم"],
                                 // 'أحمد بن عفيف',
                                  style: TextStyle(
                                      color: mainColor,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                  )

                ],
              );
            }}),
      ),
    );
  }
}
