import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../const/const_color.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../higher_management/statistic_ticket/ticket_chart.dart';

class AchievementOfTechniciansController extends GetxController{
  var index = 0.obs;
  Color buttonActive = mainColor;
  Color textButtonActive = Colors.white;
  List listReport=[];
  String typeList="total";
  List? totalReports,accreditedReports,lateReports,
      closedReports,spoonReports,underProcedureReports;
  int numFixtures=0,
      numSubstitutions=0,
      numRemovals=0,
      numMaintenance=0;

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
        numFixtures=0,
        numSubstitutions=0,
        numRemovals=0,
        numMaintenance=0,
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
          element["tracking"].forEach((track) {
            if(track["نوع الحركة"]=="ازالة /فك") numRemovals++;
            else if(track["نوع الحركة"]=="تركيب")numFixtures++;
          });
        }),
        listReport=[],
        numMaintenance=numFixtures+numRemovals+numSubstitutions,
        listReport=sortLists()!,
        print("Closed Reports : "+"${closedReports?.length}"),
        print("Accredited Reports : "+"${accreditedReports?.length}"),
        print("Under Procedure Reports : "+"${underProcedureReports?.length}"),
        print("Spoon Reports : "+"${spoonReports?.length}"),
        print("Late Reports : "+"${lateReports?.length}"),
        print("Total Report : "+"${totalReports?.length}"),
        print("num Fixtures : "+"${numFixtures}"),
        print("num Removals : "+"${numRemovals}"),
        print("num Substitutions : "+"${numSubstitutions}"),
        print("num Maintenance : "+"${numMaintenance}"),
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
  var selectName = 'اسامة العوض'.obs;
  List customerNames = [
    'اسامة العوض',
    /*'أحمد متولي',
    'رهف متولي',
    'شهد العامودي',
    'رزان الحربي',
    'ايمان الأهدل',*/

  ];
}