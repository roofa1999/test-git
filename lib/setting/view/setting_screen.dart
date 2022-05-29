import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:roofa/const/const_color.dart';
import 'package:roofa/language/view/language_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../sign_in/view/sign_in_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("الإعدادات"),
          centerTitle: true,
          leading: IconButton(
            onPressed: (){
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildItem(
                  title: "الخصوصية والسياسة",
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_){
                          return Material(
                            color: Colors.transparent,
                            child: Container(
                              margin: EdgeInsets.all(20.0),
                              padding: EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ListView(
                                children: [
                                  Text(privacy,

                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                    fontSize: 15.sp,
                                      height: 2
                                  ),)
                                ],
                              ),
                            ),
                          );
                        }
                    );
                  },
                ),
                Divider(thickness: 0.5),

                _buildItem(
                  title: "من نحن",
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_){
                          return Material(
                            color: Colors.transparent,
                            child: Center(
                              child: Container(
                                height: Get.height * 0.7,
                                margin: EdgeInsets.all(20.0),
                                padding: EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: ListView(
                                  children: [
                                    SvgPicture.asset('images/logo.svg'),
                                    Text('هو تطبيق لخدمات الصيانه'
                                        ' داخل مرافق الجامعه ويهدف تطبيق '
                                        'صون الى توفير وصول اسرع واسهل للمستخدمين '
                                        '، نسعى الى رفع مستوى الخدمات المقدمة بشكل مستمر',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                        fontSize: 16.sp
                                    ),),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    Text(":للتواصل معنا على البريد الالكتروني",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp
                                    ),),

                                    GestureDetector(
                                      onTap: () async {

                                        String email = 'soonapp00@gmail.com';
                                        String subject = '';
                                        String body = '';

                                        String emailUrl = "mailto:$email?subject=$subject&body=$body";
                                        Get.back();

                                        if (await canLaunch(emailUrl)) {

                                          await launch(emailUrl).then((value){
                                            print('HHHHHHHHHHH');
                                          });
                                          Get.snackbar('تم العملية', "تم ارسال رسالتكم شكرا...");

                                        } else {
                                          throw "Error occured sending an email";
                                        }

                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          color: mainColor,
                                          borderRadius: BorderRadius.circular(8.0)
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(
                                              Icons.email_outlined,
                                              color: Colors.white,
                                            ),
                                            Text('soonapp00@gmail.com',style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.sp
                                            ),),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    );
                  },
                ),
                _buildItem(
                  title: "تسجيل الخرروج",
                  onTap: () {
                    Get.off(()=> SignInScreen());
                  },
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _buildItem extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const _buildItem({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF447A78),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF447A78),
            ),
          ],
        ),
      ),
    );
  }
}
const String privacy =
"في تطبيق (صون)، ندرك أن خصوصية معلوماتك الشخصية هامة لك ولنا."

"فيما يلي معلومات حول أنواع المعلومات الشخصية التي نتلقاها ونقوم بجمعها عند زيارات (صون)، وكيف نقوم بحماية معلوماتك الشخصية."

"ملفات السجل"
"كما هو الحال مع معظم مواقع الويب المختلفة، نقوم بجمع واستخدام البيانات الموجودة في ملفات السجل."

"تشمل المعلومات الموجودة في ملفات السجل عنوان بروتوكول الإنترنت (IP)"
"الخاص بك، ومزود خدمة الإنترنت (ISP)، والمتصفح الذي استخدمته لزيارة تطبيقنا، والوقت الذي قمت فيه بالزيارة،"
"والصفحات التي قمت بزيارتها عبر تطبيقنا."

"ملفات تعريف الارتباط"
"نحن نستخدم ملفات تعريف الارتباط لنمنحك أفضل تجربة أستخدام ممكنة على موقع بسيط"
"، لمزيد من المعلومات حول ملفات تعريف الارتباط ، تفضل بزيارة: http://www.allaboutcookies.org/."

"ملفات تعريف الارتباط الأساسية"
"تعد ملفات تعريف الارتباط الأساسية ضرورية لك للتنقل والتنقل في جميع أنحاء الموقع، ولا تخزن"
"أي معلومات يمكن استخدامها لأغراض الدعاية، بدون ملفات تعريف الارتباط الأساسية، لن يعمل تطبيقنا بشكل صحيح."
"ملفات تعريف الارتباط المخصصة"
"تخزن ملفات تعريف الارتباط هذه المعلومات ، مثل تفضيلاتك الشخصية ، وتستخدمها لتخصيص تجربة فريدة لك."

"قد يشمل ذلك عرض نافذة منبثقة مرة واحدة فقط في زيارتك ، أو حفظ تفضيلات اللغة الخاصة بك ، أو السماح لك بتسجيل الدخول تلقائيًا إلى بعض ميزاتنا."
"ملفات تعريف الارتباط في Analytics"
"تلتقط ملفات تعريف الارتباط من Analytics بيانات مجهولة المصدر حتى نتمكن من رؤية الاتجاهات وتحسين تجربة تطبيقنا على الويب."
"هذه تتيح لنا اختبار تصميمات مختلفة ، وتساعدنا على تحديد الكسر إذا كان جزء من تطبيقنا لا يعمل."
"ملفات تعريف الارتباط للإعلانات"
"قد يستخدم بعض المعلنين من الجهات الخارجية ملفات تعريف الارتباط أو إشارات الويب عند الإعلان على تطبيقنا."
"سيقوم هؤلاء بإرسال معلومات إلى هؤلاء المعلنين (مثل Google من خلال برنامج Google AdSense) بما في ذلك عنوان"
"IP الخاص بك ، ومزود خدمة الإنترنت ، والمتصفح الذي استخدمته لزيارة تطبيقنا ، وفي بعض الحالات معلومات حول ما إذا كنت قد قمت بتثبيت Flash."

"يستخدم موردو الجهات الخارجية، بمن فيهم Google، ملفات تعريف ارتباط لعرض الإعلانات بناءً"
"على زيارات المستخدم السابقة لتطبيقنا الإلكتروني أو لمواقع أخرى على الويب."
"ستتمكّن Google وشركاؤها، باستخدام ملفات تعريف "
"الارتباط للإعلانات، من عرض الإعلانات للمستخدمين لديك استنادًا إلى زياراتهم لتطبيقنا و/أو مواقع أخرى عبر الإنترنت."
"يمكن للمستخدمين تعطيل استخدام الإعلانات المخصصة عن طريق الانتقال إلى إعدادات الإعلانات."
"إذا لم يتم اختيار تعطيل عرض إعلانات الأطراف الثالثة، فقد يتم استخدام ملفات"
"تعريف ارتباط موردي أو شبكات إعلانات الأطراف الثالثة الأخرى أيضًا لعرض الإعلانات في تطبيقنا."

"يستخدم هذا بشكل عام لأغراض الاستهداف الجغرافي على سبيل المثال  أو عرض إعلانات معينة بناءً على مواقع محددة تمت زيارتها (مثل عرض إعلانات العقارات لشخص يرتاد مواقع العقارات)."
"من خلال الاستمرار في استخدام تطبيقنا ، فإنك توافق على وضع ملفات تعريف الارتباط على جهازك."

"يمكنك اختيار تعطيل أو إيقاف تشغيل ملفات تعريف الارتباط أو ملفات تعريف ارتباط الطرف الثالث بشكل انتقائي في إعدادات المتصفح الخاص بك."
"ومع ذلك ، يمكن أن يؤثر هذا على كيفية تفاعلك مع تطبيقنا وكذلك مع مواقع الويب الأخرى";