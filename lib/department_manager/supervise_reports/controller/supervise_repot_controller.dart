import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../Firebase/firebase.dart';
import '../../../Firebase/reports.dart';

class SuperviseReportDMController extends GetxController{
  Report report = Report();
  String searchFilter="";
  String stateFilter="";
  String beneficiaryFilter="";
  String headquartersFilter="";
  String moveType="";
  var listReport;
  var timeFrom = DateTime.now().obs;
  var timeTo = DateTime.now().obs;

  var selectedText = ''.obs;

  Future<bool> fetchDataReportUser() async {
    String filter="";
    String? nameFilter;

    //==================================//
    if(stateFilter!=""){
      filter=stateFilter;
      nameFilter="الحالة";
    }
    else if(moveType!=""){
      filter=moveType;
      nameFilter="توع الحركة";
    }
    else if(beneficiaryFilter!=""){
      filter=beneficiaryFilter;
      nameFilter="الجهة المستفيدة";
    }
    else if(headquartersFilter!=""){
      filter=headquartersFilter;
      nameFilter="المقر";
    }
    else{
      filter="";
    }
    //========================================//
    try{
      if(searchFilter!=""&&filter!=""){
        await FirebaseFirestore.instance.collection("reports").
        where("رقم البلاغ",isEqualTo: searchFilter).
        //where("email",isEqualTo: FirebaseController.email).
        //where("الحالة",isNotEqualTo: "جديدة").

        where("${nameFilter}",isEqualTo: filter).
        get().
        then((value) => {
          listReport=[],
          value.docs.forEach((element) {
            (element["الحالة"]!="جديدة"&&element["الحالة"]!="مرفوضة")?listReport.add(element):"";
          }),
          print("listReport : "+"${listReport.length}"),
        });
        return true;
      }
      else if(searchFilter!=""&&filter==""){
        await FirebaseFirestore.instance.collection("reports").
        //where("الحالة",isNotEqualTo: "جديدة").
        //where("email",isEqualTo: FirebaseController.email).
        where("رقم البلاغ",isEqualTo: searchFilter).
        get().
        then((value) => {
          listReport=[],
          value.docs.forEach((element) {
            (element["الحالة"]!="جديدة"&&element["الحالة"]!="مرفوضة")?listReport.add(element):"";
          }),
          print("listReport : "+"${listReport.length}"),
        });
        return true;
      }
      else if(searchFilter==""&&filter!=""){
        await FirebaseFirestore.instance.collection("reports").
        //where("الحالة",isNotEqualTo: "جديدة").
        //where("email",isEqualTo: FirebaseController.email).
        where("${nameFilter}",isEqualTo: filter).
        get().
        then((value) => {
          listReport=[],
          value.docs.forEach((element) {
            (element["الحالة"]!="جديدة"&&element["الحالة"]!="مرفوضة")?listReport.add(element):"";
          }),
          print("listReport : "+"${listReport.length}"),
        });
        return true;
      }
      else{
        await FirebaseFirestore.instance.collection("reports").
        //where("الحالة",isNotEqualTo: "جديدة").
        //where("email",isEqualTo: FirebaseController.email).
        get().
        then((value) => {
          listReport=[],
          value.docs.forEach((element) {
            (element["الحالة"]!="جديدة"&&element["الحالة"]!="مرفوضة")?listReport.add(element):"";
          }),
          print("listReport : "+"${listReport.length}"),
        });
        return true;
      }
    }catch(e){
      print(e);
      return false;
    }

  }
  @override
  void onInit() {
    // TODO: implement onInit
    fetchDataReportUser();
    super.onInit();
  }
}