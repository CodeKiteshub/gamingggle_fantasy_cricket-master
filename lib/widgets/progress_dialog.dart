import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ProgressDialog {
  static void showProgressDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(color: Colors.greenAccent,),
        //   child: Lottie.asset(
        //   'assets/animations/loading.json',
        //   width: 150,
        //   height: 150,
        //   fit: BoxFit.fill,
        // ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        //prevent Back button press
        return WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: alert);
      },
    );
  }
}
