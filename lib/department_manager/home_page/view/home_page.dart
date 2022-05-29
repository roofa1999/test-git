import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roofa/const/const_color.dart';
import 'package:roofa/department_manager/home_page/controller/home_page_controller.dart';
import 'package:roofa/setting/view/setting_screen.dart';
import 'package:roofa/user_profile/view/user_profile_screen.dart';
import 'package:roofa/widgets/home_screen_actions.dart';
import 'package:roofa/const/text_app.dart';

import '../../../user_profile/view/user_profile_screen.dart';

class HomeScreenDM extends StatefulWidget {
  @override
  State<HomeScreenDM> createState() => _HomeScreenDMState();
}

class _HomeScreenDMState extends State<HomeScreenDM> {
//كلاس في فلاتر الواجهة فيه جامدة لا تتحدث البانات
  final controller = Get.put(HomePageDMController());
// كونترولر لفصل البيانات عن الواجهة أضع فيه التوابع والمتغيرات وهو من الستيت مانجمنت getx
  @override
  Widget build(BuildContext context) {//تابع بناء كل واجهة واسمه ال build من هنا يبدأ رسم كل واجهة
    return FutureBuilder(
        future: controller.fetchNotification(),
    builder: (context,snapShot){
    if(!snapShot.hasData){
    return Center(child: CircularProgressIndicator());
    }else{
      return Directionality( // من أجل ظهور التنسيق باللغة العربية (من اليمين لليسار)
        textDirection: TextDirection.rtl,
        child: Scaffold(// هنا أبدا بالرسم في الواجهة مثل الحاضنة للصفحة وما بداخلها
          appBar: AppBar(
            title: Text(
              'الصفحة الرئيسية',
              style: TextStyle(),
            ),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Get.to(()=>SettingScreen());
                setState(() {
                  //controller.fetchNotification();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  'images/settings.svg',
                  width: 23.w,
                  height: 23.h,
                ),
              ),
            ),
            actions: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.dialog(ListView.builder(
                          itemCount: controller.notification.length,//allreports.length,
                          itemBuilder: (ctx, index){
                            return (controller.notification[index].number>0)?GestureDetector(
                                child:  Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10.0),
                                      margin:
                                      EdgeInsets.only(top: 10.h, right: 12.w, left: 12.w),
                                      width: Get.width,
                                      height: 90.h,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12.r)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Material(
                                                color: Colors.transparent,
                                                child: Text(
                                                  controller.notification[index].toString(),
                                                  //'يوجد لديك  5 بلاغات تم تغير حالتها',
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(
                                                      fontSize: 17.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: mainColor),
                                                ),
                                              )),
                                          Container(
                                            margin: EdgeInsets.only(left: 5.w),
                                            width: .5,
                                            color: Colors.black.withOpacity(.5),
                                          ),
                                          Expanded(child: SvgPicture.asset(
                                            'images/logo.svg',
                                            fit: BoxFit.cover,
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                            ):
                            SizedBox();
                          }
                      ),

                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        'images/notifications.svg',
                        width: 23.w,
                        height: 23.h,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 2,
                    top: 2,
                    child: CircleAvatar(
                      radius: 10.r,
                      backgroundColor: Colors.red,
                      child: Text(
                        "${controller.numberNotification}",
                        //'4',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:  Colors.white
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),

          body:FutureBuilder( // هذا لجلب البيانات من الفاير بيز مستر أحمد بيشرح عنه أكثر بس يخلص لكم
              future: controller.fetchDataProfile(),
              builder: (context,snapShot){
                if(!snapShot.hasData){//اذا الداتا لسى ما اجت من الفاير بيز
                  // اعرض لي الدائرة اللي تخبرني انو في شيء قاعد يحمل
                  return Center(child: CircularProgressIndicator());
                  //هون يعني البيانات أجت
                }else{
                  return Column(
                    //اعرضي column
                    children: [
                      Container(
                        width: double.infinity,
                        height: 133.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(//من أجل الظل اللي بين على حواف الشيء
                                color: Color(0xffA2A2A2).withOpacity(.16),
                                offset: Offset(0, 9),
                                blurRadius: 10)
                          ],
                        ),
                        child: ListView(// هاي مثل الكولوم والرو ولكن ايش زيادة تيجي بسكرول جاهز ما تحتاج أحط لها سكرول
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(()=>UserProfileScreen());
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child:GestureDetector(
                                    onTap: () {
                                      Get.to(()=>UserProfileScreen());
                                    },
                                    child:SvgPicture.asset(
                                      'images/user-circle.svg',
                                    ),
                                  )
                              ),
                            ),
                            Text(
                              controller.name,
                              // 'سلطان الحربي',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff447A78)),
                            ),
                            Text(
                              controller.typeUser,
                              // 'رئيس قسم',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff447A78)),
                            ),
                          ],
                        ),
                      ),

                      SizedBox( // هذه ويدجت تخليني أقدر احط مسافة اما بشكل عمودي او بشكل أفقي
                        height: 70.h,
                      ),
                      Expanded(
                        child: GridViewHomeActionScreen(
                          // ويدجت أنا عاملها ترجع لي المربعات اللي في الصفحة الرئيسية وتاخذ شغلتين
                          map: homeScreenGridViewDepartmentManagerText, // ليست من الصور والكتابات والصفحات التي سأنتقل لها
                          numAction: 3, // عدد المربعات التي ستعرض في السطر مثلا 3 سيعرض 3  في السطر الواحد ويكمل وهكذا
                        ),
                      ),
                    ],
                  );
                }
              }
          ),

        ),
      );
    }});

    }
}

