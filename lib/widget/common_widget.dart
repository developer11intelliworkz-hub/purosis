import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:purosis/consts/app_image.dart';

class CommonWidget {
  static AppBar appAppBar({String? title, List<Widget>? actions}) {
    return AppBar(
      title: Text(title ?? ""),
      backgroundColor: Color(0xFFF5F5F5),

      foregroundColor: Colors.black,
      elevation: 0,
      scrolledUnderElevation: 0,
      actions: actions,
    );
  }

  static Widget commonLoading({Color? color}) {
    return Center(
      child: CircularProgressIndicator(color: color ?? Color(0xFF8EBF1F)),
    );
  }

  static Widget commonEmpty() {
    return Center(child: Lottie.asset(AppImage.emptyBoxAnimation));
  }
}
