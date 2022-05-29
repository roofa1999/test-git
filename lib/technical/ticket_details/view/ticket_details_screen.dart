import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:roofa/technical/home_screen/view/home_screen.dart';
import 'package:roofa/technical/reports/view/reports_screen.dart';
import '../../../Firebase/controller.dart';
import '../../../Firebase/firebase.dart';
import '../../../Firebase/reports.dart';
import '../../../const/const_color.dart';
import '../../../const/picker.dart';
import '../../../const/text_app.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/material_text.dart';
import '/technical/ticket_details/controller/ticket_details_controller.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsTicketTScreen extends StatefulWidget {
  var map;
  DetailsTicketTScreen({Key? key, this.map}) : super(key: key);

  @override
  State<DetailsTicketTScreen> createState() => _DetailsTicketTScreenState();
}

class _DetailsTicketTScreenState extends State<DetailsTicketTScreen> {
  final controller = Get.put(TicketDetailsTController());

  String? actionSend;

  Future<void> sendReply() async {
    actionSend=await controller.sendReply();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.map);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("تفاصيل التذكرة"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            IconButton(onPressed: (){
              showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  items: [
                    PopupMenuItem<String>(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          Get.to(()=>ReportsTScreen());
                        },
                        child: Center(
                            child: const Text('حركات التذكرة')
                        ),
                      ), value: '1',
                    ),
                  ]);
            }, icon: Icon(Icons.menu))

          ],
        ),
        body: FutureBuilder(
          future:FirebaseController.getReport(Report.reportNumber),
          builder: (context,snapShot){

            bool isNew=(FirebaseController.report["الجهة"]=="الفنيين"&&
                (FirebaseController.report["الحالة"]=="تحت الإجراء"&&
            FirebaseController.report["tracking"].length==0));
          if(!snapShot.hasData){
          return Center(child: CircularProgressIndicator());
          }else{
            return ListView(
              children: [
                Container(
                    height: Get.width * 1.6,
                    margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
                                  color: isNew?Colors.grey:statusReport[Controllert.colorState("${ FirebaseController.report['الحالة']}")]['name'][1] ,//Colors.grey,
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
                                                BorderRadius.circular(15.r),
                                              ),
                                              child: Column(
                                                children: [
                                                  MaterialText(
                                                    text: 'إضافة رد على التذكرة',
                                                    color: mainColor,
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  SizedBox(
                                                    height: 25.h,
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Color(0xffF3F3F3),
                                                          borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                              Radius
                                                                  .circular(
                                                                  15.r),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                  15.r)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color:
                                                                colorShadowSearch
                                                                    .withOpacity(
                                                                    .65),
                                                                blurRadius: 10,
                                                                offset:
                                                                Offset(0, 4)),
                                                          ]),
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                              child: Card(
                                                                shadowColor:
                                                                Colors.transparent,
                                                                margin: EdgeInsets.zero,
                                                                elevation: 0.0,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                                  children: [
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                              controller.textReply.clear();
                                                                              setState(() {

                                                                              });
                                                                            },
                                                                        icon: Icon(Icons
                                                                            .delete_forever_outlined)),
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                              Picker.pickerFile();
                                                                            },
                                                                        icon: Icon(Icons
                                                                            .attach_file_outlined)),
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                              Picker.showChoiceDialog(context);
                                                                            },
                                                                        icon: Icon(Icons
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
                                                                EdgeInsets.all(
                                                                    10.r),
                                                                child:
                                                                TextFormField(
                                                                  controller: controller.textReply,
                                                                  maxLines: 3,
                                                                  textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                                  decoration:
                                                                  InputDecoration(
                                                                    border:
                                                                    InputBorder
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
                                                  SizedBox(
                                                    height: 15.h,
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
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
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        width: 206.w,
                                                        height: 60.h,
                                                        decoration: BoxDecoration(
                                                            color: mainColor,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                50.r)),
                                                        child: MaterialText(
                                                          text: ' ارسال',
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 15.sp,
                                                          color: Colors.white,
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
                                              border: Border.all(color: mainColor)),
                                          child: Text(
                                            'إضافة رد',
                                            style: TextStyle(fontSize: 10.sp),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'بيانات التذكرة',
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
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.sp),
                                              ),
                                              Text(
                                                  FirebaseController.report["رقم البلاغ"],
                                                //'${widget.map['report_number']}',
                                                style: TextStyle(
                                                    color: mainColor, height: 1.5),
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
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.sp),
                                              ),
                                              Text(
                                                FirebaseController.formatTimestamp(FirebaseController.report["Time"]),
                                                //'${intl.DateFormat.yMEd().add_jms().format(widget.map['report_date_time'])}',
                                                style: TextStyle(
                                                    color: mainColor, height: 1.5),
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
                                           // '${widget.map['report_target']}',
                                            style: TextStyle(
                                                color: mainColor, height: 1.5),
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
                                            'المقر : ',
                                            style: TextStyle(
                                                color: mainColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp),
                                          ),
                                          Text(
                                            FirebaseController.report["المقر"],
                                            //'${widget.map['report_position']}',
                                            style: TextStyle(
                                                color: mainColor, height: 1.5),
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
                                                radius: 5.r,
                                                backgroundColor:isNew?Colors.grey:statusReport[Controllert.colorState("${ FirebaseController.report['الحالة']}")]['name'][1] ,
                                                //Colors.grey,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                isNew?"جديدة":FirebaseController.report["الحالة"],
                                                //'${widget.map['report_status']}',
                                                style: TextStyle(
                                                  color:isNew?Colors.grey:statusReport[Controllert.colorState("${ FirebaseController.report['الحالة']}")]['name'][1] ,
                                                  //Colors.grey,
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
                                            'رقم القاعة : ',
                                            style: TextStyle(
                                                color: mainColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp),
                                          ),
                                          Text(
                                            FirebaseController.report["رقم الغرفة"],
                                           // '${widget.map['ticket_room_number']}',
                                            style: TextStyle(
                                                color: mainColor, height: 1.5),
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
                                            //'${widget.map['ticket_building']}',
                                            style: TextStyle(
                                                color: mainColor, height: 1.5),
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
                                            //'${widget.map['ticket_floor']}',
                                            style: TextStyle(
                                                color: mainColor, height: 1.5),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'وصف المشكلة : ',
                                        style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      ),
                                      Container(
                                        alignment: AlignmentDirectional.center,
                                        padding: EdgeInsets.all(12.r),
                                        decoration: BoxDecoration(
                                            color: Color(0xffF3F3F3),
                                            borderRadius:
                                            BorderRadius.circular(15.r)),
                                        child: Text(
                                          FirebaseController.report["الوصف"],
                                          //'${widget.map['ticket_problem_description']}',
                                          style: TextStyle(
                                              color: mainColor, height: 1.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Wrap(
                                        children: [
                                          Text(
                                            'الفني المسؤول : ',
                                            style: TextStyle(
                                                color: mainColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp),
                                          ),
                                          Text(
                                            '${widget.map['technical_name']}',
                                            style: TextStyle(
                                                color: mainColor, height: 1.5),
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
                                            'الفنيين المساعدين : ',
                                            style: TextStyle(
                                                color: mainColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp),
                                          ),
                                          Text(
                                            '${widget.map['helper_technical_name']}',
                                            style: TextStyle(
                                                color: mainColor, height: 1.5),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'الوقت والتاريخ المتوقع لإنجاز المهمة',
                                        style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'من',
                                        style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      ),
                                      SizedBox(
                                        width: 5.sp,
                                      ),
                                      Text(
                                        '${intl.DateFormat.yMd().format(widget.map['report_done_from'])}',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.sp,
                                      ),
                                      Text(
                                        'إلى',
                                        style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      ),
                                      SizedBox(
                                        width: 5.sp,
                                      ),
                                      Text(
                                        '${intl.DateFormat.yMd().format(widget.map['report_done_to'])}',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.sp,
                                      ),
                                      Text(
                                        'الساعة',
                                        style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      ),
                                      SizedBox(
                                        width: 5.sp,
                                      ),
                                      Text(
                                        '${intl.DateFormat().add_jm().format(DateTime.now())}',
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ],
                    )),
                ...List.generate(FirebaseController.
                report["reply"].length, (index)  {
                  return Dismissible(
                    key: Key(FirebaseController.
                    report["reply"][index]),
                    onDismissed: (val){
                      print(index);
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
                                    "${FirebaseController.report["reply"][index]["الوصف"]}",
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
                                        'وحدةً'+'${
                                            FirebaseController.
                                            report["reply"]
                                            [index]
                                            ["الوحدة"]
                                        }',
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
      ),
    );
  }
}
