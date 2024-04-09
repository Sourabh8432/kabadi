import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppLoaderProgress extends StatelessWidget {
  const AppLoaderProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: !Platform.isIOS
              ?  Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircularProgressIndicator(color: textColor),
                )
              : const CupertinoActivityIndicator(
                  radius: 20,
                ),
        ),
      ),
    );


  }
  static void showLoader(BuildContext context){
    showDialog(barrierDismissible:false,context: context, barrierColor:Colors.transparent,builder: (BuildContext context){
            return Container(
              color: whiteColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: !Platform.isIOS
                ?  Padding(
              padding: const EdgeInsets.all(4.0),
              child: CircularProgressIndicator(color: textColor),
            )
                : const CupertinoActivityIndicator(
              radius: 20,
            ),
          ),
        ),
      );
      }
    );
  }
  static void hideLoader(BuildContext context){
    Navigator.pop(context);
  }
}
