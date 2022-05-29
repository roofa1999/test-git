import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:roofa/const_pdf.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Customer/details_ticket/view/details_ticket.dart';
import '../../../const/const_color.dart';
import '../../../const/text_app.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/material_text.dart';
import '../../home_page/view/home_page.dart';
import '../controller/reposrts_controller.dart';
import 'package:intl/intl.dart' as intl;

class ReportsScreen extends StatelessWidget {
  final controller = Get.put(ReportsController());
  Color? color;

  ReportsScreen({this.color});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("متابعة البلاغات"),
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
                  DetailsTicketCSPage(color: Colors.grey,controller: controller,),
                  ReportsLogCsPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsTicketCSPage extends StatelessWidget {
   DetailsTicketCSPage({
    Key? key,
    required this.controller,
    required this.color,
  }) : super(key: key);

  final ReportsController controller;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Get.width * 1.2,
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
                                                                      () {},
                                                                  icon: Icon(
                                                                      Icons
                                                                          .delete_forever_outlined)),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {},
                                                                  icon: Icon(
                                                                      Icons
                                                                          .attach_file_outlined)),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {},
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
                                                  Get.back();
                                                  showCustomDialog(
                                                      text: 'تم إضافة رد على التذكرة'
                                                  );
                                                  Timer(Duration(
                                                      seconds: 1),
                                                          (){
                                                        Get.back();
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
                                              fontWeight: FontWeight
                                                  .bold,
                                              fontSize: 15.sp),
                                        ),
                                        Text(
                                          '${ticketInformation['ticket_id']}',
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
                                          '${intl.DateFormat.yMEd()
                                              .add_jms()
                                              .format(
                                              ticketInformation['ticket_date'])}',
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
                                          backgroundColor: color,
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          '${ticketInformation['ticket_status']}',
                                          style: TextStyle(
                                            color: color,
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
                                      '${ticketInformation['ticket_priority']}',
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
                                      '${ticketInformation['ticket_building']}',
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
                                      '${ticketInformation['ticket_floor']}',
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
                                      '${ticketInformation['ticket_room_type']}',
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
                                      '${ticketInformation['ticket_room_number']}',
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
    );
  }
}

class ReportsLogCsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = logTicketCustomerServices;
    return ListView(
      children:[

        _buildContainer(
            height: Get.width * 0.8,
            color: c[1]['color'],
            child: Column(
              children: [
                _buildInfoTicket(label: 'رقم  التذكرة',
                    value: c[1]['report_number']),
                _buildInfoTicket(label: 'التاريخ',
                    value: intl.DateFormat.yMEd().add_jm().format(c[1]['report_date_time'])),
                _buildInfoTicket(label: 'نوع الحركة',
                    value: c[1]['type_des']),
                _buildInfoTicket(label: 'الوصف',
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
                  child: Text('${c[1]['ticket_problem_description']}',style: TextStyle(
                    color: mainColor
                  ),)
                )),
                _buildInfoTicket(label: 'مدخل التقرير',
                    value: c[1]['reporter_name']),
              ],
            )
        ),
        _buildContainer(
            height: Get.width * 0.9,
            color: c[2]['color'],
            child: Column(
              children: [
                _buildInfoTicket(label: 'رقم  التذكرة',
                    value: c[2]['report_number']),
                _buildInfoTicket(label: 'التاريخ',
                    value: intl.DateFormat.yMEd().add_jm().format(c[2]['report_date_time'])),
                _buildInfoTicket(label: 'نوع الحركة',
                    value: c[2]['type_des']),
                _buildInfoTicket(label: 'اسم الجهاز',
                    value: c[2]['device_name']),
                _buildInfoTicket(label: 'نوع الجهاز',
                    value: c[2]['device_type']),
                _buildInfoTicket(label: 'الوصف',
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
                    child: Text('${c[2]['ticket_problem_description']}',style: TextStyle(
                        color: mainColor
                    ),)
                )),
                _buildInfoTicket(label: 'مدخل التقرير',
                    value: c[2]['reporter_name']),
              ],
            )
        ),
        _buildContainer(
            height: Get.width * 0.7,
            color: c[3]['color'],
            child: Column(
              children: [
                _buildInfoTicket(label: 'رقم  التذكرة',
                    value: c[3]['report_number']),
                _buildInfoTicket(label: 'التاريخ',
                    value: intl.DateFormat.yMEd().add_jm()
                        .format(c[3]['report_date_time'])),
                _buildInfoTicket(label: 'نوع الحركة',
                    value: c[3]['type_des']),
                _buildInfoTicket(label: 'الوصف',
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
                        child: Text('${c[3]['ticket_problem_description']}',style: TextStyle(
                            color: mainColor
                        ),)
                    )),
                _buildInfoTicket(label: 'مدخل التقرير',
                    value: c[3]['reporter_name']),
              ],
            )
        ),
      ]
    );
  }
  Widget _buildInfoTicket({required label,required value}){
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
  Widget _buildContainer({
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
}

