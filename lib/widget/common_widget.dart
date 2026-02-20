import 'package:flutter/material.dart';

class CommonWidget{
  static AppBar AppAppBar({String ?title}){
    return AppBar(title: Text(title ?? ""),);
  }
}