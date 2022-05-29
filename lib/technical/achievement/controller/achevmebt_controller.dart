import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roofa/higher_management/statistic_ticket/ticket_chart.dart';

import '../../../const/const_color.dart';
import '../../../higher_management/statistic_ticket/view/statistic_screen.dart';

class AchivementTController extends GetxController{
  var index = 0.obs;
  Color buttonActive = mainColor;
  Color textButtonActive = Colors.white;
  List listReport=[];
  String typeList="total";
  List? totalReports,accreditedReports,lateReports,closedReports,spoonReports,underProcedureReports;

  Future<bool> fetchDataReportUser() async {
    //========================================//
    try{
        await FirebaseFirestore.instance.collection("reports").
        get().
         then((value) => {
          totalReports=[],
          accreditedReports=[],
          lateReports=[],
          closedReports=[],
          spoonReports=[],
          underProcedureReports=[],
          value.docs.forEach((element) {
            totalReports?.add(element);
            if(element["الحالة"]=="مغلقة")closedReports?.add(element);
            else if(element["الحالة"]=="معتمدة")accreditedReports?.add(element);
            else if(element["الحالة"]=="تحت الإجراء")underProcedureReports?.add(element);
            if(element["الحالة"]=="معلقة")spoonReports?.add(element);
            else if(element["الحالة"]!="مرفوضة"&&element["الحالة"]!="مغلقة"&&element["الجهة"]=="الفنيين"){
              if(Timestamp.now().compareTo(element["TimeFor"])==1){
                lateReports?.add(element);
              }
            }
          }),
          listReport=[],
          listReport=sortLists()!,
          print("Closed Reports : "+"${closedReports?.length}"),
            print("Accredited Reports : "+"${accreditedReports?.length}"),
        print("Under Procedure Reports : "+"${underProcedureReports?.length}"),
        print("Spoon Reports : "+"${spoonReports?.length}"),
        print("Late Reports : "+"${lateReports?.length}"),
          print("Total Report : "+"${totalReports?.length}"),
        });
        return true;
    }catch(e){
      print(e);
      return false;
    }

  }
  void onClickButton(val){
    index.value = val;
    print(index);
  }
  List? sortLists(){
    print(typeList);
    switch(typeList){
      case "total": return totalReports;
      case "spoon": return spoonReports;
      case "closed": return closedReports;
      case "under Procedure":
      case "underProcedure": return underProcedureReports;
      case "accredited": return accreditedReports;
      case "late": return lateReports;
    }
    return [];
  }
  giveData(List number){
    TicketCharts temp = TicketCharts();
    temp.data[0].setNumY(number[0]);
    temp.data[1].setNumY(number[1]);
    temp.data[2].setNumY(number[2]);
    temp.data[3].setNumY(number[3]);
    temp.data[4].setNumY(number[4]);
    temp.data[5].setNumY(number[5]);
    return temp.data;
  }
  var selectName = 'عبدالعزيز الأحمدي'.obs;
  List customerNames = [
    'أحمد متولي',
    'رهف متولي',
    'شهد العامودي',
    'رزان الحربي',
    'ايمان الأهدل',
  ];
}