import 'dart:core';

class Notifications{
  int number=0;
  int numText=0;
  Notifications({this.numText=0,this.number=0});
  String setTextNotification({int numText=0,int number=0}){
    return Notifications(numText: numText,number: number).toString();
  }
  @override
  String toString() {
    super.toString();
    switch(numText){
      case 0:
        return "يوجد لديك ${number} بلاغات تم تغيير حالتها";
      case 1:
        return "يوجد لديك ${number} تذاكر تم انجازها";
      case 2:
        return "يوجد لديك ${number} تذاكر تم رفضها";
      case 3:
        return " يوجد لديك تذاكر يوجد لديك ${number}  تم تحويلها إليك من قسم الصيانة";
      case 4:
        return "يوجد لديك ${number} تذاكر جديدة";
      case 5:
        return "يوجد لديك تذاكر تم تحويلها ${number} إليك من خدمة العملاء";
      case 6:
        return "يوجد لديك ${number} بلاغات متأخرة";
      case 7:
        return "يوجد لديك ${number} بلاغات معلقة";
      case 10:
        return "";
    }
    return "";
  }
}