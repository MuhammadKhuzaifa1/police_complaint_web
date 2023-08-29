import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:police_complaint_web/screens/side_menu.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

import '../constants/firebase_references.dart';
import '../utilites/utils.dart';


class SignupController with ChangeNotifier{

  bool _loading = false;
  bool get loading => _loading;

  setloading(bool value) {
    _loading = value;
    notifyListeners();
  }

  userSignUp({String? email, String? password, String? district,Uint8List? dataa, String? name, String? address }) async {
    setloading(true);
    try{
      UserCredential? userCredential = await FirebaseReferences().auth.
      createUserWithEmailAndPassword(email: email!, password: password!).then((valuee) async {
        int emailCount = email.length;
        List data = [];
        String temp = "";
        print(emailCount);
        for(int i=0; i<emailCount; i++) {
          temp = temp + email[i].toLowerCase();
          data.add(temp);
        }
        final res  = await FirebaseReferences().stationsReference.doc(valuee.user!.uid).set({
          'id' : valuee.user!.uid,
          'email' : email,
          'emailForSearch' : data,
          'district': district,
          'name' : name,
          'address' : address,
        }).then((valu) async {
          final firebaseStorageRef = FirebaseStorage.instance.ref().child("${Uuid().v4()}.jpg");
          await firebaseStorageRef.putData(dataa!);
          String downloadURL = await firebaseStorageRef.getDownloadURL();
          FirebaseReferences().stationsReference.doc(valuee.user!.uid).update({
            'imageUrl' : downloadURL.toString(),
          }).then((value){
            Get.off(SideMenuScreen());
            Utils.toastMessage("Create account successfully");
          });

        }).catchError((e){
          setloading(false);
          Utils.toastMessage(e.toString().replaceAll(RegExp(r'\[.*?\]'), ''));
        });
      }).catchError((e){
        setloading(false);
        Utils.toastMessage(e.toString().replaceAll(RegExp(r'\[.*?\]'), ''));
      });
      // setloading(false);
    }catch(e){
      setloading(false);
      Utils.toastMessage(e.toString().replaceAll(RegExp(r'\[.*?\]'), ''));
    }
  }
}