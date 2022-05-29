import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:roofa/Customer/details_ticket/view/details_ticket.dart';
import 'package:roofa/Firebase/controller.dart';
import 'package:roofa/Firebase/firebase.dart';

import 'package:roofa/const/const_color.dart';
import 'package:roofa/widgets/custom_text_field.dart';
import 'package:roofa/widgets/dialog_date_time.dart';
import 'package:roofa/widgets/material_text.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:roofa/const/text_app.dart';

import '../../../Firebase/reports.dart';
import '../../../rating/view/rating_screen.dart';
import '../../../widgets/custom_dialog.dart';
import '../controller/supervise_controller.dart';

class SuperviserReportsScreen extends StatefulWidget {
  @override
  State<SuperviserReportsScreen> createState() => _SuperviserReportsScreenState();
}

class _SuperviserReportsScreenState extends State<SuperviserReportsScreen> {
  final contrller = Get.put(SuperviserReportController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text("متابعة البلاغات "),
            centerTitle: true,
            leading: IconButton(
              onPressed: (){
                Get.back();
              },
              icon: Icon(Icons.arrow_back_ios),
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
                                )),
                            onChanged: (val){
                              contrller.searchFilter=val;
                              contrller.update();
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
                    itemCount: statusSort.length,
                    itemBuilder: (context, index) {
                      List c = statusSort[index]['type_sort_name']
                          ['type_sort_value'];
                      return GetBuilder<SuperviserReportController>(
                        builder: (_) {
                          /*

                          */
                          return  ListTile(
                              textColor: mainColor,
                              leading: Icon(Icons.keyboard_arrow_down),
                              title: Text(
                                '${statusSort[index]['type_sort_name']['name']}',
                                style:
                                TextStyle(fontWeight: FontWeight.bold),
                              ),
                            onTap: (){
                              SelectDialog.showModal(
                                context,
                                label: "${contrller.selectedText}",
                                selectedValue: '${contrller.selectedText.value}',
                                items: c,
                                onChange: (selected) async {
                                 contrller.selectedText.value = selected.toString();
                                 //contrller.update();
                                 //=======//
                                 contrller.stateFilter="";
                                 contrller.headquartersFilter="";
                                 contrller.beneficiaryFilter="";
                                 switch("${statusSort[index]['type_sort_name']['name']}"){
                                   case "فرز على حسب الحالة":
                                     contrller.stateFilter=selected.toString();
                                     break;
                                   case "فرز على حسب الجهة":
                                     contrller.beneficiaryFilter=selected.toString();
                                     break;
                                   case "فرز على حسب المقر":
                                     contrller.headquartersFilter=selected.toString();
                                     print(contrller.headquartersFilter);
                                     break;
                                 }
                                 //await contrller.fetchDataReportUser();
                                 contrller.update();
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
                  future: contrller.fetchDataReportUser(),
                  builder: (context,snapShot) {
                    if (!snapShot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        itemCount: contrller.listReport.length,//allreports.length,
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () async {
                              Report.reportNumber=contrller.listReport[index]['رقم البلاغ'];
                              //print(contrller.listReport[index]["tracking"].length);
                              Get.to(()=>DetailsTicketScreen(color:  statusReport[Controllert.colorState("${contrller.listReport[index]['الحالة']}")]['name'][1],));
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
                                                color: statusReport[Controllert.colorState("${contrller.listReport[index]['الحالة']}")]['name'][1],
                                                /*contrller.listReport[index]['الحالة']
                                                !=
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
                                                              '${contrller.listReport[index]['رقم البلاغ']}',
                                                              style: TextStyle(
                                                                  color: mainColor,
                                                                  height: 1.5),
                                                            ),
                                                          ],
                                                        )),
                                                    Expanded(
                                                        child: Text(
                                                            FirebaseController.formatTimestamp(contrller.listReport[index]["Time"]),
                                                          // '${intl.DateFormat.yMEd().add_jm().format(DateTime.now())}',//contrller.listReport[index]['Time']
                                                          style: TextStyle(
                                                              color: colorShadowSearch,fontSize: 10),
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
                                                              'الجهة: ',
                                                              style: TextStyle(
                                                                  color: mainColor,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize: 15.sp),
                                                            ),
                                                            Text(
                                                              '${contrller.listReport[index]['الجهة المستفيدة']}',
                                                              style: TextStyle(
                                                                  color: mainColor,
                                                                  height: 1.5),
                                                            ),
                                                          ],
                                                        )),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 6.r,
                                                            backgroundColor:statusReport[Controllert.colorState("${contrller.listReport[index]['الحالة']}")]['name'][1],
                                                            /*contrller.listReport[
                                                            index]
                                                            [
                                                            'الحالة']
                                                             !=
                                                                statusReport[
                                                                index]['name']
                                                                ? statusReport[index]
                                                            ['name'][1]
                                                                : Colors.green,*/
                                                          ),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          Text(
                                                           '${contrller.listReport[index]['الحالة']}',
                                                            style: TextStyle(
                                                              color: statusReport[Controllert.colorState("${contrller.listReport[index]['الحالة']}")]['name'][1],
                                                              /*contrller.listReport[index]
                                                              ['الحالة'] !=
                                                                  statusReport[index]['name']
                                                                  ? statusReport[index]['name'][1]
                                                                  : Colors.green,*/
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
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
                                                                '${contrller.listReport[index]['المقر']}',
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
                                                                '${contrller.listReport[index]['الاسم']}',
                                                                style: TextStyle(
                                                                    color: mainColor,
                                                                    height: 1.5),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    contrller.listReport[index]['الحالة'] == "مغلقة"
                                                        ?Expanded(
                                                      child: (contrller.listReport[index]['القسم']=="")?GestureDetector(
                                                        onTap: () {
                                                        //  print(contrller.listReport[index].id);
                                                          Get.to(()=>RatingScreen(id:contrller.listReport[index].id));
                                                        },
                                                        child: Container(
                                                          alignment:
                                                          AlignmentDirectional
                                                              .center,
                                                          width: 115.w,
                                                          height: 27.h,
                                                          decoration: BoxDecoration(
                                                              color: mainColor,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  50.r)),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Icon(Icons.star,color: Colors.white,),
                                                              Text(
                                                                'تقييم الخدمة',
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontWeight:
                                                                    FontWeight.bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ):SizedBox(),
                                                    )
                                                        :SizedBox()
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
                          );
                        },
                      );
                    }
                  }
                ),
              )
            ],
          ),
        ));
  }
}

// [] test['value'],
// 'name' String

