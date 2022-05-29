import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';

class PinCodeController extends GetxController{
  String? valuePinCode = "123456";
  String? valueUserEnter = "";
  late String verificationId1;
  final auth= FirebaseAuth.instance;
  late PhoneNumber phone;
  bool colorBorder = false;
  bool verifyPhoneNumber=false;
  bool showLoading=false;
  Future<bool> f() async{
    await phone;
    return false;
  }
  Future<bool> sendCode() async {
    showLoading=true;
    await auth.verifyPhoneNumber(
      phoneNumber: phone.completeNumber,
      verificationCompleted: (phoneAuthCredential) async {
        print("phoneAuthCredential");
        print(phoneAuthCredential);
        print("phoneAuthCredential");
        showLoading=false;
        verifyPhoneNumber=false;
        //signInWithPhoneAuthCredential(phoneAuthCredential);
      },
      verificationFailed: (verificationFailed) async {print(verificationFailed);},
      codeSent: (verificationId, resendingToken) async {
        verificationId1 = verificationId;
        print("verificationId");
        print(verificationId);
        print("verificationId");
        showLoading=false;
        verifyPhoneNumber=true;
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        print("verificationId1");
        print(verificationId);
        print("verificationId1");
        showLoading=false;
      },
    ).then((value) => {
        print("sendCode : "+ verifyPhoneNumber.toString()),
    });
    return !showLoading;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    sendCode();
    super.onInit();
  }
}