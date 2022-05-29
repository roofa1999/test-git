import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roofa/department_manager/chosen_techinical_for_ticket/view/chosen_technical_for_ticket.dart';
import 'package:roofa/department_manager/chosen_technical/controller/chosen_technical_controller.dart';
import 'package:select_dialog/select_dialog.dart';
import '../../../Firebase/firebase.dart';
import '../../../Firebase/reports.dart';
import '../../../const/const_color.dart';
import '../../../const/text_app.dart';
import '../../../widgets/dialog_date_time.dart';
import '../../home_page/view/home_page.dart';
import 'package:intl/intl.dart' as intl;
class ChosenTechnicalDMScreen extends StatefulWidget {
  @override
  State<ChosenTechnicalDMScreen> createState() => _ChosenTechnicalDMScreenState();
}
class _ChosenTechnicalDMScreenState extends State<ChosenTechnicalDMScreen> {
  final controller = Get.put(ChosenTechnicalDMController());
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("تعيين الفنيين"),
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
          children: [
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.r),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                  colorShadowSearch.withOpacity(.16),
                                  blurRadius: 10,
                                  offset: Offset(0, 9))
                            ]),
                        child: TextFormField(
                          cursorColor: mainColor,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.r),
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              hintText: 'البحث برقم البلاغ',
                              hintStyle: TextStyle(color: mainColor),
                              prefixIcon: Icon(
                                Icons.search,
                                color: mainColor,
                              )),
                        ),
                      )),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          Get.dialog(DalogDateTime());
                        },
                        icon: Icon(
                          Icons.date_range_sharp,
                          color: grayColor,
                        )),
                  ),
                ],
              ),
            ),
            /*Container(
                decoration:
                BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: colorShadowSearch.withOpacity(.56),
                      blurRadius: 10,
                      offset: Offset(0, 4))
                ]),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: chosenTechnicalSortDM.length,
                  itemBuilder: (context, index) {
                    List c = chosenTechnicalSortDM[index]['type_sort_name']
                    ['type_sort_value'];
                    return GetBuilder<ChosenTechnicalDMController>(
                      builder: (_) {
                        return  ListTile(
                          textColor: mainColor,
                          trailing: Icon(
                            Icons.keyboard_arrow_down,size: 25.r,),
                          title: Text(
                            '${chosenTechnicalSortDM[index]['type_sort_name']['name']}',
                            style:
                            TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: (){
                            SelectDialog.showModal(
                              context,
                              label: "${controller.selectedText}",
                              selectedValue: '${controller.selectedText.value}',
                              items: c,
                              onChange: (selected) {
                                controller.selectedText.value = selected.toString();
                                //controller.update();
                                //=======//
                                controller.headquartersFilter="";
                                controller.beneficiaryFilter="";
                                switch("${statusSortDM[index]['type_sort_name']['name']}"){
                                  case "فرز على حسب الجهة":
                                    controller.beneficiaryFilter=selected.toString();
                                    break;
                                  case "فرز على حسب المقر":
                                    controller.headquartersFilter=selected.toString();
                                    print(controller.headquartersFilter);
                                    break;
                                }
                                //await controller.fetchDataReportUser();
                                controller.update();
                                setState((){
                                });
                                //=======
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                )),*/
            Expanded(
              child: FutureBuilder(
                  future: controller.fetchDataReportUser(),
                  builder: (context,snapShot) {
                    if (!snapShot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else{
                      return ListView.builder(
                        itemCount: controller.listReport.length,
                        itemBuilder: (_,index)=>GestureDetector(
                          onTap: (){
                            Report.reportNumber=controller.listReport[index]['رقم البلاغ'];

                            setState(() {
                              Get.to(()=>ChosenTechnicalForTicketDMScreen(
                                map: ticketSelectionTechnical[0],
                              ));
                            });
                          },
                          child: Container(
                            height: controller.listReport[index]["الحالة"]!="جديدة"?Get.width * 0.28:Get.width * 0.4,
                            margin: EdgeInsets.all(8.r),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.r),
                                boxShadow: [
                                  BoxShadow(
                                      color: colorShadowSearch.withOpacity(.34),
                                      offset: Offset(0,4),
                                      blurRadius: 10
                                  )
                                ]
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      // color:  controller.listReport[index]["الحالة"]!="جديدة"
                                        color:  (controller.listReport[index]["الحالة"]=="معتمدة")&&
                                (controller.listReport[index]["الجهة"])!="الفنيين"
                             //   (controller.listReport[index]["الجهة"])!="خدمة العملاء")//controller.listReport[index]["نوع الحركة"]=="إحالة التذكرة لمركز الصيانة"
                                        // controller.listReport[index]["الحالة"]!="جديدة"
                                        //ticketSelectionTechnical[index]['report_status']
                                            ?Colors.orange//Color(0xffBFBFBF)
                                            :Color(0xff30D852).withOpacity(.5)
                                            ,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15.r),
                                          bottomRight: Radius.circular(15.r),
                                        )
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 18,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text('رقم البلاغ : ',style: TextStyle(
                                                      color: mainColor,
                                                      fontSize: 15.sp,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                  Text(controller.listReport[index]['رقم البلاغ']
                                                    //'${ticketSelectionTechnical[index]['report_number']}'
                                                    ,style: TextStyle(
                                                        color: mainColor
                                                    ),),
                                                ],
                                              ),
                                              Text(FirebaseController.formatTimestamp(controller.listReport[index]["Time"]),
                                                /*'${
                                                intl.DateFormat
                                                    .yMEd()
                                                    .add_jm()
                                                    .format(
                                                    ticketSelectionTechnical
                                                    [index]['report_date_time']
                                                )
                                            }'*/style: TextStyle(
                                                    color: colorShadowSearch
                                                ),),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text('الجهة : ',style: TextStyle(
                                                  color: mainColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              Text('${controller.listReport[index]['الجهة المستفيدة']}',
                                                //'${ticketSelectionTechnical[index]['report_target']}',
                                                style: TextStyle(
                                                    color: mainColor
                                                ),),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text('المقر : ',style: TextStyle(
                                                  color: mainColor,
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold
                                              ),),
                                              Text('${controller.listReport[index]['المقر']}'
                                                ,style: TextStyle(
                                                    color: mainColor
                                                ),),
                                            ],
                                          ),
                                        ),
                                       // controller.listReport[index]["الحالة"]!="جديدة"?
                                        (controller.listReport[index]["الحالة"]=="معتمدة")&&
                                            (controller.listReport[index]["الجهة"])!="الفنيين"?
                                     /*   ((controller.listReport[index]["الحالة"]=="جديدة")&&
                                            (controller.listReport[index]["الجهة"])!="الفنيين"&&
                                                (controller.listReport[index]["الجهة"])!="خدمة العملاء")*/
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  Report.reportNumber=controller.listReport[index]['رقم البلاغ'];
                                                  Get.to(()=>ChosenTechnicalForTicketDMScreen(
                                                    map: ticketSelectionTechnical[0],
                                                  ));
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: Get.width * 0.35,
                                                  height: Get.width* 0.1,
                                                  decoration: BoxDecoration(
                                                    color: mainColor,
                                                    borderRadius: BorderRadius.circular(50.r),
                                                  ),
                                                  child: Text('تعيين فني',style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.sp
                                                  ),),
                                                ),
                                              )
                                            ],
                                          ),
                                        ):SizedBox()
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }}),
            )
          ],
        ),
      ),
    );
  }
}