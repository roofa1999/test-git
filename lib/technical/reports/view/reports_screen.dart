import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roofa/const/picker.dart';
import 'package:roofa/const/text_app.dart';
import 'package:roofa/technical/show_tasks/type_move/remove.dart';

import '../../../Firebase/reports.dart';
import '../../../const/const_color.dart';
import 'package:intl/intl.dart' as intl;

import '../../../widgets/custom_dialog.dart';
import '../../../widgets/material_text.dart';
import '../../show_tasks/type_move/add_changes.dart';
import '../../show_tasks/type_move/show_and_not_finish.dart';
import 'package:roofa/technical/report_screen/controller/report_controller.dart';

import '../controller/reports_controller.dart';



class ReportsTScreen extends StatelessWidget {
  final controller = Get.put(ReportsTController());
Map map = {
  'report_number': '[ VXSQ4938 ] ',
  'report_date': DateTime.now(),
  'report_move_type': 'إحالة لقسم الصيانة',
  'report_status' : 'جديدة',
  'reporter_name' : 'عبدالله الزهراني',


};
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Obx(()=>Text(
            controller.index==0
                ? "حركات التذكرة"
                :map['report_move_type']
          )),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child:  FillReportTScreen(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FillReportTScreen extends StatefulWidget {
  var controller;
  FillReportTScreen({this.controller});


  @override
  State<FillReportTScreen> createState() => _FillReportTScreenState();
}

class _FillReportTScreenState extends State<FillReportTScreen> {
  TextEditingController ticketNum = TextEditingController();
  String? actionSend;

  Future<void> sendAssignment() async {
    actionSend=await widget.controller.sendAssignment();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 12.r,
            right: 12.r,
            top: 12.r,
            bottom: 5.r
          ),
          child: Row(
            children: [
              Text('رقم التذكرة',style: TextStyle(
                color: mainColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold
              ),)
            ],
          ),
        ),
        Container(
          margin:  EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            boxShadow:[
              BoxShadow(
                color: colorShadowSearch.withOpacity(.26),
                offset: Offset(0,4),
                blurRadius: 10.0
              )
            ]
          ),
          child: TextFormField(
            readOnly: true,
            autofocus: true,
            controller: ticketNum,
            decoration: InputDecoration(
              fillColor: Color(0xffF3F3F3),
              filled: true,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: Report.reportNumber,//'[7AEE00CVF]'
            ),
          ),
        ),
        SizedBox(height: 20.h,),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.r,
            vertical: 5
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: colorShadowSearch.withOpacity(.23),
                offset: Offset(0,8),
                blurRadius: 8.0
              )
            ]
          ),
          child: DropdownButtonFormField(
            icon: Icon(Icons.keyboard_arrow_down_sharp),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'اختيار الحركة'
            ),
            items: typeMoveTechnical.map((e) => DropdownMenuItem(
              child: Text('$e'),
              value: e
            )).toList(),
            onChanged: (val){
              widget.controller.typeMove=val;
              if(val == 'لم يتم الإنجاز'||val == 'تم الإنجاز'||val == 'معاينة'){

                ///لازم تبعث الداتا هنا عشان نفس بعض بس يختلف اللون
              }

              if(val == 'إضافة تركيبات وتبديلات'){
                print('Yees');print('tarkeb');
                Get.to(()=>AddChangesTReport());
              }
              if(val == 'ازالة /فك'){
                print('ezala');
                Get.to(()=>RemoveTReport());
              }
            },
          ),
        ),
        SizedBox(height: 20.h,),
        Padding(
          padding: EdgeInsets.only(
              left: 12.r,
              right: 12.r,
              top: 12.r,
              bottom: 5.r
          ),
          child: Row(
            children: [
              Text('تاريخ التذكرة',style: TextStyle(
                  color: mainColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold
              ),)
            ],
          ),
        ),
        Obx(
                ()=>Padding(
              padding:  EdgeInsets.symmetric(horizontal: 30.w),
              child: Row(
                children: [
                  Expanded(
                    flex:2,
                    child: GestureDetector(
                      onTap: ()async{
                        final DateTime? date
                        = await showDatePicker(
                            context: context,
                            initialDate: widget.controller.expectedTime.value,
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2030));
                        if (date != null && date != widget.controller.expectedTime.value){
                          widget.controller.expectedTime.value = date;
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
                                widget.controller.expectedTime.value
                            )
                        }',style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ),
                  ),
SizedBox(width: 25.w,),
                  Expanded(
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
                        child: Obx(
                                ()=>Row(
                          children: [
                            Expanded(child: GestureDetector(
                              onTap: (){
                                widget.controller.changeDayTime(0);
                              },
                              child: AnimatedContainer(
                                padding: EdgeInsets.all(8.r),
                                alignment: Alignment.center,
                                duration: Duration(milliseconds: 500),
                                decoration: BoxDecoration(
                                    color: widget.controller.dayTime==0
                                        ?mainColor:Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8.r),
                                      bottomRight: Radius.circular(8.r),
                                    )
                                ),
                                child: Text('PM',style: TextStyle(
                                    color: widget.controller.dayTime==0
                                        ?Colors.white:mainColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp
                                ),),
                              ),
                            )),
                            Expanded(child: GestureDetector(
                              onTap: (){
                                widget.controller.changeDayTime(1);
                              },
                              child: AnimatedContainer(
                                padding: EdgeInsets.all(8.r),
                                alignment: Alignment.center,
                                duration: Duration(milliseconds: 500),
                                decoration: BoxDecoration(
                                    color: widget.controller.dayTime==1
                                        ?mainColor:Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.r),
                                      bottomLeft: Radius.circular(8.r),
                                    )
                                ),
                                child: Text('AM',style: TextStyle(
                                    color: widget.controller.dayTime==1
                                        ?Colors.white:mainColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp
                                ),),
                              ),
                            )),
                          ],
                        ))
                    ),
                  )
                ],
              ),
            )
        ),
        SizedBox(height: 10.h,),
        Container(
          padding: EdgeInsets.all(15.r),
          width: Get.width,
          height: Get.height / 3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.circular(15.r),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text('التقرير',style: TextStyle(
                      color: mainColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold
                  ),)
                ],
              ),
              SizedBox(
                height: 5.h,
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
                                        () {},
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
                              onChanged: (val){
                                widget.controller.textReport=val;
                              },
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
            ],
          ),
        ),
        GestureDetector(
          onTap: (){
            actionSend="";

            if(widget.controller.check()){
              widget.controller.sendAssignment();
              Get.back();
            }
            else
              Get.snackbar("Error", "complete details",backgroundColor: Colors.red,colorText: Colors.white);


          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.r),
            margin: EdgeInsets.symmetric(
              horizontal: Get.width/5,
              vertical: 15.h,
            ),
            decoration: BoxDecoration(
              color:  mainColor,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Text('تأكيد',style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp
            ),),
          ),
        )

      ],
    );
  }
}

class ShowReportsTScreen extends StatelessWidget {
  const ShowReportsTScreen({
    Key? key,
    required this.map,
    required this.ticketStatus,
  }) : super(key: key);

  final Map map;
  final String ticketStatus;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(15.r),
      children: [
        (ticketStatus=='جديدة'||ticketStatus=='مغلقة')
            ?Container(
          height: Get.width *0.55,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                    color: colorShadowSearch.withOpacity(.26),
                    offset: Offset(0, 8),
                    blurRadius: 10)
              ]),
          child: Row(
            children: [
              Expanded(child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12.r),
                      bottomRight: Radius.circular(12.r),
                    )
                ),
              )),
              Expanded(
                  flex: 18,
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text('رقم التذكرة : ',style: TextStyle(
                                  color: mainColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text('${
                                  map['report_number']
                              }',style: TextStyle(
                                color: mainColor,
                              ),)
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
                              Text('${
                                  intl.DateFormat.yMd().add_jm().format(
                                      map['report_date']
                                  )
                              }',style: TextStyle(
                                color: mainColor,
                              ),)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text('نوع الحركة : ',style: TextStyle(
                                  color: mainColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text('${
                                  map['report_move_type']
                              }',style: TextStyle(
                                color: mainColor,
                              ),)
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
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 5.r,
                                    backgroundColor: Colors.grey,
                                  ),
                                  SizedBox(width: 5.sp,),
                                  Text('${
                                      map['report_status']
                                  }',style: TextStyle(
                                    color: mainColor,
                                  ),)
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text('مدخل التقرير : ',style: TextStyle(
                                  color: mainColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text('${
                                  map['reporter_name']
                              }',style: TextStyle(
                                color: mainColor,
                              ),)
                            ],
                          ),
                        ),

                      ],
                    ),
                  ))
            ],
          ),
        )
            :(ticketStatus=='مغلقة'||ticketStatus=='معتمدة')
            ?Container(
          height: Get.width *0.8,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                    color: colorShadowSearch.withOpacity(.26),
                    offset: Offset(0, 8),
                    blurRadius: 10)
              ]),
          child: Row(
            children: [
              Expanded(child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12.r),
                      bottomRight: Radius.circular(12.r),
                    )
                ),
              )),
              Expanded(
                  flex: 18,
                  child: Container(
                    padding: EdgeInsets.all(10.r),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text('رقم التذكرة : ',style: TextStyle(
                                  color: mainColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text('${
                                  map['report_number']
                              }',style: TextStyle(
                                color: mainColor,
                              ),)
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
                              Text('${
                                  intl.DateFormat.yMd().add_jm().format(
                                      map['report_date']
                                  )
                              }',style: TextStyle(
                                color: mainColor,
                              ),)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text('نوع الحركة : ',style: TextStyle(
                                  color: mainColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text('${
                                  map['report_move_type']
                              }',style: TextStyle(
                                color: mainColor,
                              ),)
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
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 5.r,
                                    backgroundColor: Colors.grey,
                                  ),
                                  SizedBox(width: 5.sp,),
                                  Text('${
                                      map['report_status']
                                  }',style: TextStyle(
                                    color: mainColor,
                                  ),)
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text('الوصف : ',style: TextStyle(
                                  color: mainColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: colorShadowSearch.withOpacity(.2),
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color:colorShadowSearch.withOpacity(.23),
                                  offset: Offset(0,8),
                                  blurRadius: 8.0
                                )
                              ]
                            ),
                            child: Text('الوصف المتوقع',style: TextStyle(
                              color: mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp
                            ),),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text('مدخل التقرير : ',style: TextStyle(
                                  color: mainColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text('${
                                  map['reporter_name']
                              }',style: TextStyle(
                                color: mainColor,
                              ),)
                            ],
                          ),
                        ),

                      ],
                    ),
                  ))
            ],
          ),
        )
            :Center(child: Text('No Reports'),)
      ],
    );
  }
}
