import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:roofa/const/const_color.dart';

import '../../../const/text_app.dart';
import '../../home_page/view/home_page.dart';
import 'package:intl/intl.dart' as intl;

class ShowTicketReportDMScreen extends StatelessWidget {
  const ShowTicketReportDMScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("عرض التقارير"),
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
        body: Column(
          // عدة عناصر تحت بعضها بشكل عمودي
          children: [
            Container( // هنا حافظة بداخلها ايقونة تحميل بصيغة svg  من أجل الدقة العالية
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(8.r),
              height: Get.width * 0.15,
              child: GestureDetector(
                onTap: () {},
                child: SvgPicture.asset('images/download.svg'),
              ),
            ),
            Expanded(
                child: ListView.builder(
                  // بعدين هنا ليست فيها معلومات التقارير فقط نجلبها من الداتا بيز ونعرضها هنا بالالية التي شرحتها سابقا شكل التذكرة اللي فيها خط من اليسار وبداخلها المعلومات بداخل row وبداخل كل row  نصين الاسم والقيمة مثلا (المقر : العابدية طالبات وهكذا )
                  itemCount: allTicketReportsDM.length,
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
                                          Text('رقم التذكرة : ',style:
                                          TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp
                                          ),),
                                          Text('${
                                          allTicketReportsDM[index]['report_num']
                                          }',style: TextStyle(
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
                                            // هنا لتنسيق التاريخ بالشكل المطلوب يوم سهر سنة
                                              '${intl.DateFormat
                                                  .yMEd()
                                                  .add_jm()
                                                  .format(
                                                  allreportsDM[index]
                                                  ['report_date_time'])}',
                                          style: TextStyle(
                                            color: mainColor,
                                          ),)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('نوع الحركة : ',style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                              fontSize: 14.sp
                                          ),),
                                          Text(
                                              '${ allreportsDM[index]
                                              ['report_title']}',
                                          style: TextStyle(
                                            color: mainColor,
                                          ),)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('الحالة : ',style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                              fontSize: 14.sp
                                          ),),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 5.r,
                                                backgroundColor: allreports[index]['report_status']
                                                [0] !=
                                                    statusReport[index]['name']
                                                    ? statusReport[index]['name'][1]
                                                    : Colors.green,
                                              ),
                                              SizedBox(width: 5.w,),
                                              Text(
                                                '${ allreportsDM[index]
                                                ['report_status']}',
                                                style: TextStyle(
                                                  color: statusReport[index]['name'][1],
                                                ),)
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('الحالة : ',style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                              fontSize: 14.sp
                                          ),),
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
                                      Container(
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
                                              allTicketReportsDM[index]['report_description']
                                          }',
                                          style: TextStyle(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text('مدخل التقرير : ',style: TextStyle(
                                              color: mainColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp
                                          ),),
                                          Text(
                                            '${ allreportsDM[index]
                                            ['reporter_name']}',
                                            style: TextStyle(
                                              color: mainColor,
                                            ),)
                                        ],
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
                ))
          ],
        ),
      ),
    );
  }
}
