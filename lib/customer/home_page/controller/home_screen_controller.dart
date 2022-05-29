import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:roofa/Firebase/notification.dart';

import '../../../Firebase/firebase.dart';


class HomeScreenController extends GetxController{
  late String name;
  late String typeUser;
  late String typeStudent;
  var listReport;
  int numberNotification=0;
  List<Notifications> notification=[
    Notifications(numText: 0,number: 0),
    Notifications(numText: 1,number: 0),
    Notifications(numText: 2,number: 0),
  ];

  Future<bool> fetchDataProfile() async {
    final user = await FirebaseAuth.instance.currentUser;
    if(user != null){
      await FirebaseController.fetchDataUser2(user);
      name=FirebaseController.name;
      typeUser=FirebaseController.typeUser;
      typeStudent=FirebaseController.typeStudent;
      return true;
    }else{
      print("user null");
      return false;
    }
  }
  Future<bool> fetchData() async{
    bool checkFetchNotification=await fetchNotification();
    bool checkFetchDataProfile=await fetchDataProfile();
    return checkFetchNotification&&checkFetchDataProfile ;
  }
  Future<bool> fetchNotification() async {
    //========================================//
    try{
      notification=[
        Notifications(numText: 0,number: 0),
        Notifications(numText: 1,number: 0),
        Notifications(numText: 2,number: 0),
      ];
        await FirebaseFirestore.instance.collection("reports").
        where("email",isEqualTo: FirebaseController.email).
        get().
        then((value) => {
          value.docs.forEach((element) {
            if(!element["notification"][0]["notification"]) notification[0].number++;
            element["tracking"].forEach((track) {
              if(!track["notification"][0]["notification"]){
                if(track["الحالة"]=="مغلقة") notification[1].number++;
                else if(track["الحالة"]=="مرفوضة") notification[2].number++;
              }
            });
           // FirebaseFirestore.instance.collection("reports").doc(element.id).update(element.data());
          }),
          numberNotification=0,
          notification.forEach((element) {
            (element.number>0)?numberNotification++:"";
          }),
          print("تذاكر محولة : "+"${notification[0].number}"),
          print("تذاكر مغلقة : "+"${notification[1].number}"),
          print("تذاكر مرفوضة : "+"${notification[2].number}"),
          print("number Notification :"+"${numberNotification}"),
        });
        return true;
    }catch(e){
      print(e);
      return false;
    }
    return false;
  }
  bool checkNotification(){
    bool check=false;
    notification.forEach((element) {
      if(element.number>0) check=true;
    });
    return check;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    fetchDataProfile();

    super.onInit();
  }
}