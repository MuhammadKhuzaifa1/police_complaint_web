import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:police_complaint_web/screens/side_menu.dart';
import '../constants/firebase_references.dart';
import '../utilites/utils.dart';

class SignInController with ChangeNotifier{

  bool _loading = false;
  bool get loading => _loading;

  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  userLogin({String? email, String? password}) async {
    setloading(true);
    try{
      final user = await FirebaseReferences().auth.
      signInWithEmailAndPassword(email: email!, password: password!).then((value){
        Get.off(SideMenuScreen());
        setloading(false);
      }).catchError((e){
        setloading(false);
        Utils.toastMessage(e.toString().replaceAll(RegExp(r'\[.*?\]'), ''));
      });
      setloading(false);
    }catch(e){
      setloading(false);
      Utils.toastMessage(e.toString().replaceAll(RegExp(r'\[.*?\]'), ''));
    }
  }

}