import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:roofa/Firebase/firebase.dart';
import 'package:roofa/Firebase/reports.dart';

class SuperviserReportController extends GetxController{
 Report report = Report();
 String searchFilter="";
 String stateFilter="";
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
  if(stateFilter!=""){
   filter=stateFilter;
   nameFilter="الحالة";
  }
  else if(beneficiaryFilter!=""){
   filter=beneficiaryFilter;
   nameFilter="الجهة المستفيدة";
  }
  else if(headquartersFilter!=""){
   filter=headquartersFilter;
   nameFilter="المقر";
  }
  //========================================//
  try{
   if(searchFilter!=""&&filter!=""){
    await FirebaseFirestore.instance.collection("reports").
    where("email",isEqualTo: FirebaseController.email).
    where("رقم البلاغ",isEqualTo: searchFilter).
    where("${nameFilter}",isEqualTo: filter).
    get().
    then((value) => {
     listReport=value.docs,
     print("listReport : "+"${listReport.length}"),
    });
    return true;
   }
   else if(searchFilter!=""&&filter==""){
    await FirebaseFirestore.instance.collection("reports").
    where("email",isEqualTo: FirebaseController.email).
    where("رقم البلاغ",isEqualTo: searchFilter).
    get().
    then((value) => {
     listReport=value.docs,
     print("listReport : "+"${listReport.length}"),
    });
    return true;
   }
   else if(searchFilter==""&&filter!=""){
    await FirebaseFirestore.instance.collection("reports").
    where("email",isEqualTo: FirebaseController.email).
    where("${nameFilter}",isEqualTo: filter).
    get().
    then((value) => {
     listReport=value.docs,
     print("listReport : "+"${listReport.length}"),
    });
    return true;
   }
   else{
    await FirebaseFirestore.instance.collection("reports").
    where("email",isEqualTo: FirebaseController.email).
    get().
    then((value) => {
     listReport=value.docs,
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