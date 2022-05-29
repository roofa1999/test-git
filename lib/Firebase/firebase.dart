import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class FirebaseController{
  static late User user,currentUser;
  static late String name;
  static late String email;
  static late String typeUser;
  static late String typeStudent;
  static late String phoneNumber;
  static late String firstEmail,lastEmail;
  static String cuaseRefusal="";
  static var report;
  static var notification=[
    {"notification":false,},
    {"notification":false,},
    {"notification":false,},
    {"notification":false,},
    {"notification":false,},
  ];
  static Future<void> fetchDataUser1() async {
    user = await FirebaseAuth.instance.currentUser!;
    await fetchDataUser2(user);
  }
  static Future<void> fetchDataUser2(User user1) async {
    user = user1;
    email=user.email!;
    convertEmail(email);
    if(checkType(email).contains("manager")){
      await FirebaseFirestore.instance.collection("user_manager").where("email",isEqualTo: email).get()
          .then((value) => {
        name=value.docs[0]["name"],
        phoneNumber=value.docs[0]["phone"],
        typeUser=value.docs[0]["type"],
      });
    }else if(checkType(email).contains("student")){
      await FirebaseFirestore.instance.collection("user_student").where("email",isEqualTo: email).get()
          .then((value) => {
          value.docs[0]["name"]==null? name=firstEmail: name=value.docs[0]["name"],
          typeUser="المستفيد",
          value.docs[0]["phone"]==null?phoneNumber="+966xxxxxxx":phoneNumber=value.docs[0]["phone"],
          typeStudent=value.docs[0]["type"],
      });
    }else{
      user.displayName==null? name=firstEmail: name=user.displayName!;
      typeUser=checkType(email);
     user.phoneNumber==null?phoneNumber="+966xxxxxxx":phoneNumber=user.phoneNumber!;
    }
    print("[ name:"+name +" ,email:"+email+",phone:"+phoneNumber+",type:"+typeUser+" ]");

  }
  static void convertEmail(String emailC){
    bool fisrt=true;
    firstEmail="";
    lastEmail="";
    for(int i=0;i<emailC.length;i++){
      if(emailC[i]=='@'){
        fisrt=false;
      }
      else{
        fisrt?firstEmail+=emailC[i]:lastEmail+=emailC[i];
      }
    }
  }
  static String checkType(String email){
    if(email.contains("st.uqu.edu.sa")){
      return("student");
    }
    else if(email.contains("uqu.edu.sa")){
      return("manager");
    }else{
      return("account");
    }
  }
  static String generateRandomString(int len) {
    var r = Random();
    const _chars = '1234567890AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }
  static String generateRandomString2(int lenChar,int lenNum) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    const _numbers = '1234567890';
    return List.generate(lenChar, (index) => _chars[r.nextInt(_chars.length)]).join()+
        List.generate(lenNum, (index) => _numbers[r.nextInt(_numbers.length)]).join();
  }
  static String formatTimestamp(Timestamp timestamp) {
    var format =  new DateFormat('yMMMMd'); // <- use skeleton here
    //return format.format(timestamp.toDate());
    return DateFormat.yMMMMd()
        .add_jms()
        .format(timestamp.toDate());
  }
  static Future<bool> getReport(String numberReport) async {

    await FirebaseFirestore.instance.collection("reports").
    where('رقم البلاغ',isEqualTo: numberReport).get().then((value){
      if(value.docs.isNotEmpty) {
        report=null;
        report = value.docs[0];
        if(report["الحالة"]=="مرفوضة") getCauseRefusal(report);
        return true;
      }
    });
    return false;
  }
  static void getCauseRefusal(var report1){
    List tracking =report1["tracking"];
    tracking.forEach((element) {
      if(element["الحالة"]=="مرفوضة") cuaseRefusal=element["الوصف"];
    });
  }
}
