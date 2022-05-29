import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../Firebase/firebase.dart';
import '../../../Firebase/notification.dart';

class HomeTController extends GetxController{
  late String name;
  late String typeUser;
  int numberNotification=0;
  List<Notifications> notification=[
    Notifications(numText: 4,number: 0),
    Notifications(numText: 6,number: 0),
  ];
  Future<bool> fetchDataProfile() async {
    final user = await FirebaseAuth.instance.currentUser;
    if(user != null){
      await FirebaseController.fetchDataUser2(user);
      name=FirebaseController.name;
      typeUser=FirebaseController.typeUser;
      return true;
    }else{
      print("user null");
      return false;
    }
  }
  Future<bool> fetchNotification() async {
    //========================================//
    try{
      notification=[
        Notifications(numText: 4,number: 0),
        Notifications(numText: 6,number: 0),
      ];
      await FirebaseFirestore.instance.collection("reports").
      // where("email",isEqualTo: FirebaseController.email).
      get().
      then((value) => {
        value.docs.forEach((element) {
          if(element["الجهة"]=="الفنيين"&&
              (element["الحالة"]=="تحت الإجراء"&&element["tracking"].length==0)&&
              !element["notification"][3]["notification"])
            notification[0].number++;
          if(element["الحالة"]!="مرفوضة"&&element["الحالة"]!="مغلقة"&&element["الجهة"]=="الفنيين"){
            if(Timestamp.now().compareTo(element["TimeFor"])==1){
              notification[1].number++;
            }
          }
        }),
        numberNotification=0,
        notification.forEach((element) {
          (element.number>0)?numberNotification++:"";
        }),
        print("تذاكر جديدة : "+"${notification[0].number}"),
        print("تذاكر متأخرة : "+"${notification[1].number}"),
        print("number Notification :"+"${numberNotification}"),
      });
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    fetchDataProfile();
    super.onInit();
  }
}