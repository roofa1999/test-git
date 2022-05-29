import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:roofa/Customer/supervise_reports/view/superviser_report_screen.dart';
import 'package:roofa/Firebase/reports.dart';
import 'package:roofa/const/const_color.dart';
import 'package:roofa/const_pdf.dart';
import 'package:roofa/customer/home_page/view/home_screen.dart';
import 'package:roofa/widgets/custom_dialog.dart';
import 'package:roofa/widgets/material_text.dart';
import 'package:roofa/const/text_app.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Firebase/controller.dart';
import '../../../Firebase/firebase.dart';
import '../../../const/picker.dart';
import '../../../technical/report_screen/view/report_screen.dart';
import '../../../widgets/super_viser.dart';
import '../controller/detalis_ticket_controller.dart';

class DetailsTicketScreen extends StatefulWidget {
  Color? color;

  DetailsTicketScreen({this.color});

  @override
  State<DetailsTicketScreen> createState() => _DetailsTicketScreenState();
}

class _DetailsTicketScreenState extends State<DetailsTicketScreen> {
  final controller = Get.put(DetailsTicketController());


  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text("تفاصيل التذكرة"),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: (){
                Get.offNamed('/superviser_report_screen');
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.off(()=>HomeScreen());
                  },
                  icon: Icon(
                    Icons.home,
                    size: 30.r,
                  ))
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
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
                                        'تفاصيل التذكرة',
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
                      controller.index.value==1?
                      Expanded(
                          child: IconButton(
                            icon: Icon(Icons.print,color: colorShadowSearch,),
                            onPressed: ()async{
                              await launch(getArchivmentFile);
                            },
                          )):SizedBox(),

                    ],
                  )
              ),
              Expanded(
                child: PageView(
                  controller: controller.controllerPageView,
                  onPageChanged: (val){
                    controller.index.value = val;
                  },
                  children: [
                    DetailsTicketPage(controller: controller, color: widget.color),
                    ReportsLogPage(color: widget.color),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class DetailsTicketPage extends StatefulWidget {
  const DetailsTicketPage({
    Key? key,
    required this.controller,
    required this.color,
  }) : super(key: key);

  final DetailsTicketController controller;
  final Color? color;


  @override
  State<DetailsTicketPage> createState() => _DetailsTicketPageState();
}

class _DetailsTicketPageState extends State<DetailsTicketPage> {
  String? actionSend;
  Future<void> sendReply() async {
    actionSend=await widget.controller.sendReply();
  }
  int c = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:FutureBuilder(
          future:FirebaseController.getReport(Report.reportNumber),
          builder: (context,snapShot){
            if(!snapShot.hasData){
              return Center(child: CircularProgressIndicator());
            }else{
              return Column(
                children: [
                  Container(
                    height: (FirebaseController.report["الحالة"]=="مرفوضة")?Get.width * 1.4:Get.width * 1.3,//Get.height * 0.63,
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
                                      color: widget.color??Colors.black,
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
                                    child: FutureBuilder(
                                        future:FirebaseController.getReport(Report.reportNumber),
                                        builder: (context,snapShot){
                                          if(!snapShot.hasData){
                                            return Center(child: CircularProgressIndicator());
                                          }else{
                                            return Column(
                                              children: [
                                                FirebaseController.report['الحالة']!="مرفوضة"?
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
                                                                                        widget.controller.replayText.clear();
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
                                                                                controller: widget.controller.replayText,
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
                                                              //'${ticketInformation['ticket_id']}',
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
                                                              /* '${intl.DateFormat.yMEd()
                                                      .add_jms()
                                                      .format(
                                                      ticketInformation['ticket_date'])}',*/
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
                                                          //"${FirebaseController.report["القسم"]}",
                                                          '${ticketInformation['ticket_target']}',
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
                                                          'الحالة: ',
                                                          style: TextStyle(
                                                              color: mainColor,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15.sp),
                                                        ),
                                                        Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 6.r,
                                                              backgroundColor: widget.color,
                                                            ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Text(
                                                              '${FirebaseController.report['الحالة']}',
                                                              style: TextStyle(
                                                                color: widget.color,
                                                                /*'${ticketInformation['ticket_status']}',
                                                  style: TextStyle(
                                                    color: color,*/
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
                                                          'حالة الأهمية : ',
                                                          style: TextStyle(
                                                              color: mainColor,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15.sp),
                                                        ),
                                                        Text(
                                                          '${FirebaseController.report["مدى الضرر"]}',
                                                          //'${ticketInformation['ticket_priority']}',
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
                                                          "${FirebaseController.report["المبنى"]}",
                                                          //'${ticketInformation['ticket_building']}',
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
                                                          'الطابق : ',
                                                          style: TextStyle(
                                                              color: mainColor,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15.sp),
                                                        ),
                                                        Text(
                                                          "${FirebaseController.report["الطابق"]}",
                                                          //'${ticketInformation['ticket_floor']}',
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
                                                          'نوع الغرفة : ',
                                                          style: TextStyle(
                                                              color: mainColor,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15.sp),
                                                        ),
                                                        Text(
                                                          "${FirebaseController.report["نوع الغرفة"]}",
                                                          // '${ticketInformation['ticket_room_type']}',
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
                                                          'رقم  الغرفة : ',
                                                          style: TextStyle(
                                                              color: mainColor,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15.sp),
                                                        ),
                                                        Text(
                                                          "${FirebaseController.report["رقم الغرفة"]}",
                                                          //'${ticketInformation['ticket_room_number']}',
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
                                                    /*
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
                                                          //"${FirebaseController.report["phone"]}",
                                                          '${ticketInformation['ticket_phone_number']}',
                                                          style: TextStyle(
                                                              color: mainColor,
                                                              height: 1.5),
                                                        ),
                                                      ],
                                                    ),
                                                    */
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
                                                        "${FirebaseController.report["الوصف"]}",
                                                        // '${ticketInformation['ticket_problem_description']}',
                                                        style: TextStyle(
                                                            color: mainColor, height: 1.5),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                (FirebaseController.report["الحالة"]=="مرفوضة")?
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                                  children: [
                                                    Text(
                                                      'سبب الرفض : ',
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
                                                        "${FirebaseController.cuaseRefusal}",
                                                        // '${ticketInformation['ticket_problem_description']}',
                                                        style: TextStyle(
                                                            color: mainColor, height: 1.5),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                                :SizedBox(),
                                              ],
                                            );
                                          }})
                                )),
                          ],
                        );
                      },
                    ),
                  ),
                  //هنا يجب أنا تشيك إذا كانت مرفوضة بس يطلع له سبب الرفض واذا كانت غير شي يطلع له الردود
                  //ticketInformation['ticket_status']!="مرفوضة"?
                  ...List.generate(FirebaseController.report["reply"].length, (index)  {
                    return Dismissible(
                      secondaryBackground: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0
                        ),
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.delete,
                          size: Get.width * 0.1,
                          color: Colors.white,),
                      ),
                      background: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.0
                        ),
                        alignment:  Alignment.centerRight
                        ,
                        color: Colors.red,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: Get.width * 0.1,
                        ),
                      ),
                      key: Key(UniqueKey().toString()),
                      onDismissed: (direction) async {
                        print(direction);
                        List reply=FirebaseController.report["reply"];
                        reply.removeAt(index);
                       // print(FirebaseController.report.id);
                        await FirebaseFirestore.instance.collection("reports").doc(FirebaseController.report.id)
                        .update({
                          "reply":reply,
                        }).then((value) => Get.snackbar("delete", "done delete reply",backgroundColor: Colors.white,colorText: Colors.red));
                      },
                      child: Container(
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
                                          //' الصيانة ',
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
                                      //'يرجى إنشاء تذكرة طلب صيانة للمستلزمات التعلمية  من ايقونة انشاء بلاغ جدي ',
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
                                          'وحدةً'+'${(FirebaseController.report["reply"][index]["الوحدة"]!=null)?FirebaseController.report["reply"][index]["الوحدة"]:" معرفة"}',
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
                                    //'أحمد بن عفيف',
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
                      ),
                    );
                  }),
                ],
              );
            }}),
    );
  }
}

class ReportsLogPage extends StatelessWidget {
  final Color? color;

  const ReportsLogPage({Key? key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List listTracking=FirebaseController.report["tracking"];
    return  ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: listTracking.length,
      itemBuilder: (context, index) {
        return GetBuilder<DetailsTicketController>(
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

