import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:roofa/higher_management/homepage/view/home_screen.dart';

import '../../../Firebase/firebase.dart';
import '../../../const/const_color.dart';
import '../../../const/picker.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/material_text.dart';
import '../controller/complaintsandsuggestions_controller.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
final controller = Get.put(ComplaintsAndSuggestionsController());
class ComplaintsAndSuggestionsScreen extends StatelessWidget {
  const ComplaintsAndSuggestionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ComplaintsAndSuggestionsController());
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            title: Text("الشكاوي والاقتراحات "),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                )),
          actions: [
           IconButton(onPressed: (){
             Get.off(()=>HomeScreenHM());
           }, icon: Icon(Icons.home))
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 10.h,),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                        child: Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                controller.onClickButton(0);
                                controller.controllerPageView!.animateToPage(0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.decelerate);
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: controller.index.value == 0
                                        ? mainColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(50.r)),
                                child: Text(
                                  'شكوى',
                                  style: TextStyle(
                                    color: controller.index.value == 0
                                        ? controller.textButtonActive
                                        : mainColor,
                                  ),
                                ),
                                duration: Duration(milliseconds: 500),
                              ),
                            )),
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                controller.onClickButton(1);
                                controller.controllerPageView!.animateToPage(1,
                                    duration: Duration(milliseconds: 800),
                                    curve: Curves.decelerate);
                              },
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: controller.index.value == 1
                                        ? mainColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(50.r)),
                                child: Text(
                                  'اقتراحات',
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
                  ],
                )),
            SizedBox(height: 18.h,),
            Expanded(
              child: PageView(
                controller: controller.controllerPageView,
                onPageChanged: (val) {
                  controller.index.value = val;
                },
                children: [
                  ComplaintScreen(
                    listComplainta: [1, 2, 3, 4, 5],
                  ),
                  SuggestionsScreen(
                    listComplainta: [3, 4],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ComplaintScreen extends StatefulWidget {
  final List? listComplainta;


  const ComplaintScreen({Key? key, this.listComplainta}) : super(key: key);

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  @override
  Widget build(BuildContext context) {
    String? actionSend;
    Future<void> sendReply() async {
    actionSend=await controller.sendReply();
  }
    return FutureBuilder(
        future: controller.fetchDatacomplaints(),
    builder: (context,snapShot) {
    if (!snapShot.hasData) {
    return Center(child: CircularProgressIndicator());
    } else{
      return ListView.builder(
        padding: EdgeInsets.all(20.r),
        itemCount: controller.listReport.length,
        itemBuilder: (ctx, index) {
          return Container(
            padding: EdgeInsets.all(15.r),
            margin: EdgeInsets.symmetric(
                vertical: 10.r
            ),
            decoration: BoxDecoration(
                color: Color(0xffF3F3F3),
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xffCBC6C6).withOpacity(.3),
                      offset: Offset(0,9),
                      blurRadius: 10
                  )
                ]
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text('${FirebaseController.formatTimestamp(controller.listReport[index]["Time"])}'
                              //'${DateFormat.yMEd().add_jm().format(DateTime.now())}'
                                ' | ',style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.sp
                            ),),
                            Text('من قسم : الصيانة ',style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.sp
                            ),)
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        Text(controller.listReport[index]["الوصف"]//'التذاكر متأخرة'
                          ,style: TextStyle(
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.sp
                        ),)
                      ],
                    )),
                Expanded(
                    child: Column(
                      children: [
                        SvgPicture.asset('images/user-circle.svg'),
                        Text(
                            controller.listReport[index]["الاسم"],
                          //'أحمد بن عفيف',
                          style: TextStyle(
                              color: mainColor, fontWeight: FontWeight.bold),
                        ),
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
                                                               // controller.textReply.clear();

                                                              },
                                                          icon: Icon(
                                                              Icons
                                                                  .delete_forever_outlined)),
                                                      IconButton(
                                                          onPressed:
                                                              () { Picker.pickerFile();},
                                                          icon: Icon(
                                                              Icons
                                                                  .attach_file_outlined)),
                                                      IconButton(
                                                          onPressed:
                                                              () {Picker.showChoiceDialog(context);},
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
                                                    //controller: controller.textReply,
                                                    maxLines: 3,
                                                    //textDirection: TextDirection.rtl,
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
                                          //sendReply();
                                          Get.back();
                                          showCustomDialog(
                                            text: (actionSend!="")?actionSend:'تم إضافة رد على الشكوى',
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
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: mainColor),
                                borderRadius: BorderRadius.circular(50.r)),
                            child: Text(
                              'إضافة رد',
                              style: TextStyle(
                                  color: mainColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          );
        },
      );
    }});
    }
}
class SuggestionsScreen extends StatelessWidget {
  final List? listComplainta;

  const SuggestionsScreen({Key? key, this.listComplainta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.fetchDataSuggestions(),
    builder: (context,snapShot) {
    if (!snapShot.hasData) {
    return Center(child: CircularProgressIndicator());
    } else{
     return ListView.builder(
       padding: EdgeInsets.all(20.r),
       itemCount: controller.listReport.length,
       itemBuilder: (ctx, index) {
         return Container(
           padding: EdgeInsets.all(15.r),
           margin: EdgeInsets.symmetric(
               vertical: 10.r
           ),
           decoration: BoxDecoration(
               color: Color(0xffF3F3F3),
               borderRadius: BorderRadius.circular(15.r),
               boxShadow: [
                 BoxShadow(
                     color: Color(0xffCBC6C6).withOpacity(.3),
                     offset: Offset(0,9),
                     blurRadius: 10
                 )
               ]
           ),
           child: Row(
             children: [
               Expanded(
                   flex: 3,
                   child: Column(
                     children: [
                       Wrap(
                         crossAxisAlignment: WrapCrossAlignment.center,
                         children: [
                           Text('${
                   FirebaseController.formatTimestamp(controller.listReport[index]["Time"])
                              // DateFormat.yMEd().add_jm().format(DateTime.now())
                           } | ',style: TextStyle(
                               color: Colors.grey,
                               fontSize: 10.sp
                           ),),
                           Text('من قسم : الصيانة ',style: TextStyle(
                               color: Colors.grey,
                               fontSize: 10.sp
                           ),)
                         ],
                       ),
                       SizedBox(height: 20.h,),
                       Text(
                         controller.listReport[index]["الوصف"]
                         //'أقتراح'
                         , style: TextStyle(
                           color: mainColor,
                           fontWeight: FontWeight.bold,
                           fontSize: 25.sp
                       ),
                       ),
                     ],
                   )),
               Expanded(
                   child: Column(
                     children: [
                       SvgPicture.asset('images/user-circle.svg'),
                       Text(
                           controller.listReport[index]['الاسم'],
                         //'خالد المطيري',
                         style: TextStyle(
                             color: mainColor, fontWeight: FontWeight.bold),
                       ),
                     ],
                   )),
             ],
           ),
         );
       },
     );
    }});
  }
}
