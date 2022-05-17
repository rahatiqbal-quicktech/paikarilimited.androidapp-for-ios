import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialog {
  static Future? dialog;

  void show(BuildContext context) async {
    if (dialog == null) {
      dialog = viewDialog(context);
      await dialog;
    }
  }

  void dismiss() {
    if (dialog != null) {
      dialog = null;
      Get.back();
    }
  }

  Future viewDialog(BuildContext context) {
    return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: Colors.grey.withOpacity(.7),
              insetPadding: EdgeInsets.symmetric(horizontal: 100),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    CupertinoActivityIndicator(radius: 17, color: Colors.white),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ));
  }
}
