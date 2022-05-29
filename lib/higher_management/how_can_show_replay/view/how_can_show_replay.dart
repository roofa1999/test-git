import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:roofa/Customer/details_ticket/view/details_ticket.dart';
import 'package:roofa/const/const_color.dart';
import 'package:roofa/const/text_app.dart';
import 'package:roofa/higher_management/details_ticket/view/details_ticket.dart';
import 'package:roofa/higher_management/how_can_show_replay/controller/how_can_replay_controller.dart';
import 'package:roofa/widgets/custom_dialog.dart';

class HowCanShowReplayScreen extends StatelessWidget {
  final controller = Get.put(HowCanReplayController());


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'من يمكنه مشاهدة الرد',
              style: TextStyle(),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.back();
              }, icon: Icon(Icons.arrow_back_ios),
            )
        ),
        body: Column(
            children: [
            Container(
            width: Get.width,
            height: Get.height / 2.5,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: colorShadowSearch.withOpacity(.23),
                    blurRadius: 10,
                    offset: Offset(0, 9),
                  )
                ]),
            child: Obx(
                ()=> Column(
                  children: [
                    Expanded(
                      child: _buildListTileButton(
                        title: 'الكل',
                        valueP: HowCanShow.all,
                        valueG: controller.select.value,
                        onTap: (val){
                          controller.select.value = val;
                        }
                      ),
                    ),
                    Expanded(
                      child: _buildListTileButton(
                        title: 'خدمة العملاء',
                        valueP: HowCanShow.customerService,
                        valueG: controller.select.value,
                        onTap: (val){
                          controller.select.value = val;
                        }
                      ),
                    ), Expanded(
                      child: _buildListTileButton(
                        title: 'رئيس القسم',
                        valueP: HowCanShow.manager,
                        valueG: controller.select.value,
                        onTap: (val){
                          controller.select.value = val;
                        }
                      ),
                    ), Expanded(
                      child: _buildListTileButton(
                        title: 'المستفيد',
                        valueP: HowCanShow.customer,
                        valueG: controller.select.value,
                        onTap: (val){
                          controller.select.value = val;
                        }
                      ),
                    ),
                  ],
                )
            )

            ),
              SizedBox(height: 22.h,),
              OutlineButton(
                borderSide: BorderSide(
                  color: mainColor,
                  width: 1.5
                ),
                  onPressed: (){
                  Get.off(()=>DetailsTicketHMPage());

                  },
                color: mainColor,
                child: Text('إضافة',style: TextStyle(
                  color: mainColor,
                  fontSize: 16.sp
                ),
                ),
                highlightColor: mainColor,
              )
            ],
    ),)
    ,
    );
  }
  Widget _buildListTileButton({title,onTap,valueG,valueP = false}){
    return Column(
      children: [
        ListTile(
          title:  Text('${title}',style: TextStyle(),),
          leading: Radio(
            activeColor: mainColor,
            value: valueP,
            groupValue: valueG,
            onChanged: onTap
          ),
        ),
        title == 'المستفيد'?SizedBox():Divider(
          color: mainColor,
        )
      ],
    );
  }
}
