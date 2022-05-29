import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:roofa/Firebase/firebase.dart';
import 'package:roofa/const/const_color.dart';
import 'package:roofa/const_pdf.dart';
import 'package:roofa/higher_management/statistic_ticket/ticket_chart.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Firebase/controller.dart';

import '/technical/achievement/controller/achevmebt_controller.dart';

import '../../../const/text_app.dart';
import '../../../higher_management/statistic_ticket/view/statistic_screen.dart';
import '../../../widgets/dialog_date_time.dart';
import '../../../widgets/material_text.dart';

class AchivementTScreen extends StatefulWidget {
  @override
  State<AchivementTScreen> createState() => _AchivementTScreenState();
}

class _AchivementTScreenState extends State<AchivementTScreen> {
  final controller = Get.put(AchivementTController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'عرض تقارير التذاكر',
            ),
            centerTitle: true,
          ),
          body: FutureBuilder(
              future: controller.fetchDataReportUser(),
              builder: (context,snapShot){
                if(!snapShot.hasData){
                  return Center(child: CircularProgressIndicator());
                }else{
                  return SingleChildScrollView(
                    child:Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Obx(
                                    ()=>Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
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
                                                    },
                                                    child: AnimatedContainer(
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: controller.index.value == 0
                                                              ? mainColor
                                                              : Colors.white,
                                                          borderRadius: BorderRadius.circular(50.r)),
                                                      child: Text(
                                                        'أسبوعي',
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
                                                    },
                                                    child: AnimatedContainer(
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: controller.index.value == 1
                                                              ? mainColor
                                                              : Colors.white,
                                                          borderRadius: BorderRadius.circular(50.r)),
                                                      child: Text(
                                                        'شهري',
                                                        style: TextStyle(
                                                          color: controller.index.value == 1
                                                              ? controller.textButtonActive
                                                              : mainColor,
                                                        ),
                                                      ),
                                                      duration: Duration(milliseconds: 500),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                            onPressed: () {
                                              Get.dialog(DalogDateTime());
                                            },
                                            icon: Icon(
                                              Icons.date_range_sharp,
                                              color: grayColor,
                                            )),
                                      ),

                                    ],
                                  ),
                                )
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [

                                Positioned(
                                  left: 15.w,
                                  top: 5.h,
                                  child: GestureDetector(
                                    onTap: ()async{
                                   await launch(getStaticksTechnicalFile);
                                    },
                                    child: SvgPicture.asset('images/download.svg'),
                                  ),
                                ),
                                Column(
                                  children: [
                                    SvgPicture.asset('images/user-circle.svg'),
                                    Text(FirebaseController.name/*controller.selectName.value*/,style: TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.bold
                                    ),)
                                  ],
                                )
                              ],),
                            Container(
                                           width: Get.width,
                                           height: Get.height / 4.8,
                                           margin: EdgeInsets.only(top: 10.0.h),
                                           padding: const EdgeInsets.all(8.0),
                                           decoration: BoxDecoration(
                                               color: Colors.white,
                                               boxShadow: [
                                                 BoxShadow(
                                                     color: Color(0xfCBC6C6).withOpacity(.16),
                                                     offset: Offset(0,9),
                                                     blurRadius: 10
                                                 ),
                                               ]
                                           ),
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.stretch,
                                             children: [
                                               Text('عدد التذاكر في الفترة الزمنية المحددة',style: TextStyle(
                                                   color: mainColor,
                                                   fontWeight: FontWeight.bold,
                                                   fontSize: 15.sp
                                               ),),
                                               Expanded(
                                                 child: Row(
                                                   children: [
                                                     Expanded(
                                                       child: Container(
                                                         padding: EdgeInsets.all(8.0),
                                                         child: Column(
                                                           crossAxisAlignment: CrossAxisAlignment.stretch,
                                                           children: [
                                                             _buildTicketText(
                                                                 onTap: (){
                                                                   controller.typeList="total";
                                                                   controller.listReport=controller.totalReports!;
                                                                   setState(() {
                                                                   });
                                                                 },
                                                                 text:'إجمالي التذاكر : ',
                                                                 num:controller.totalReports?.length,//userTicket[0].numAllTicket,
                                                                 color: Colors.green
                                                             ),
                                                             _buildTicketText(
                                                                 onTap: (){
                                                                   controller.typeList="closed";
                                                                  controller.listReport=controller.closedReports!;
                                                                   setState(() {
                                                                   });
                                                                 },
                                                                 text:'التذاكر المغلقة : ',
                                                                 num:controller.closedReports?.length,//userTicket[0].numClosedTicket,
                                                                 color: Colors.red
                                                             ),
                                                             _buildTicketText(
                                                                 onTap: (){
                                                                   controller.listReport=controller.lateReports!;
                                                                   controller.typeList="late";
                                                                   setState(() {

                                                                   });
                                                                 },
                                                                 text:'التذاكر المتأخرة : ',
                                                                 num:controller.lateReports?.length,//userTicket[0].numLateTicket,
                                                                 color: Colors.pinkAccent
                                                             ),
                                                             _buildTicketText(
                                                                 onTap: (){},
                                                                 text:'عدد الزيارات في الشهر : ',
                                                                 num:userTicket[0].visitedInMonth,
                                                                 color:Colors.black
                                                             ),

                                                           ],
                                                         ),
                                                       ),
                                                     ),
                                                     Container(width: 1,height: Get.height,color: mainColor,),
                                                     Expanded(
                                                       child: Container(
                                                         padding: EdgeInsets.all(8.0),
                                                         child: Column(
                                                           crossAxisAlignment: CrossAxisAlignment.stretch,
                                                           children: [
                                                             _buildTicketText(
                                                                 onTap: (){
                                                                   controller.listReport=controller.spoonReports!;
                                                                   controller.typeList="spoon";
                                                                   setState(() {
                                                                   });
                                                                 },
                                                                 text:' التذاكر المعلقة : ',
                                                                 num:controller.spoonReports?.length,//userTicket[0].numPendingTicket,
                                                                 color: Colors.grey
                                                             ),
                                                             _buildTicketText(
                                                                 onTap: (){
                                                                   controller.listReport=controller.accreditedReports!;
                                                                   controller.typeList="accredited";
                                                                   setState(() {
                                                                   });
                                                                 },
                                                                 text:'التذاكر المعتمدة : ',
                                                                 num:controller.accreditedReports?.length,//userTicket[0].numAcceptableTicket,
                                                                 color: Colors.orange
                                                             ),
                                                             _buildTicketText(
                                                                 onTap: (){
                                                                   controller.typeList="underProcedure";
                                                                   controller.listReport=controller.underProcedureReports!;                                                                   controller.typeList="under Procedure";
                                                                   setState(() {
                                                                   });
                                                                 },
                                                                 text:' التذاكر تحت الإجراء : ',
                                                                 num:controller.underProcedureReports?.length,//userTicket[0].numProcedureTicket,
                                                                 color: Colors.blue
                                                             ),

                                                           ],
                                                         ),
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                            Column(
                                           children: List.generate(controller.listReport.length, (index) => GestureDetector(
                                             onTap: () {
                                             },
                                             child: Container(
                                               margin: EdgeInsets.symmetric(
                                                   horizontal: 12.w, vertical: 10.h),
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
                                                             height: constrains.maxWidth / 2.5,
                                                             decoration: BoxDecoration(
                                                                 color: (controller.typeList!="late")?
                                                                 statusReport[Controllert.colorState("${controller.listReport[index]['الحالة']}")]['name'][1]:
                                                                 colorpurple,
                                                                 // Colors.red,
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
                                                                               'رقم البلاغ: ',
                                                                               style: TextStyle(
                                                                                   color: mainColor,
                                                                                   fontWeight:
                                                                                   FontWeight.bold,
                                                                                   fontSize: 15.sp),
                                                                             ),
                                                                             Text(
                                                                               '${controller.listReport[index]['رقم البلاغ']}',
                                                                               //'${allreports[3]['report_num']}',
                                                                               style: TextStyle(
                                                                                   color: mainColor,
                                                                                   height: 1.5),
                                                                             ),
                                                                           ],
                                                                         )),
                                                                     Row(
                                                                       children: [
                                                                         CircleAvatar(
                                                                           radius: 6.r,
                                                                           backgroundColor: (controller.typeList!="late")?
                                                                           statusReport[Controllert.colorState("${controller.listReport[index]['الحالة']}")]['name'][1]:
                                                                           colorpurple,
                                                                           //Colors.red,
                                                                         ),
                                                                         SizedBox(
                                                                           width: 10.w,
                                                                         ),
                                                                         Text(controller.listReport[index]['الحالة'],
                                                                           // '${allreports[3]['report_status']}',
                                                                           style: TextStyle(
                                                                             color: (controller.typeList!="late")?
                                                                             statusReport[Controllert.colorState("${controller.listReport[index]['الحالة']}")]['name'][1]:
                                                                             colorpurple,
                                                                           ),
                                                                         )
                                                                       ],
                                                                     )

                                                                   ],
                                                                 ),
                                                                 Row(
                                                                   children: [
                                                                     Expanded(
                                                                         flex: 2,
                                                                         child: Wrap(
                                                                           children: [
                                                                             Text(
                                                                               'الجهة: ',
                                                                               style: TextStyle(
                                                                                   color: mainColor,
                                                                                   fontWeight:
                                                                                   FontWeight.bold,
                                                                                   fontSize: 15.sp),
                                                                             ),
                                                                             Text(
                                                                               '${
                                                                                   controller.listReport[index]['الجهة المستفيدة']
                                                                               }',
                                                                               //'${allreports[3]['report_sender']}',
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
                                                                       child: Column(
                                                                         crossAxisAlignment:
                                                                         CrossAxisAlignment
                                                                             .stretch,
                                                                         children: [
                                                                           Wrap(
                                                                             children: [
                                                                               Text(
                                                                                 'المقر: ',
                                                                                 style: TextStyle(
                                                                                     color: mainColor,
                                                                                     fontWeight:
                                                                                     FontWeight
                                                                                         .bold,
                                                                                     fontSize: 15.sp),
                                                                               ),
                                                                               Text(
                                                                                 '${
                                                                                     controller.listReport[index]['المقر']
                                                                                 }',
                                                                                 //'${allreports[3]['report_position']}',
                                                                                 style: TextStyle(
                                                                                     color: mainColor,
                                                                                     height: 1.5),
                                                                               ),
                                                                             ],
                                                                           ),
                                                                           Wrap(
                                                                             children: [
                                                                               Text(
                                                                                 'الاسم: ',
                                                                                 style: TextStyle(
                                                                                     color: mainColor,
                                                                                     fontWeight:
                                                                                     FontWeight
                                                                                         .bold,
                                                                                     fontSize: 15.sp),
                                                                               ),
                                                                               Text(
                                                                                 '${
                                                                                     controller.listReport[index]['الاسم']
                                                                                 }',
                                                                                 // '${allreports[3]['reporter_name']}',
                                                                                 style: TextStyle(
                                                                                     color: mainColor,
                                                                                     height: 1.5),
                                                                               ),
                                                                             ],
                                                                           ),
                                                                         ],
                                                                       ),
                                                                     ),
                                                                   ],
                                                                 )
                                                               ],
                                                             ),
                                                           )),
                                                     ],
                                                   );
                                                 },
                                               ),
                                             ),
                                           )),
                                         ),
                            Container(
                              width: Get.width,
                              height: Get.height / 1.99,
                              child: TicketChartWidget(
                                data: controller.giveData([
                                  controller.totalReports?.length,
                                  controller.accreditedReports?.length,
                                  controller.underProcedureReports?.length,
                                  controller.closedReports?.length,
                                  controller.spoonReports?.length,
                                  controller.lateReports?.length,
                                ]),
                              ),
                            ),
                          ],
                        ),


                  );
                }})
      ),
    );
  }

  Widget _buildTicketText({text,num,color,onTap}) =>
      Expanded(child: GestureDetector(
        onTap: onTap,
        child: Text('$text ${num}',style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold
  ),),
      ),);
}
