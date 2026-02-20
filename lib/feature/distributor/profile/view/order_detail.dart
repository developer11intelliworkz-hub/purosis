import 'package:flutter/material.dart';

import '../../../../consts/app_image.dart';
import '../../../../widget/app_text.dart';


class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Card(child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(text: "#ORD-2026-001",fontWeight: FontWeight.w700,fontSize: 16,),
              SizedBox(height: 10,),
              Row(children: [
                Image.asset(AppImage.calenderIcon),
                SizedBox(width: 5,),
                AppText(text: "jan 05, 2026 01:48 PM")
              ],),
              SizedBox(height: 10,),
              Container(
                width: double.maxFinite,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Color(0xFFE8F2D2),borderRadius: BorderRadius.circular(20)),
                child: AppText(text: "Delivered",color: Color(0xFF8EBF1F),),),
            ],
          ),
        ),),
        Card(
          elevation: 0,
          child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                      flex: 4,child: AppText(text: "RO Water Purifier - Premium",fontSize: 12,fontWeight: FontWeight.w700,)),
                  Expanded(child: AppText(text: "73.00 kg",fontSize: 12,fontWeight: FontWeight.w700,))
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                      child: AppText(text: "Color: White",fontSize: 10,)),
                  Expanded(
                      child: AppText(text: "0.800",fontSize: 10,)),
                ],
              ),
              SizedBox(height: 5,),
              AppText(text: "Qty. 12 units | Boxes: 3",color: Colors.grey,fontSize: 10,),
              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                      flex: 4,child: AppText(text: "RO Water Purifier - Premium",fontSize: 12,fontWeight: FontWeight.w700,)),
                  Expanded(child: AppText(text: "73.00 kg",fontSize: 12,fontWeight: FontWeight.w700,))
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: AppText(text: "Color: White",fontSize: 10,)),
                  Expanded(
                      child: AppText(text: "0.800",fontSize: 10,)),
                ],
              ),
              SizedBox(height: 5,),
              AppText(text: "Qty. 12 units | Boxes: 3",color: Colors.grey,fontSize: 10,),
              SizedBox(height: 10,),
            ],),
        ),),
        Card(
          elevation: 0,
          child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              children: [
                Expanded(
                    flex: 4,child: AppText(text: "Total",fontSize: 12,fontWeight: FontWeight.w700,)),
                Expanded(child: AppText(text: "73.00 kg",fontSize: 12,fontWeight: FontWeight.w700,))
              ],
            ),
            Row(children: [
              Expanded(
                flex: 4,
                  child: SizedBox()),
              Expanded(child: AppText(text: "0.800 m"))
            ],)
          ],),
        ),)
      ],),
    ),);
  }
}
