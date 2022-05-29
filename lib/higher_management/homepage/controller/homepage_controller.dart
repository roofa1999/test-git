import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../Firebase/firebase.dart';
import '../../../Firebase/notification.dart';

class HomePageController extends GetxController{
  late String name;
  late String typeUser;
  int numberNotification=0;
  List<Notifications> notification=[
    Notifications(numText: 6,number: 0),
    Notifications(numText: 7,number: 0),
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
        Notifications(numText: 6,number: 0),
        Notifications(numText: 7,number: 0),
      ];
      await FirebaseFirestore.instance.collection("reports").
      // where("email",isEqualTo: FirebaseController.email).
      get().
      then((value) => {
        value.docs.forEach((element) {
          if(element["الحالة"]!="معلقة"&&element["الحالة"]!="مرفوضة"&&element["الحالة"]!="مغلقة"&&element["الجهة"]=="الفنيين"){
            if(Timestamp.now().compareTo(element["TimeFor"])==1){
              notification[0].number++;
            }
          }
          if(element["الحالة"]=="معلقة"){
            notification[1].number++;
          }
        }),
        numberNotification=0,
        notification.forEach((element) {
          (element.number>0)?numberNotification++:"";
        }),
        print("تذاكر متأخرة : "+"${notification[0].number}"),
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