import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roofa/const/const_color.dart';
import 'package:roofa/customer/home_page/view/home_screen.dart';

import '../../details_problem/view/details_problem_screen.dart';
import '../controller/send_report_controller.dart';

class SendReportScreen extends StatelessWidget {
  final contrller = Get.put(SendReportController());
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("تسجيل بلاغ جديد "),
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
                    itemCount: sendReport.length,
                    itemBuilder: (context, index) {
                      List c = sendReport[index]['type_sort_name']
                      ['type_sort_value'];
                      return GetBuilder<SendReportController>(
                        builder: (_) {
                          return ExpansionTile(
                              textColor: mainColor,
                              collapsedTextColor: mainColor,
                              key: GlobalKey(),
                              title: Text(
                                contrller.getVal("${sendReport[index]['type_sort_name']['name']}")==""?'${sendReport[index]['type_sort_name']['name']}':
                                '${sendReport[index]['type_sort_name']['name']}'+' : '+'${contrller.getVal("${sendReport[index]['type_sort_name']['name']}")}',
                                style:
                                TextStyle(fontWeight: FontWeight.bold),
                              ),
                              children: c
                                  .map((e) => ListTile(
                                textColor: mainColor,
                                onTap: () {
                                  print(e);
                                  contrller.setVal("${sendReport[index]['type_sort_name']['name']}", e);
                                  contrller.update();
                                },
                                title: Text(e.toString()),
                              ))
                                  .toList());
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(),
                  )),
        Container(
          decoration:
          BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: colorShadowSearch.withOpacity(.56),
                blurRadius: 10,
                offset: Offset(0, 8))
          ]),
          child: ExpansionTile(
              textColor: mainColor,
              collapsedTextColor: mainColor,
              key: GlobalKey(),
              title: Text(
                'رقم الغرفة',
                style:
                TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                TextFormField(
                  style: TextStyle(
                    color: mainColor
                  ),
                 onChanged: (val){contrller.value.roomNumber=val;},
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(

                    contentPadding: EdgeInsets.only(
                      right: 15.w
                    ),
                    border: InputBorder.none,
                    hintText: 'اكتب رقم الغرفة هنا',
                  ),
                )
              ]),
        ),
              SizedBox(height: 50.h,),
              GestureDetector(
                onTap: (){
                  if(contrller.check())
                  Get.off(DetalisProblemScreen(contrller.value.floor,contrller.value.building,contrller.value.headquarters,contrller.value.beneficiary,contrller.value.roomNumber,contrller.value.roomType));
                  else
                    Get.snackbar("Error", "complete details",backgroundColor: Colors.red,colorText: Colors.white);
                  //Get.toNamed('/details_problem_screen');
                },
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  margin: EdgeInsets.symmetric(
                  ),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(50.r),
                    boxShadow: [
                      BoxShadow(
                        color: colorShadowSearch.withOpacity(.56),
                        blurRadius: 10,
                        offset: Offset(0,9)
                      )
                    ]
                  ),
                  child: Text('الإنتقال لتفاصيل المشكلة',style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp
                  ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Map<dynamic, dynamic>> sendReport = [
  {
    'type_sort_name': {
      'name': 'الجهة المستفيدة',
      'type_sort_value': [
        'ادارة العلاقات العامة',
        'الادارة العامه للمشاريع',
        'ادارة التخطيط والميزانية',
        'ادارة المرافق والخدمات',
        'الادارة المالية',
        'ادارة المشتريات والمناقصات',
        'ادارة الاسكان',
        'ادارة المستودعات',
        'ادارة سجلات الجامعة',
        'ادارة التكاليف',
        'ادارة الاراضي والممتلكات',
        'ادارة الامن الجامعي',
        'مكتب ادارة الملكيه الفكرية',
        'ادارة البعثات',
        'الادارة العامة للإتصال المؤسسي',
        'ادارة المراجعه الداخليه',
        'الادارة القانونية',
        'ادارة كفاءة الطاقة',
        'ادارة الجمعيات العلمية',
        'ادارة السلامة',
        'ادارة الاستثمار',
        'الادارة العامه للتحويل الرقمي'
      ]
    },
  },
  {
    'type_sort_name': {
      'name': 'المقر',
      'type_sort_value': [
        'العابدية -طلاب',
        'الزاهر -طالبات',
        'العابدية  طالبات',
        'الكلية الجامعية -العزيزية',
        'مقر الطالبات بالعزيزية',
        'مقر الطالبات بريع ذاخر',
        'الكلية الجامعية بالقنفذة -طلاب',
        'الكلية الجامعية بالقنفذة -طالبات',
        'الكلية الجامعية بالليث -طلاب',
        'الكلية الجامعية بالليث -طالبات',
        'الصحة العامة والمعلوماتية الصحية',
        'الصحية طالبات مكة',
        'السنة التاهيلية -الششة طالبات',
        'طلاب بريدة',
        'طالبات بريدة',
        'السنة التحضيرية طالبات -الششة',
        'الهندسة بالقنفذة -طلاب',
        'الهندسة بالليث -طلاب',
        'الحاسب الالي بالليث-طلاب',
        'الحاسب الالي بالقنفذة -طلاب',
        'الكلية الصحية بالليث-طلاب',
        'الكلية الصحية بالليث -طالبات',
        'الكلية الجامعية -الجموم طلاب',
        'جموم -طلاب',
        'جموم-طالبات',
        'القنفذة -طلاب',
        'القنفذة -طالبات',
        'العزيزية -طالبات',
        'الصحية طلاب بالقنفذة',
        'كلية الطب بالقنفذة',
        'كلية الحاسب الالي -قنفذة-طالبات',

      ]
    },
  },
  {
    'type_sort_name': {
      'name': 'المبنى',
      'type_sort_value': [
        'ا',
        'و',
        'ي',
        'ح',
        'ب',
      ]
    },
  },
  {
    'type_sort_name': {
      'name': 'الطابق',
      'type_sort_value': [
        'الدور الارضي',
        'الدور الاول',
        'الدور الثاني',
        'الدور الثالث',
        'الدور الرابع',
      ]
    },
  },
  {
    'type_sort_name': {
      'name': 'نوع الغرفة',
      'type_sort_value': [
        'معمل حاسب الي',
        'معمل -مختبر',
        'فصل دراسي',
        'مدرج',
        'مسرح',
      ]
    },
  },
];