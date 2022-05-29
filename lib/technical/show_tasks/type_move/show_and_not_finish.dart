import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intl;
import '../../../const/text_app.dart';

import '../../../const/const_color.dart';

class ShowAndNotFinish extends StatelessWidget {
  final controller = Get.put(ShowAndNotFinishController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              'معاينة'
          ),
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
                                    duration: Duration(milliseconds: 800),
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
                                  'تعبئة التقرير',
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
                                  'عرض التقرير',
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
              ],
            )),
            Expanded(
              child: PageView(
                controller: controller.controllerPageView,
                onPageChanged: (index){
                  controller.index.value = index;
                },
                children: [
                  ListView(
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
                          // controller: ticketNum,
                          decoration: InputDecoration(
                              fillColor: Color(0xffF3F3F3),
                              filled: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: '[7AEE00CVF]'
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
                            // if(val == 'إحالة لقسم الصيانة'||val == 'تم الإنجاز'){
                            //   controller.onClickButton(1);
                            //   controller.controllerPageView!.animateToPage(1,
                            //       duration: Duration(milliseconds: 800),
                            //       curve: Curves.decelerate);
                            //   ///لازم تبعث الداتا هنا عشان نفس بعض بس يختلف اللون
                            // }
                            if(val == 'معاينة'||val == 'لم يتم الإنجاز'){
                              controller.controllerPageView!
                                  .animateToPage(1,
                                  duration: Duration(milliseconds: 800),
                                  curve: Curves.decelerate);
                            }
                            // if(val == 'إضافة تركيبات وتبديلات'){
                            //   print('Yees');print('tarkeb');
                            //   Get.to(()=>AddChangesTReport());
                            // }
                            // if(val == 'ازالة /فك'){
                            //   print('ezala');
                            //   Get.to(()=>RemoveTReport());
                            // }
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
                                      final DateTime? date = await showDatePicker(
                                          context: context,
                                          initialDate: controller.expectedTime.value,
                                          firstDate: DateTime(1990),
                                          lastDate: DateTime(2030));
                                      if (date != null && date != controller.expectedTime.value){
                                        controller.expectedTime.value = date;
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
                                              controller.expectedTime.value
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
                                      child: Obx(()=>Row(
                                        children: [
                                          Expanded(child: GestureDetector(
                                            onTap: (){
                                              controller.changeDayTime(0);
                                            },
                                            child: AnimatedContainer(
                                              padding: EdgeInsets.all(8.r),
                                              alignment: Alignment.center,
                                              duration: Duration(milliseconds: 500),
                                              decoration: BoxDecoration(
                                                  color: controller.dayTime==0
                                                      ?mainColor:Colors.transparent,
                                                  borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(8.r),
                                                    bottomRight: Radius.circular(8.r),
                                                  )
                                              ),
                                              child: Text('PM',style: TextStyle(
                                                  color: controller.dayTime==0
                                                      ?Colors.white:mainColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.sp
                                              ),),
                                            ),
                                          )),
                                          Expanded(child: GestureDetector(
                                            onTap: (){
                                              controller.changeDayTime(1);
                                            },
                                            child: AnimatedContainer(
                                              padding: EdgeInsets.all(8.r),
                                              alignment: Alignment.center,
                                              duration: Duration(milliseconds: 500),
                                              decoration: BoxDecoration(
                                                  color: controller.dayTime==1
                                                      ?mainColor:Colors.transparent,
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8.r),
                                                    bottomLeft: Radius.circular(8.r),
                                                  )
                                              ),
                                              child: Text('AM',style: TextStyle(
                                                  color: controller.dayTime==1
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
                                                      () {},
                                                  icon: Icon(Icons
                                                      .attach_file_outlined)),
                                              IconButton(
                                                  onPressed:
                                                      () {},
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
                  ),
                  Column(
                    children: [
                      Container(
                        height: Get.width * 0.7,
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
                                          color: Colors.orange,
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
                                                        backgroundColor: Colors.orange,
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Text(
                                                        '${ticketInformation['ticket_status']}',
                                                        style: TextStyle(
                                                          color: Colors.orange,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                'الوصف',
                                                style: TextStyle(
                                                    color: mainColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.sp),
                                              ),
                                              Container(
                                                height: Get.width * 0.25,
                                                alignment:
                                                AlignmentDirectional.center,
                                                padding: EdgeInsets.all(12.r),
                                                decoration: BoxDecoration(
                                                    color: Color(0xffF3F3F3),
                                                    borderRadius:
                                                    BorderRadius.circular(15.r)),
                                                child: Text(
                                                  'تم عمل المعاينة',
                                                  style: TextStyle(
                                                      color: mainColor, height: 1.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: Wrap(
                                                    children: [
                                                      Text(
                                                        'مدخل التقرير : ',
                                                        style: TextStyle(
                                                            color: mainColor,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 15.sp),
                                                      ),
                                                      Text(
                                                        'عبد الله الزهراني',
                                                        style: TextStyle(
                                                            color: mainColor,
                                                            height: 1.5),
                                                      ),
                                                    ],
                                                  )),
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

class ShowAndNotFinishController extends GetxController{
  var index = 0.obs;
  Color buttonActive = mainColor;
  Color textButtonActive = Colors.white;

  PageController? controllerPageView;

  @override
  void onInit() {
    controllerPageView = PageController(
        initialPage: 0
    );
    super.onInit();
  }
  void onClickButton(val){
    index.value = val;
    print(index);
  }

  var timeFrom = DateTime.now().obs;
  var timeTo = DateTime.now().obs;


  var technicalName = ''.obs;
  var  helperTechnical = ''.obs;

  var expectedTime = DateTime.now().obs;

  var dayTime = 0.obs;

  void changeDayTime(index){
    index == 0? dayTime.value =0:dayTime.value=1;
  }
}