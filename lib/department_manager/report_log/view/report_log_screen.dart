import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roofa/department_manager/report_log/controller/report_log_controller.dart';

import '../../../const/const_color.dart';
import '../../../const/text_app.dart';
import '../../home_page/view/home_page.dart';
import 'package:intl/intl.dart' as intl;

class ReportLogDMScreen extends StatelessWidget {
  final controller = Get.put(ReportLogDMController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("سجل البلاغ"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.off(() => HomeScreenDM());
                },
                icon: Icon(
                  Icons.home,
                  size: 30.r,
                ))
          ],
        ),
        body: Column( // عناصر تحت بعضها بشكل عمودي
          children: [
            Obx( // من الستست مانجمنت لتغير الصفحة في هذه المكان فقط مو بكامل الشاشة
                    ()=>Row( // عناصر بجانب بعضها
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded( // من أجل تساوي المسافة ولا توضع الا في داخل column  او  row
                      flex: 5,
                      child: Container( // هنا يوجد لدينا زرين وعند الكبس عليهما اتنقل بين الصفحتين تم شرحها في السكرين قبل تبع ال pageView  والصفحتين التي اتنقل بينهما بالسحب يمين ويسار نفس الفكرة
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
                            // هذه اول زر
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
                                      'سجل التقارير',
                                      style: TextStyle(
                                        color: controller.index.value == 0
                                            ? controller.textButtonActive
                                            : mainColor,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 800),
                                  ),
                                )),
                            //هذه ثاني زر وتم شرحهم قبل
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
                                      'سجل التركيبات والتبديلات',
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
                )
            ),
            Expanded(
              child: PageView(
                // هذه ال page View نفس الفكرة تم شرحها مسبقا تاخذ عنصرين هما عبارة عن شاشنتين يتم التقل بينهما عن طريق السحب يمين ويسار او الكبس على الازرار فوق
                controller: controller.controllerPageView,
                onPageChanged: (val){
                  controller.index.value = val;
                },
                children: [
                  ReportLogDM(),
                  ChangesAndCombinations()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReportLogDM extends StatelessWidget {
  const ReportLogDM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // ليست لعرض معلومات التذكرة تم شرحهل مسبقا
      itemCount: allTicketReportsLogDM.length,
      itemBuilder: (_,index)=>Column(
        children: [
          Container(
            margin: EdgeInsets.all(8.r),
            width: Get.width,
            height: Get.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                      color: colorShadowSearch.withOpacity(.24),
                      offset: Offset(0, 4),
                      blurRadius: 10)
                ]),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: allreports[index]['report_status']
                        [0] !=
                            statusReport[index]['name']
                            ? statusReport[index]['name'][1]
                            : Colors.green,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.r),
                          bottomRight: Radius.circular(15.r),
                        )
                    ),
                  ),
                ),
                Expanded(
                    flex: 18,
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Row(
                                  children: [
                                    Text('اسم الجهاز : ',style:
                                    TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp
                                    ),),
                                    Text('${
                                        allTicketReportsLogDM[index]
                                        ['device_name']
                                    }',style: TextStyle(
                                      color: mainColor,
                                    ),),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    IconButton(onPressed: (){}
                                        , icon: Icon(Icons.image,color: colorShadowSearch,))
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text('نوع الجهاز : ',style:
                              TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp
                              ),),
                              Text('${
                                  allTicketReportsLogDM[index]
                                  ['device_type']
                              }',style: TextStyle(
                                color: mainColor,
                              ),),
                            ],
                          ),
                          Row(
                            children: [
                              Text('الرقم التسلسلي للجهاز : ',style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp
                              ),),
                              Text(
                                '${allTicketReportsLogDM[index]
                                ['device_serial_number']}',
                                style: TextStyle(
                                  color: mainColor,
                                ),)
                            ],
                          ),

                          Row(
                            children: [
                              Text('التاريخ : ',style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp
                              ),),
                              Text(
                                '${intl.DateFormat
                                    .yMEd()
                                    .add_jm()
                                    .format(
                                    allTicketReportsLogDM[index]
                                    ['report_date_time'])}',
                                style: TextStyle(
                                  color: mainColor,
                                ),)
                            ],
                          ),

                          Row(
                            children: [
                              Text(
                                'الوصف : ',
                                style: TextStyle(
                                    color: mainColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold
                                ),)
                            ],
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: Get.width*0.2,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.h
                              ),
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                color: colorShadowSearch
                                    .withOpacity(.2),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Text(
                                '${
                                    allTicketReportsLogDM[index]['report_description']
                                }',
                                style: TextStyle(
                                    color: mainColor,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
class ChangesAndCombinations extends StatelessWidget {
  const ChangesAndCombinations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // هنا ليست أيضا لعرض معلومات التذكرة الشرح واضح مسبقا فقط جلب نصوص من قاعدة البيانات وعرضها هنا
      itemCount: allTicketChangesAndCombinationsLogDM.length,
      itemBuilder: (_,index)=>Column(
        children: [
          Container(
            margin: EdgeInsets.all(8.r),
            width: Get.width,
            height: Get.width * 0.7,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                      color: colorShadowSearch.withOpacity(.24),
                      offset: Offset(0, 4),
                      blurRadius: 10)
                ]),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: allreports[index]['report_status']
                        [0] !=
                            statusReport[index]['name']
                            ? statusReport[index]['name'][1]
                            : Colors.green,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.r),
                          bottomRight: Radius.circular(15.r),
                        )
                    ),
                  ),
                ),
                Expanded(
                    flex: 18,
                    child: Container(
                      padding: EdgeInsets.all(10.r),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Row(
                                  children: [
                                    Text('نوع الحركة : ',style:
                                    TextStyle(
                                        color: mainColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp
                                    ),),
                                    Text('${
                                        allTicketChangesAndCombinationsLogDM[index]
                                        ['report_title']
                                    }',style: TextStyle(
                                      color: mainColor,
                                    ),),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    IconButton(onPressed: (){}
                                        , icon: Icon(Icons.image,color: colorShadowSearch,))
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text('التاريخ : ',style: TextStyle(
                                  color: mainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp
                              ),),
                              Text(
                                '${intl.DateFormat
                                    .yMEd()
                                    .add_jm()
                                    .format(
                                    allTicketChangesAndCombinationsLogDM[index]
                                    ['report_date_time'])}',
                                style: TextStyle(
                                  color: mainColor,
                                ),)
                            ],
                          ),

                          Row(
                            children: [
                              Text(
                                'الوصف : ',
                                style: TextStyle(
                                    color: mainColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold
                                ),)
                            ],
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              height: Get.width*0.2,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.h
                              ),
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                color: colorShadowSearch
                                    .withOpacity(.2),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Text(
                                '${
                                    allTicketReportsLogDM[index]['report_description']
                                }',
                                style: TextStyle(
                                    color: mainColor,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
