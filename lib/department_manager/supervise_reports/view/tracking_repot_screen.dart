import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roofa/department_manager/details_report_ticket/view/details_report_ticket.dart';
import 'package:roofa/department_manager/home_page/view/home_page.dart';
import 'package:select_dialog/select_dialog.dart';

import '../../../Customer/details_ticket/view/details_ticket.dart';
import '../../../Firebase/controller.dart';
import '../../../Firebase/firebase.dart';
import '../../../Firebase/reports.dart';
import '../../../const/const_color.dart';
import '../../../const/text_app.dart';
import 'package:intl/intl.dart' as intl;

import '../../../widgets/dialog_date_time.dart';
import '../controller/supervise_repot_controller.dart';

class TrackingRepotDMScreen extends StatefulWidget {
  @override
  State<TrackingRepotDMScreen> createState() => _TrackingRepotDMScreenState();
}

class _TrackingRepotDMScreenState extends State<TrackingRepotDMScreen> {
  final controller = Get.put(SuperviseReportDMController());

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
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.r),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                  colorShadowSearch.withOpacity(.16),
                                  blurRadius: 10,
                                  offset: Offset(0, 9))
                            ]),
                        child: TextFormField(
                          cursorColor: mainColor,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.r),
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              hintText: 'البحث برقم البلاغ',
                              hintStyle: TextStyle(color: mainColor),
                              prefixIcon: Icon(
                                Icons.search,
                                color: mainColor,
                              )),
                          onChanged: (val){
                            controller.searchFilter=val;
                            controller.update();
                            setState((){
                            });
                          },
                        ),
                      )),
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
            ),
            Container(
                decoration:
                BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: colorShadowSearch.withOpacity(.56),
                      blurRadius: 10,
                      offset: Offset(0, 4))
                ]),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: statusSortDM.length,
                  itemBuilder: (context, index) {
                    List c = statusSortDM[index]['type_sort_name']
                    ['type_sort_value'];
                    return GetBuilder<SuperviseReportDMController>(
                      builder: (_) {
                        return  ListTile(
                          textColor: mainColor,
                          trailing: Icon(
                            Icons.keyboard_arrow_down,size: 25.r,),
                          title: Text(
                            '${statusSortDM[index]['type_sort_name']['name']}',
                            style:
                            TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: (){
                            SelectDialog.showModal(
                              context,
                              label: "${controller.selectedText}",
                              selectedValue: '${controller.selectedText.value}',
                              items: c,
                              onChange: (selected) {
                                controller.selectedText.value = selected.toString();
                                //controller.update();
                                //=======//
                                controller.stateFilter="";
                                controller.moveType="";
                                controller.headquartersFilter="";
                                controller.beneficiaryFilter="";
                                switch("${statusSortDM[index]['type_sort_name']['name']}"){
                                  case "فرز على حسب الحالة":
                                    controller.stateFilter=selected.toString();
                                    break;
                                  case "فرز على حسب الحركة":
                                    controller.moveType=selected.toString();
                                    break;
                                  case "فرز على حسب الجهة":
                                    controller.beneficiaryFilter=selected.toString();
                                    break;
                                  case "فرز على حسب المقر":
                                    controller.headquartersFilter=selected.toString();
                                    print(controller.headquartersFilter);
                                    break;
                                }
                                //await controller.fetchDataReportUser();
                                controller.update();
                                setState((){
                                });
                                //=======
                              },
                            );
                          },

                        );
                      },
                    );
                  },
                )),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: FutureBuilder(
                  future: controller.fetchDataReportUser(),
                  builder: (context,snapShot) {
                    if (!snapShot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        itemCount: controller.listReport.length,
                        itemBuilder: (ctx, index) {
                          List c =["عبدالله القحطاني"];// allreportsDM[index]['reporter_helper'];
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 8.h),
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
                                              color: statusReport[Controllert.colorState("${controller.listReport[index]['الحالة']}")]['name'][1],
                                              /*controller.listReport[index]['الحالة']
                                              [0] !=
                                                  statusReport[index]['name']
                                                  ? statusReport[index]['name'][1]
                                                  : Colors.green,*/
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15.r),
                                                bottomRight: Radius.circular(15.r),
                                              )),
                                        )),
                                    Expanded(
                                        flex: 18,
                                        child: GestureDetector(
                                          onTap: (){
                                            Report.reportNumber=controller.listReport[index]['رقم البلاغ'];
                                            Get.to(()=>
                                                DetailsReportTicketDMScreen(
                                                  color: statusReport[Controllert.colorState("${controller.listReport[index]['الحالة']}")]['name'][1],//statusReport[index]['name'][1],
                                                  isShow: (index==0||index==2)?true:false,
                                                  index: index,
                                                ));
                                                /*ReportsScreen*///DetailsTicketScreen(color: statusReport[Controllert.colorState("${controller.listReport[index]['الحالة']}")]['name'][1],));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5.r),
                                            decoration: BoxDecoration(),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text('رقم البلاغ : ',style: TextStyle(
                                                              color: mainColor,
                                                              fontWeight: FontWeight.bold
                                                          ),),
                                                          Text(
                                                            '${
                                                                controller.listReport[index]['رقم البلاغ']
                                                            }'
                                                            ,style: TextStyle(
                                                            color: mainColor,
                                                          ),)
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text('الجهة : ',style: TextStyle(
                                                              color: mainColor,
                                                              fontWeight: FontWeight.bold
                                                          ),),
                                                          Text(
                                                            '${
                                                                controller.listReport[index]['الجهة المستفيدة']
                                                            }'
                                                            ,style: TextStyle(
                                                            color: mainColor,
                                                          ),)
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text('المقر : ',style: TextStyle(
                                                              color: mainColor,
                                                              fontWeight: FontWeight.bold
                                                          ),),
                                                          Text(
                                                            '${
                                                                controller.listReport[index]['المقر']
                                                            }'
                                                            ,style: TextStyle(
                                                            color: mainColor,
                                                          ),)
                                                        ],
                                                      ),
                                            (controller.listReport[index]["الجهة"]=="الفنيين")?
                                                      Row(
                                                        children: [
                                                          Text('الفني المسؤول : ',style: TextStyle(
                                                              color: mainColor,
                                                              fontWeight: FontWeight.bold
                                                          ),),
                                                          Text(
                                                            '${
                                                                "فني مسؤول" //allreportsDM[index]['reporter_name']
                                                            }'
                                                            ,style: TextStyle(
                                                            color: mainColor,
                                                          ),)
                                                        ],
                                                      ):SizedBox(),
                                                      (controller.listReport[index]["الجهة"]=="الفنيين")?
                                                      Row(
                                                        children: [
                                                          Text('الفنيين المساعدين : ',style: TextStyle(
                                                              color: mainColor,
                                                              fontWeight: FontWeight.bold
                                                          ),),
                                                          Row(
                                                            children: c.map((e) =>
                                                                Text('$e,',style: TextStyle(
                                                                    fontSize: 9.sp,
                                                                    color: mainColor
                                                                ),)).toList(),
                                                          )
                                                        ],
                                                      ):SizedBox(),

                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        FirebaseController.formatTimestamp(controller.listReport[index]["Time"]),
                                                        //'${intl.DateFormat.yMEd().add_jm().format(allreportsDM[index]['report_date_time'])}'
                                                        style: TextStyle(
                                                            color: grayColor,
                                                            fontSize: 10.sp
                                                        ),),
                                                      SizedBox(height: 20,),
                                                      Row(
                                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 5.r,
                                                            backgroundColor: statusReport[Controllert.colorState("${controller.listReport[index]['الحالة']}")]['name'][1],
                                                            /*allreportsDM[index]['report_status']
                                                            [0] !=
                                                                statusReport[index]['name']
                                                                ? statusReport[index]['name'][1]
                                                                : Colors.green,*/
                                                          ),
                                                          Text(
                                                            " ${controller.listReport[index]['الحالة']} ",
                                                            //'  ${allreportsDM[index]['report_status']}',
                                                            style: TextStyle(
                                                              color: statusReport[Controllert.colorState("${controller.listReport[index]['الحالة']}")]['name'][1],/*allreportsDM[index]['report_status']
                                                              [0] !=
                                                                  statusReport[index]['name']
                                                                  ? statusReport[index]['name'][1]
                                                                  : Colors.green,*/
                                                            ),
                                                          )
                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
