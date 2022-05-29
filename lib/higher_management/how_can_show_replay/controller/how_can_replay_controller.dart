import 'package:get/get.dart';
enum HowCanShow{
  all,
  customerService,
  manager,
  customer
}
class HowCanReplayController extends GetxController{
  RxBool valueGroup = false.obs;
  RxBool valuePerson = true.obs;
 var select = HowCanShow.all.obs;
}