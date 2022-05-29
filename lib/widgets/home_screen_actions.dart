import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GridViewHomeActionScreen extends StatelessWidget {
  final List<dynamic>? map;
  final int? numAction;

  const GridViewHomeActionScreen({Key? key, this.map,
    this.numAction = 2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      height: 200.h,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: numAction!,
            childAspectRatio: numAction==3?1.2:2,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.w),
        itemCount: map!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(map![index]['page_to']);
            },
            child: Container(
              width: 95.w,
              height: 63.h,
              decoration: BoxDecoration(
                  color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Color(0xff000000).withOpacity(.16),
                  blurRadius: 3.0,
                ),
              ]),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: SvgPicture.asset(map![index]['svg_picture']),
                  ),
                  Expanded(
                    child: Text(
                      map![index]['text'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff447A78)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
