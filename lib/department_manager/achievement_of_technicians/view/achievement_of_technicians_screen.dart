import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:roofa/const/const_color.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:roofa/higher_management/homepage/view/home_screen.dart';
import 'package:roofa/higher_management/statistic_ticket/user_ticket.dart';
import 'package:roofa/widgets/material_text.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Firebase/controller.dart';
import '../../../const/text_app.dart';
import '../../../const_pdf.dart';
import '../../../higher_management/statistic_ticket/ticket_chart.dart';
import '../../../widgets/dialog_date_time.dart';
import 'package:intl/intl.dart' as intl;

import '../controller/achievement_of_technicians_controller.dart';

class AchievementOfTechniciansScreen extends StatefulWidget {
  @override
  State<AchievementOfTechniciansScreen> createState() => _AchievementOfTechniciansScreenState();
}

class _AchievementOfTechniciansScreenState extends State<AchievementOfTechniciansScreen> {
  final controller = Get.put(AchievementOfTechniciansController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("انجازات الفنيين"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            IconButton(onPressed: (){
              Get.off(()=>HomeScreenHM());
            }, icon: Icon(Icons.home))
          ],
        ),
        body: SingleChildScrollView(
            child: FutureBuilder(
                future: controller.fetchDataReportUser(),
                builder: (context,snapShot){
                  if(!snapShot.hasData){
                    return Center(child: CircularProgressIndicator());
                  }else{
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Obx(()=>Padding(
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
                                                  controller.onClickButton(
                                                      0
                                                  );
                                                },
                                                child: AnimatedContainer(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: controller.
                                                      index.
                                                      value == 0
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
                                                  duration:
                                                  Duration(milliseconds: 800),
                                                ),
                                              )),
                                          Expanded(
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller.onClickButton(
                                                      1
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
                                          Get.dialog(
                                              DalogDateTime()
                                          );
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
                        Container(
                          width: Get.width,
                          height: Get.height / 3.8,
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
                            crossAxisAlignment: CrossAxisAlignment
                                .stretch,
                            children: [
                              Text('إجمالي عدد التذاكر لكل الفنيين في الفترة المحددة',style: TextStyle(
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
                                                num:controller.totalReports?.length,//ticketsStatitics[0].numAllTicket,
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
                                                num:controller.closedReports?.length,//ticketsStatitics[0].numClosedTicket,
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
                                                num:controller.lateReports?.length,//ticketsStatitics[0].numLateTicket,
                                                color: Colors.pinkAccent
                                            ),
                                            _buildTicketText(
                                                text:'عدد التركيبات : ',
                                                num:controller.numFixtures,//ticketsStatitics[0].numCombinations,
                                                color: mainColor
                                            ),
                                            _buildTicketText(
                                                text:' فك / إزالة : ',
                                                num:controller.numRemovals,//ticketsStatitics[0].numRemoval,
                                                color: mainColor
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(width: 1,
                                      height: Get.height,
                                      color: mainColor,
                                    ),
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
                                                num:controller.spoonReports?.length,//ticketsStatitics[0].numPendingTicket,
                                                color: Colors.grey
                                            ),
                                            _buildTicketText(
                                                onTap: (){
                                                  controller.typeList="underProcedure";
                                                  controller.listReport=controller.underProcedureReports!;                                                                   controller.typeList="under Procedure";
                                                  setState(() {
                                                  });
                                                },
                                                text:' التذاكر تحت الإجراء : ',
                                                num:controller.underProcedureReports?.length,//ticketsStatitics[0].numProcedureTicket,
                                                color: Colors.blue
                                            ),
                                            _buildTicketText(
                                                onTap: (){
                                                  controller.listReport=controller.accreditedReports!;
                                                  controller.typeList="accredited";
                                                  setState(() {
                                                  });
                                                },
                                                text:' لا تتبع لقسم الصيانة : ',
                                                num:controller.accreditedReports?.length,//ticketsStatitics[0].numNotMaintenanceSection,
                                                color: Colors.orange
                                            ),
                                            _buildTicketText(
                                                text:' عدد التبديلات : ',
                                                num:controller.numSubstitutions,//ticketsStatitics[0].numChanges,
                                                color: mainColor
                                            ),
                                            _buildTicketText(
                                                text:' عدد الصيانات : ',
                                                num:controller.numMaintenance,//ticketsStatitics[0].numMaintenance,
                                                color: mainColor
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
                        Obx(
                              ()=> ExpansionTile(
                              key: GlobalKey(),
                              title: Text('اختر الفني الذي تريد عرضه',style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold
                              ),),
                              subtitle: Text('${controller.selectName}'),
                              children: controller
                                  .customerNames
                                  .map((e) => ListTile(
                                title: Text(e,style: TextStyle(
                                    color: controller
                                        .selectName
                                        .value == e
                                        ?mainColor:Colors.black
                                ),),
                                onTap: (){
                                  controller.selectName.value = e;
                                  setState(() {
                                  });
                                },
                              )).toList()
                          ),
                        ),
                        Obx(()=>Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              left: 15.w,
                              top: 5.h,
                              child: GestureDetector(
                                onTap: ()async{
                                  await launch(getStaticksFile);
                                },
                                child: SvgPicture.asset('images/download.svg'),
                              ),
                            ),
                            Column(
                              children: [
                                SvgPicture.asset('images/user-circle.svg'),
                                Text(controller.selectName.value,style: TextStyle(
                                    color: mainColor,
                                    fontWeight: FontWeight.bold
                                ),)
                              ],
                            )
                          ],)),
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
                                                  controller.typeList=(controller.selectName.value=="اسامة العوض")?"total":"null";
                                                  controller.listReport=controller.totalReports!;
                                                  setState(() {
                                                  });
                                                },
                                                text:'إجمالي التذاكر : ',
                                                num:(controller.selectName.value=="اسامة العوض")?controller.totalReports?.length:0,//userTicket[0].numAllTicket,
                                                color: Colors.green
                                            ),
                                            _buildTicketText(
                                                onTap: (){
                                                  controller.typeList=(controller.selectName.value=="اسامة العوض")?"closed":"null";
                                                  controller.listReport=controller.closedReports!;
                                                  setState(() {
                                                  });
                                                },
                                                text:'التذاكر المغلقة : ',
                                                num:(controller.selectName.value=="اسامة العوض")?controller.closedReports?.length:0,//userTicket[0].numClosedTicket,
                                                color: Colors.red
                                            ),
                                            _buildTicketText(
                                                onTap: (){
                                                  controller.listReport=controller.lateReports!;
                                                  controller.typeList=(controller.selectName.value=="اسامة العوض")?"late":"null";
                                                  setState(() {

                                                  });
                                                },
                                                text:'التذاكر المتأخرة : ',
                                                num:(controller.selectName.value=="اسامة العوض")?controller.lateReports?.length:0,//userTicket[0].numLateTicket,
                                                color: Colors.pinkAccent
                                            ),
                                            _buildTicketText(
                                                onTap: (){},
                                                text:'عدد الزيارات في الشهر : ',
                                                num:(controller.selectName.value=="اسامة العوض")?userTicket[0].visitedInMonth:0,
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
                                                  controller.typeList=(controller.selectName.value=="اسامة العوض")?"spoon":"null";
                                                  setState(() {
                                                  });
                                                },
                                                text:' التذاكر المعلقة : ',
                                                num:(controller.selectName.value=="اسامة العوض")?controller.spoonReports?.length:0,//userTicket[0].numPendingTicket,
                                                color: Colors.grey
                                            ),
                                            _buildTicketText(
                                                onTap: (){
                                                  controller.listReport=controller.accreditedReports!;
                                                  controller.typeList=(controller.selectName.value=="اسامة العوض")?"accredited":"null";
                                                  setState(() {
                                                  });
                                                },
                                                text:'التذاكر المعتمدة : ',
                                                num:(controller.selectName.value=="اسامة العوض")?controller.accreditedReports?.length:0,//userTicket[0].numAcceptableTicket,
                                                color: Colors.orange
                                            ),
                                            _buildTicketText(
                                                onTap: (){
                                                  controller.typeList=(controller.selectName.value=="اسامة العوض")?"underProcedure":"null";
                                                  controller.listReport=controller.underProcedureReports!;                                                                   controller.typeList="under Procedure";
                                                  setState(() {
                                                  });
                                                },
                                                text:' التذاكر تحت الإجراء : ',
                                                num:(controller.selectName.value=="اسامة العوض")?controller.underProcedureReports?.length:0,//userTicket[0].numProcedureTicket,
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
                          children: List.generate(controller.listReport.length, (index) =>
                              GestureDetector(
                            onTap: () {},
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
                                                statusReport[Controllert.colorState(
                                                  // التعلميمة تعطيني لون التذكرة بناءا على الاسم
                                                    "${controller.listReport[index]['الحالة']}")]['name'][1] :
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
                    );
                  }})
        ),
      ),
    );
  }

  Widget _buildTicketText({text,num,color,onTap}) => Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Text('$text ${num}',style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold
      ),),
    ),);
}
class TicketChartWidget extends StatelessWidget {
  final List<TicketChart> data;
  TicketChartWidget({required this.data});
  @override
  Widget build(BuildContext context) {

    List<charts.Series<TicketChart, String>> series = [
      charts.Series(
          id: "Soon",
          data: data,
          domainFn: (TicketChart series, _) => series.numX,
          measureFn: (TicketChart series, _) => series.numY,//int.parse(series.numX),
          colorFn: (TicketChart series, _) => series.barColor
      )
    ];
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: charts.BarChart(
                series,
                animate: true,
              ),
            )
          ],
        ),
      ),
    );
  }

}
List<TicketChart> data = [
  TicketChart(
    numX: "40",
    numY: 1200,
    barColor: charts.ColorUtil.fromDartColor(Colors.green),
  ),
  TicketChart(
    numX: "35",
    numY: 1000,
    barColor: charts.ColorUtil.fromDartColor(Colors.orange),
  ),
  TicketChart(
    numX: "30",
    numY: 800,
    barColor: charts.ColorUtil.fromDartColor(Colors.blue),
  ),
  TicketChart(
    numX: "25",
    numY: 600,
    barColor: charts.ColorUtil.fromDartColor(Colors.red),
  ),
  TicketChart(
    numX: "20",
    numY: 400,
    barColor: charts.ColorUtil.fromDartColor(Colors.grey),
  ),
  TicketChart(
    numX: "15",
    numY: 200,
    barColor: charts.ColorUtil.fromDartColor(Colors.pink),
  ),
];