import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

Future notification_toast(BuildContext context, String title ,String desc,{ToastificationType? toastificationType, ToastificationStyle? toastificationStyle, Color? descTextColor, Icon? icon} ){
  final completer = Completer(); // Create a Completer
  
  toastification.show(
    type: toastificationType,
    style: toastificationStyle,
    context: context, // optional if you use ToastificationWrapper
    title: Text(title),
     description: RichText(
      text: TextSpan(
        text: desc,
        style: TextStyle(color: descTextColor ?? Colors.black), // Setting text color for description
      ),
    ),
    alignment: Alignment.topRight,
    icon: icon,
    autoCloseDuration: const Duration(seconds: 3),
    showProgressBar: false,
    animationDuration: const Duration(milliseconds: 300),
    animationBuilder: (context, animation, alignment, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );

  // Complete the Completer after the autoCloseDuration
  Future.delayed(const Duration(seconds: 5), () {
    completer.complete();
  });

  // Return the Completer to allow awaiting its completion
  return completer.future;
}