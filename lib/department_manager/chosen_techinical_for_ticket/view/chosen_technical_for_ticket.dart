import 'dart:async';
import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roofa/const/const_color.dart';
import 'package:roofa/main.dart';
import 'package:roofa/widgets/custom_dialog.dart';
import 'package:select_dialog/select_dialog.dart';

import '../../../Firebase/firebase.dart';
import '../../../Firebase/reports.dart';
import '../../../const/picker.dart';
import '../../../const/text_app.dart';
import '../../../widgets/material_text.dart';
import 'package:intl/intl.dart' as intl;

import '../../chosen_technical/controller/chosen_technical_controller.dart';
import '../controller/chosen_technica_for_ticket_controller.dart';

class ChosenTechnicalForTicketDMScreen extends StatefulWidget {
  Map? map;
  ChosenTechnicalForTicketDMScreen({this.map});

  @override
  State<ChosenTechnicalForTicketDMScreen> createState() => _ChosenTechnicalForTicketDMScreenState();
}

class _ChosenTechnicalForTicketDMScreenState extends State<ChosenTechnicalForTicketDMScreen> {
  final controller= Get.put(ChosenTechnicalForTicketDMController());
  String? actionSend;
  Future<void> sendReply() async {
    actionSend=await controller.sendReply();
  }
  Future<void> chooseTechnical() async {
    actionSend=await controller.chooseTechnical();
  }
  Future<void> sendAssignment() async {
    actionSend=await controller.sendAssignment();
  }
  @override
  Widget build(BuildContext context) {
    controller.technicalName.value = widget.map!['technical_name']??'';
    controller.helperTechnical.value = widget.map!['helper_technical_name']??'';
    print(widget.map);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("تعيين الفنيين"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: FutureBuilder(
            future:FirebaseController.getReport(Report.reportNumber),
            builder: (context,snapShot){
              if(!snapShot.hasData){
                return Center(child: CircularProgressIndicator());
              }else{
                return Column(
                  children: [
                    Expanded(child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8.r),
                          width:double.infinity,
                          height: Get.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: [
                                BoxShadow(
                                    color: colorShadowSearch.withOpacity(.23),
                                    offset: Offset(0,4),
                                    blurRadius: 10
                                )
                              ]
                          ),
                          child: Row(
                            children: [
                              Expanded(child: Container(
                                decoration: BoxDecoration(
                                    color:// FirebaseController.report["الحالة"]!="جديدة"
                                       /* ((FirebaseController.report["الحالة"]=="جديدة")&&
                                        (FirebaseController.report["الجهة"])!="الفنيين"&&
                                        (FirebaseController.report["الجهة"])!="خدمة العملاء")*/
                                    FirebaseController.report["الجهة"]=="الفنيين"
                                              ?Color(0xffBFBFBF)
                                            : Colors.orange//Color(0xff30D852).withOpacity(.5)
                                         ,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15.r),
                                      bottomRight: Radius.circular(15.r),
                                    )
                                ),
                              )),
                              Expanded(
                                  flex: 18,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        ticketInformation['ticket_status']!="مرفوضة"?
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
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
                                                                                  () {
                                                                                controller.replayText.clear();
                                                                                setState(() {

                                                                                });
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
                                                                        controller: controller.replayText,
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
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.w),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(50.0),
                                                    border: Border.all(
                                                        color: mainColor)),
                                                child: Text(
                                                  'إضافة رد',
                                                  style: TextStyle(fontSize: 10.sp),
                                                ),
                                              ),
                                            )
                                          ],
                                        ):SizedBox(),
                                        Text(
                                          "${
                                              (  FirebaseController.report["نوع الحركة"]=="")?'بيانات التذكرة':"التذكرة "+FirebaseController.report["نوع الحركة"]
                                          }"
                                          ,
                                          style: TextStyle(
                                              color: mainColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(
                                          thickness: 1.5,
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text('رقم التذكرة : ',style: TextStyle(
                                                  color: mainColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              Text(FirebaseController.report["رقم البلاغ"]
                                                //'${map!['report_number']}'
                                                ,style: TextStyle(
                                                    color: mainColor
                                                ),),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text('تاريخ التذكرة : ',style: TextStyle(
                                                  color: mainColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              Text(FirebaseController.formatTimestamp(FirebaseController.report["Time"])
                                                /*'${
                                                intl.DateFormat
                                                    .yMEd()
                                                    .add_jm()
                                                    .format(
                                                    map!['report_date_time']
                                                )
                                            }'*/,style: TextStyle(
                                                    color: colorShadowSearch
                                                ),),

                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text('الجهة/القسم : ',style: TextStyle(
                                                  color: mainColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              Text(FirebaseController.report["الجهة المستفيدة"]
                                                //'${map!['report_target']}'
                                                ,style: TextStyle(
                                                    color: mainColor
                                                ),),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text('المقر : ',style: TextStyle(
                                                  color: mainColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              Text(FirebaseController.report["المقر"]
                                                //'${map!['report_position']}'
                                                ,style: TextStyle(
                                                    color: mainColor
                                                ),),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text('رقم القاعة : ',style: TextStyle(
                                                  color: mainColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              Text(FirebaseController.report["رقم الغرفة"]
                                                //'${map!['ticket_room_number']}'
                                                ,style: TextStyle(
                                                    color: mainColor
                                                ),),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text('المبنى : ',style: TextStyle(
                                                  color: mainColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              Text(FirebaseController.report["المبنى"]
                                                //'${map!['ticket_building']}'
                                                ,style: TextStyle(
                                                    color: mainColor
                                                ),),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text('الدور : ',style: TextStyle(
                                                  color: mainColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              Text(FirebaseController.report["الطابق"]
                                                //'${map!['ticket_floor']}'
                                                ,style: TextStyle(
                                                    color: mainColor
                                                ),),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text('الحالة : ',style: TextStyle(
                                                  color: mainColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              CircleAvatar(
                                                radius: 5.r,
                                                backgroundColor: FirebaseController.report["الجهة"]=="الفنيين" //map!['report_status']
                                                    ?Color(0xff30D852).withOpacity(.5)
                                                    :Colors.orange//Color(0xffBFBFBF),
                                              ),
                                              SizedBox(width: 5.w,),Text(
                                                (FirebaseController.report["الجهة"]=="الفنيين")?"تم تعيين فني":FirebaseController.report["الحالة"]
                                                //'${map!['ticket_status']}'
                                                ,style: TextStyle(
                                                color: FirebaseController.report["الجهة"]=="الفنيين" //map!['report_status']
                                                    ?Color(0xff30D852)
                                                    :Colors.orange//Color(0xffBFBFBF),
                                              ),),
                                            ],
                                          ),
                                        ),
                                        /*
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text('رقم الجوال : ',style: TextStyle(
                                                  color: mainColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              Text(//FirebaseController.report["phone"]
                                                '+966933343423'
                                                // '${map!['ticket_phone_number']}'
                                                ,style: TextStyle(
                                                  color: mainColor
                                              ),),
                                            ],
                                          ),
                                        ),
                                        */
                                        Row(
                                          children: [
                                            Text('الوصف : ',style: TextStyle(
                                                color: mainColor,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          ],
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(5.r),
                                              decoration: BoxDecoration(
                                                  color: colorShadowSearch.withOpacity(.2),
                                                  borderRadius: BorderRadius.circular(15.r)
                                              ),
                                              child: Text(FirebaseController.report["الوصف"]
                                                //'${map!['ticket_problem_description']}'
                                                ,style: TextStyle(
                                                    color: mainColor,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                            ))

                                      ],
                                    ),
                                  ))

                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: colorShadowSearch.withOpacity(.23),
                                    blurRadius: 10
                                )
                              ]
                          ),
                          child: Obx(
                                  ()=>ExpansionTile(
                                collapsedIconColor: mainColor,
                                title: Text(
                                  controller.helperTechnical.value
                                      .trim().isEmpty
                                      ? widget.map!['technical_name']??'اختيار الفني المسؤول'
                                      :controller.helperTechnical.value
                                  ,style: TextStyle(
                                    color: mainColor
                                ),),
                                children: [
                                  TextFormField(
                                    initialValue: widget.map!['technical_name'],
                                    decoration: InputDecoration(
                                      hintText: 'اكتب الاسم هنا',
                                    ),
                                    onChanged: (val){
                                      controller.helperTechnical.value = val;
                                    },
                                  )
                                ],
                              )
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: colorShadowSearch.withOpacity(.23),
                                    offset: Offset(0,4),
                                    blurRadius: 10
                                )
                              ]
                          ),
                          child: Obx(
                                  ()=>ExpansionTile(
                                collapsedIconColor: mainColor,
                                title: Text(
                                  controller.technicalName.value
                                      .trim().isEmpty
                                      ?widget.map!['helper_technical_name']?? 'اختيار الفني المساعد'
                                      :controller.technicalName.value
                                  ,style: TextStyle(
                                    color: mainColor
                                ),),
                                children: [
                                  TextFormField(
                                    initialValue: widget.map!['helper_technical_name'],
                                    decoration: InputDecoration(
                                      hintText: 'اكتب الاسم هنا',
                                    ),
                                    onChanged: (val){
                                      controller.technicalName.value = val;
                                    },
                                  )
                                ],
                              )
                          ),
                        ),
                        SizedBox(height: 8.h,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('ادخل التاريخ :',style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp
                              ),)
                            ],
                          ),
                        ),
                        SizedBox(height: 8.h,),
                        Obx(
                                ()=>Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Text('من:',style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp
                                  ),),
                                  SizedBox(width: 15.w,),
                                  Expanded(
                                    flex:2,
                                    child: GestureDetector(
                                      onTap: ()async{
                                        final DateTime? date = await showDatePicker(
                                            context: context,
                                            initialDate: controller.expectedTime1.value,
                                            firstDate: DateTime(1990),
                                            lastDate: DateTime(2030));
                                        if (date != null && date != controller.expectedTime1.value){
                                          controller.expectedTime1.value = date;
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(12.r),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(8.r),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black.withOpacity(.23),
                                                  offset: Offset(0,4),
                                                  blurRadius: 10
                                              )
                                            ]
                                        ),
                                        child: Text('${
                                            intl.DateFormat.yMd().format(
                                                controller.expectedTime1.value
                                            )
                                        }',style: TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15.w,),
                                  Text('إلى:',style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp
                                  ),),
                                  SizedBox(width: 15.w,),
                                  Expanded(
                                    flex:2,
                                    child: GestureDetector(
                                      onTap: ()async{
                                        final DateTime? date = await showDatePicker(
                                            context: context,
                                            initialDate: controller.expectedTime2.value,
                                            firstDate: DateTime(1990),
                                            lastDate: DateTime(2030));
                                        if (date != null && date != controller.expectedTime2.value){
                                          controller.expectedTime2.value = date;
                                        }
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(12.r),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(8.r),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black.withOpacity(.23),
                                                  offset: Offset(0,4),
                                                  blurRadius: 10
                                              )
                                            ]
                                        ),
                                        child: Text('${
                                            intl.DateFormat.yMd().format(
                                                controller.expectedTime2.value
                                            )
                                        }',style: TextStyle(
                                          color: mainColor,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15.w,),
                                ],
                              ),
                            )
                        ),
                        SizedBox(height: 15.h,),
                        Row(
                          children: [
                            Text('اختيار الفترة لإنجاز المهمة:',style: TextStyle(
                                color: mainColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(
                                          color: mainColor,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black.withOpacity(.23),
                                              offset: Offset(0,4),
                                              blurRadius: 10
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8.r)
                                    ),
                                    child: Obx(()=>Row(
                                      children: [
                                        Expanded(child: GestureDetector(
                                          onTap: (){
                                            controller.changeDayTime(0);
                                          },
                                          child: AnimatedContainer(
                                            padding: EdgeInsets.all(8.r),
                                            alignment: Alignment.center,
                                            duration: Duration(milliseconds: 500),
                                            decoration: BoxDecoration(
                                                color: controller.dayTime==0
                                                    ?mainColor:Colors.transparent,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(8.r),
                                                  bottomRight: Radius.circular(8.r),
                                                )
                                            ),
                                            child: Text('PM',style: TextStyle(
                                                color: controller.dayTime==0
                                                    ?Colors.white:mainColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp
                                            ),),
                                          ),
                                        )),
                                        Expanded(child: GestureDetector(
                                          onTap: (){
                                            controller.changeDayTime(1);
                                          },
                                          child: AnimatedContainer(
                                            padding: EdgeInsets.all(8.r),
                                            alignment: Alignment.center,
                                            duration: Duration(milliseconds: 500),
                                            decoration: BoxDecoration(
                                                color: controller.dayTime==1
                                                    ?mainColor:Colors.transparent,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8.r),
                                                  bottomLeft: Radius.circular(8.r),
                                                )
                                            ),
                                            child: Text('AM',style: TextStyle(
                                                color: controller.dayTime==1
                                                    ?Colors.white:mainColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp
                                            ),),
                                          ),
                                        )),
                                      ],
                                    ))
                                ),
                              ),
                              Expanded(child: SizedBox()),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h,),
                        Obx(()=>GestureDetector(

                          onTap:
                          (
                              controller.technicalName.trim().isEmpty
                                  ||
                                  controller.helperTechnical.trim().isEmpty
                          )?null:(){
                            actionSend="";
                            chooseTechnical();
                            showCustomDialog(
                              text: (actionSend!="")?actionSend:'تم تعديل البيانات بنجاح',
                            );
                            // print('hello active');
                            Timer(Duration(milliseconds: 500), (){
                              Get.back();
                              sleep(Duration(milliseconds: 100));
                              Get.back();
                              setState(() {

                              });
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(8.r),
                            margin: EdgeInsets.symmetric(
                              horizontal: Get.width/5,
                              vertical: 15.h,
                            ),
                            decoration: BoxDecoration(
                              color:   (
                                  controller.technicalName.trim().isEmpty
                                      ||
                                      controller.helperTechnical.trim().isEmpty
                              )?Colors.grey:mainColor,
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Text('تأكيد',style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp
                            ),),
                          ),
                        ))
                      ],
                    )),


                  ],
                );
              }}),
      ),
    );
  }
}