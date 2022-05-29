import 'dart:core';

import 'package:get/get.dart';

class SendReportController extends GetxController{
  SendReportVal value = SendReportVal();
  void setVal(String name,String val){
    switch(name){
      case "الجهة المستفيدة":
        value.beneficiary=val;
        break;
      case "المقر":
        value.headquarters=val;
        break;
      case "المبنى":
        value.building=val;
        break;
      case "الطابق":
        value.floor=val;
        break;
      case "نوع الغرفة":
        value.roomType=val;
        break;

    }
  }
  String? getVal(String name){
    switch(name){
      case "الجهة المستفيدة":
        return value.beneficiary;
      case "المقر":
        return value.headquarters;
        break;
      case "المبنى":
        return value.building;
        break;
      case "الطابق":
        return value.floor;
        break;
      case "نوع الغرفة":
        return value.roomType;
        break;
    }
    return "";
  }
  bool check(){
    if(value.beneficiary=="")return false;
    else if(value.headquarters=="")return false;
    else if(value.building=="")return false;
    else if(value.floor=="")return false;
    else if(value.roomType=="")return false;
    else if(value.roomNumber=="")return false;
    else return true;
  }
}
class SendReportVal{
  String beneficiary="";
  String headquarters="";
  String building="";
  String floor="";
  String roomType="";
  String roomNumber="";
}