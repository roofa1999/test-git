import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roofa/const/const_color.dart';
import 'package:roofa/customer/send_report/controller/send_report_controller.dart';
import 'package:roofa/widgets/custom_dialog.dart';
import 'package:roofa/widgets/material_text.dart';
import 'package:roofa/const/text_app.dart';

import '../../../const/picker.dart';
import '../../home_page/view/home_screen.dart';
import '../controller/details_problem_controller.dart';

class DetalisProblemScreen extends StatelessWidget {
  final controller = Get.put(DetailsProblemController());
  DetalisProblemScreen(String roomType,String roomNumber,String beneficiary,String headquarters,String building,String floor){
    controller.sendReportVal.roomType=roomType;
    controller.sendReportVal.roomNumber=roomNumber;
    controller.sendReportVal.beneficiary=beneficiary;
    controller.sendReportVal.headquarters=headquarters;
    controller.sendReportVal.building=building;
    controller.sendReportVal.floor=floor;
   // controller.sendReportVal=sendReportVal;
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("تفاصيل المشكلة "),
          centerTitle: true,
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  decoration:
                  BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: colorShadowSearch.withOpacity(.56),
                        blurRadius: 10,
                        offset: Offset(0, 4))
                  ]),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: detailsProblemList.length,
                    itemBuilder: (context, index) {
                      List c = detailsProblemList[index]['type_sort_name']
                      ['type_sort_value'];
                      return GetBuilder<DetailsProblemController>(
                        builder: (_) {
                          return ExpansionTile(
                              textColor: mainColor,
                              collapsedTextColor: mainColor,
                              key: GlobalKey(),
                              title: Text(
                                controller.getVal("${detailsProblemList[index]['type_sort_name']['name']}")==""?'${detailsProblemList[index]['type_sort_name']['name']}':
                                '${detailsProblemList[index]['type_sort_name']['name']}'+' : '+'${controller.getVal("${detailsProblemList[index]['type_sort_name']['name']}")}',
                                //'${detailsProblemList[index]['type_sort_name']['name']}',
                                style:
                                TextStyle(fontWeight: FontWeight.bold),
                              ),
                              children: c
                                  .map((e) => ListTile(
                                textColor: mainColor,
                                onTap: () {
                                  print(e);
                                  controller.setVal("${detailsProblemList[index]['type_sort_name']['name']}", e);
                                  controller.update();
                                },
                                title: Text(e.toString()),
                              ))
                                  .toList());
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(),
                  )),
              SizedBox(height: 50.h,),
              Center(
                child: Container(
                  padding: EdgeInsets.all(15.r),
                  width: Get.width,
                  height: Get.height / 1.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(
                        15.r),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h,),
                      Expanded(
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
                                             controller.textReply.clear();
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
                                      maxLines: 3,
                                      textDirection:
                                      TextDirection
                                          .rtl,
                                      onChanged: (val){controller.setVal("الوصف", val);},
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
                      SizedBox(height: 40.h,),
                      GestureDetector(
                        onTap: () async {
                          if(controller.check()){
                            (
                                await controller.sendReport()
                            )?
                            //Get.toNamed('/rating_screen'):"";
                            Get.off(()=>HomeScreen()):print("حاول مجددا");
                          }
                          else
                            Get.snackbar("Error", "complete details",backgroundColor: Colors.red,colorText: Colors.white);

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
                      )
                    ],
                  ),
                )
              ),
            ],
          ),
        ),

      ),
    );
  }
}
