import 'package:charts_flutter/flutter.dart';
import 'package:roofa/const/text_app.dart';
class Controllert{
  static int colorState(String state){
      for(int i=0;i<statusReport.length;i++){
        if(state.contains(statusReport[i]['name'][0])){
          return i;
        }
      }return 4;
  }
}