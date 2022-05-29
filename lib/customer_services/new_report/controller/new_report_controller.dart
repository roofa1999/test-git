import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../Firebase/reports.dart';

class NewReportCSController extends GetxController{
  Report report = Report();
  String searchFilter="";
  String beneficiaryFilter="";
  String headquartersFilter="";
  var listReport;
  var timeFrom = DateTime.now().obs;
  var timeTo = DateTime.now().obs;

  var selectedText = ''.obs;

  Future<bool> fetchDataReportUser() async {
    String filter="";
    String? nameFilter;

    //==================================//
    if(beneficiaryFilter!=""){
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
        where("الحالة",isEqualTo: "جديدة").

        where("${nameFilter}",isEqualTo: filter).
        get().
        then((value) => {
          listReport=[],
          value.docs.forEach((element) {
            (element["الجهة"]=="خدمة العملاء")?listReport.add(element):"";
          }),
          print("listReport : "+"${listReport.length}"),
        });
        return true;
      }
      else if(searchFilter!=""&&filter==""){
        await FirebaseFirestore.instance.collection("reports").

        //where("email",isEqualTo: FirebaseController.email).
        where("رقم البلاغ",isEqualTo: searchFilter).
    where("الحالة",isEqualTo: "جديدة").
        get().
        then((value) => {
          listReport=[],
          value.docs.forEach((element) {
            (element["الجهة"]=="خدمة العملاء")?listReport.add(element):"";
          }),
          print("listReport : "+"${listReport.length}"),
        });
        return true;
      }
      else if(searchFilter==""&&filter!=""){
        await FirebaseFirestore.instance.collection("reports").
        where("الحالة",isEqualTo: "جديدة").
        //where("email",isEqualTo: FirebaseController.email).
        //where("${nameFilter}",isEqualTo: filter).
        get().
        then((value) => {
          listReport=[],
          value.docs.forEach((element) {
            (element["الجهة"]=="خدمة العملاء")?listReport.add(element):"";
          }),
          print("listReport : "+"${listReport.length}"),
        });
        return true;
      }
      else{
        await FirebaseFirestore.instance.collection("reports").
        where("الحالة",isEqualTo: "جديدة").
        //where("email",isEqualTo: FirebaseController.email).
        get().
        then((value) => {
          listReport=[],
          value.docs.forEach((element) {
            (element["الجهة"]=="خدمة العملاء")?listReport.add(element):"";
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