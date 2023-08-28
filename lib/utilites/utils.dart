import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void fieldFocus(
      BuildContext context, FocusNode currentNode, FocusNode nextFocus) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  tagHeading(String t){
    return Padding(
      padding: EdgeInsets.only(top: 3,bottom: 3),
      child: Text(t,style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 25
      ),),
    );
  }


  /// Toast
  static toastMessage(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        textColor: Colors.white,
        fontSize: 16.0,

    );
  }


  alertDialog({BuildContext? context,VoidCallback? onPressed, String? text}){
    return showDialog(
        context: context!,
        builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text("Alert"),
            content: Text(text!),
            actions: [
              // CupertinoDialogAction(child: Text("Close"),onPressed: () => Get.back(),),
              CupertinoDialogAction(isDefaultAction: true, child: Text("Confirm"),onPressed: onPressed),
            ],
        )
    );
  }

}
