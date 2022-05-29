import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roofa/const/const_color.dart';
import 'package:roofa/rating/controller/rating_controller.dart';
import 'package:roofa/widgets/custom_dialog.dart';
import 'package:roofa/widgets/material_text.dart';

class RatingScreen extends StatelessWidget {
  final controller = Get.put(RatingController());
  final String? id;
  RatingScreen({this.id});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("التقييم"),
          centerTitle: true,
        ),
        body: Obx(() => ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              children: [
                RatingSections(
                  name: 'هل تم حل المشكلة بسرعة عالية من قبل الفني؟',
                  valRate: controller.speedRate.value,
                ),
                SizedBox(height: 10.h,),
                RatingSections(
                  name: 'هل قام الفني بإبلاغك بالمشكلة وسببها؟',
                  valRate: controller.problemSolveRate.value,
                ),
                SizedBox(height: 10.h,),
                RatingSections(
                  name: 'هل تكررت المشكلة معك اكثر من مره؟',
                  valRate: controller.repeatProblemRate.value,
                ),
                SizedBox(height: 10.h,),
                RatingSections(
                  name: 'ما مدى رضاك بشكل عام بالخدمة من 1 الى 10',
                  valRate: controller.ratingGlobal.value,
                ),
                SizedBox(height: 10.h,),
                Container(
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    borderRadius: BorderRadius.circular(15.r)
                  ),child: TextFormField(
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'اكتب تعليقاتك',
                    hintStyle: TextStyle(
                      color: Colors.grey
                    )
                  ),
                ),
                ),
                SizedBox(height: 15.h,),
                GestureDetector(
                  onTap: () async {
                    /*print("هل تم حل المشكلة بسرعة عالية من قبل الفني؟"+"\n"+
                        "${controller.speedRate.value}"+"\n"+
                        'هل قام الفني بإبلاغك بالمشكلة وسببها؟'+"\n"+
                        "${controller.problemSolveRate.value}"+"\n"+
                        'هل تكررت المشكلة معك اكثر من مره؟'+"\n"+
                        "${controller.repeatProblemRate.value}"+"\n"+
                        'ما مدى رضاك بشكل عام بالخدمة من 1 الى 10'+"\n"+
                        "${controller.ratingGlobal.value}");
                    */
                    print(id);
                    await FirebaseFirestore.instance.collection("reports").doc(id).update(
                      {
                        "القسم":"ok",
                      }
                    ).then((value) {
                      Navigator.pop(context);
                      showCustomDialog(
                          text: 'تم إرسال التقيم بنجاح'
                      );
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
                )

              ],
            )),
      ),
    );
  }
}

class RatingSections extends StatelessWidget {
  final String? name;
  int? valRate;

  RatingSections({Key? key, this.name, this.valRate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 40.h,
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Color(0xffE3F1ED),
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Text(
            name!,
            style: TextStyle(
                color: mainColor, fontWeight: FontWeight.bold, fontSize: 15.sp),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        RatingBar.builder(
          initialRating: 0,
          minRating: 0,
          direction: Axis.horizontal,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            valRate = rating.toInt();
          },
        )
      ],
    );
  }
}
