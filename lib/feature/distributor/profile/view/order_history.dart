import 'package:flutter/material.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_search_field.dart';
import 'package:purosis/widget/app_text.dart';

import '../../../../widget/card_widget.dart';


class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Row(children: [
          Expanded(child: CardWidget(icon: AppImage.cartIcon, count: '6', bottomText: 'Total Order',)),
          SizedBox(width: 5,),
          Expanded(child: CardWidget(icon: AppImage.cartIcon, count: '6', bottomText: 'Pending',)),
        ],),
        Row(children: [
          Expanded(child: CardWidget(icon: AppImage.cartIcon, count: '6', bottomText: 'In Progress',)),
          SizedBox(width: 5,),
          Expanded(child: CardWidget(icon: AppImage.cartIcon, count: '6', bottomText: 'Completed',)),
        ],),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(child: AppSearchField()),
            SizedBox(width: 5,),
            Image.asset(AppImage.shortArrowIcon),
            SizedBox(width: 5,),
            AppText(text: "Sort By")
          ],
        ),
        Expanded(
          child: ListView.builder(itemBuilder: (context, index) {
            return Card(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  children: [
                    Expanded(child: AppText(text: "#ORD-2026-001",fontWeight: FontWeight.w700,fontSize: 16,)),
                    Container(
                      padding: EdgeInsets.only(right: 10,left: 10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color(0xFFE8F2D2)),
                      child: AppText(text: "Delivered"),)
                  ],
                ),
                SizedBox(height: 5,),
                Row(children: [
                  Image.asset(AppImage.calenderIcon),
                  SizedBox(width: 5,),
                  AppText(text: "jan 05, 2026"),
                  AppText(text: "01:48 PM")
                ],),
                SizedBox(height: 5,),
                Row(children: [
                  Image.asset(AppImage.shippingBoxIcon),
                  SizedBox(width: 5,),
                  AppText(text: "8 Products"),
                ],),
                SizedBox(height: 5,),
                Row(children: [
                  Image.asset(AppImage.truckIcon),
                  SizedBox(width: 5,),
                  AppText(text: "Blue Dart Express"),
                ],),
                SizedBox(height: 10,),
                Row(children: [
                  AppText(text: "Total Weight: "),
                  AppText(text: "73.00 Kg ",fontWeight: FontWeight.w700,),
                  AppText(text: "0.800 m",fontWeight: FontWeight.w400,)
                ],),
                SizedBox(height: 5,),
                AppButton(text: "View Details",color: Color(0xFF8EBF1F),)
              ],),
            ),);
          },),
        ),

      ],),
    ),);
  }
}
