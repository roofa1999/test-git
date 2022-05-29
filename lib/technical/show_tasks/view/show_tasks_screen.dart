import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:roofa/customer/details_ticket/view/details_ticket.dart';
import 'package:roofa/technical/show_tasks/controller/show_task_controller.dart';
import 'package:select_dialog/select_dialog.dart';

import '../../../Firebase/controller.dart';
import '../../../Firebase/firebase.dart';
import '../../../Firebase/reports.dart';
import '../../../const/const_color.dart';
import '../../../const/text_app.dart';
import 'package:intl/intl.dart' as intl;

import '../../../widgets/dialog_date_time.dart';
import '../../ticket_details/view/ticket_details_screen.dart';

class ShowTasksTScreen extends StatefulWidget {
  @override
  State<ShowTasksTScreen> createState() => _ShowTasksTScreenState();
}

class _ShowTasksTScreenState extends State<ShowTasksTScreen> {
  final controller = Get.put(ShowTasksTController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text("عرض المهام"),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: (){
                Get.back();
              },
            ),
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
                                )),onChanged: (val){
    controller.searchFilter=val;
    controller.update();
    setState((){
    });}
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
              SizedBox(
                height: 20.h,
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
                  itemCount: statusSortTechnical.length,
                  itemBuilder: (ctx,index){
                    List c = statusSortTechnical[index]['type_sort_name']
                    ['type_sort_value'];
                    return ListTile(
                      textColor: mainColor,
                      trailing: Icon(Icons.arrow_drop_down),
                      title: Text(
                        '${statusSortTechnical[index]['type_sort_name']['name']}',
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
                            controller.headquartersFilter="";
                            controller.beneficiaryFilter="";
                            switch("${statusSortDM[index]['type_sort_name']['name']}"){
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
                ),
              ),
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
                        bool isNew=(controller.listReport[index]["الجهة"]=="الفنيين"&&
                            (controller.listReport[index]["الحالة"]=="تحت الإجراء"&&
                                controller.listReport[index]["tracking"].length==0));
                        return GestureDetector(
                          onTap: () {
                            Report.reportNumber=controller.listReport[index]['رقم البلاغ'];
                            Get.to(()=>DetailsTicketTScreen(
                              map: mapDetailsT,
                            ),transition: Transition.downToUp);
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Container(
                                      height: Get.width * 0.5,
                                      decoration: BoxDecoration(
                                          color: isNew?Colors.grey:
                                          statusReport[Controllert.colorState("${controller.listReport[index]['الحالة']}")]['name'][1],//Colors.grey,
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
                                              Text(
                                                'إحالة إلى مركز الصيانة ',
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 15.sp),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  FirebaseController.formatTimestamp(controller.listReport[index]["Time"]),
                                                /*  '${
                                                      intl.DateFormat.yMd().
                                                      add_j().format(
                                                          allreportsTechnical
                                                          [index]
                                                          ['report_date']
                                                      )
                                                  }',*/
                                                  style: TextStyle(
                                                      color: mainColor,
                                                      height: 1.5),
                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:   isNew?Colors.grey
                                                          :statusReport[Controllert.colorState("${controller.listReport[index]['الحالة']}")]['name'][1],//Colors.grey,
                                                      radius:  5.r,
                                                    ),
                                                    SizedBox(width: 5,),
                                                    Text('${
                                                        isNew?"جديدة"
                                                        :controller.listReport[index]['الحالة']
                                                    }'),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text('رقم البلاغ : ',style: TextStyle(
                                                            color: mainColor,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 15.sp
                                                        ),),
                                                        Text('${
                                                            controller.listReport[index]['رقم البلاغ']
                                                        }',style: TextStyle(
                                                            color: mainColor
                                                        ),)
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text('الجهة : ',style: TextStyle(
                                                            color: mainColor,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 15.sp
                                                        ),),
                                                        Text('${
                                                            controller.listReport[index]['الجهة المستفيدة']
                                                        }',
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                              color: mainColor
                                                          ),)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text('الإنجاز من',
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.grey
                                                    ),),
                                                  Row(
                                                    children: [
                                                      Text(

                                                        '${
                                                          intl.DateFormat.yMd().format(
                                                              //FirebaseController.formatTimestamp(controller.listReport[index]["TimeTo"]),
                                                              allreportsTechnical[index]['report_done_from']
                                                          )
                                                      }',
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 10.sp
                                                        ),),
                                                      Text('إلى',style: TextStyle(
                                                          color: Colors.grey
                                                      ),),
                                                      Text('${
                                                          intl.DateFormat.yMd().format(
                                                             // FirebaseController.formatTimestamp(controller.listReport[index]["TimeFor"]),
                                                              allreportsTechnical[index]['report_done_to']
                                                          )
                                                      }',style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 10.sp
                                                      ),),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'المقر : ',
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 15.sp),
                                              ),
                                              Text('${
                                                  controller.listReport[index]['المقر']
                                              }',style: TextStyle(
                                                  color: mainColor
                                              ),),
                                          ( controller.listReport[index]["الحالة"]!="مرفوضة"&&
                                              controller.listReport[index]["الحالة"]!="مغلقة"&&
                                              controller.listReport[index]["الجهة"]=="الفنيين"&&
                                              Timestamp.now().compareTo( controller.listReport[index]["TimeFor"])==1)?
                                              Expanded(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 70,),
                                                      Text(
                                                        'التذكرة متأخرة',
                                                        style: TextStyle(
                                                            color: Colors.purple,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 13.sp),
                                                      ),
                                                    ],
                                                  ),
                                              ):SizedBox(),

                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'الفني المسؤول : ',
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 15.sp),
                                              ),
                                              Text('${
                                                  allreportsTechnical[index]
                                                  ['technical_name']
                                              }',style: TextStyle(
                                                  color: mainColor
                                              ),)
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'الفنيي المساعدين : ',
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontWeight:
                                                    FontWeight.bold,
                                                    fontSize: 15.sp),
                                              ),
                                              Text('${
                                                  allreportsTechnical[index]
                                                  ['helper_technical_name']
                                              }',style: TextStyle(
                                                  color: mainColor
                                              ),)
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }}),
              )
            ],
          ),
        ));
  }
}
