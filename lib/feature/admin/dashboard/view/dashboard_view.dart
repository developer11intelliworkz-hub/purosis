import 'package:flutter/material.dart';
import 'package:purosis/widget/app_text.dart';

import '../../../../consts/app_image.dart';
import '../../../../widget/card_widget.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body: SingleChildScrollView(
      padding: EdgeInsets.all(8),
      child: Column(children: [
        Row(children: [
          Expanded(child: CardWidget(icon: AppImage.cartIcon, count: '3', bottomText: "Purchased Orders",)),
          SizedBox(width: 10,),
          Expanded(child: CardWidget(icon: AppImage.cartIcon, count: '5', bottomText: "Promo Items Orders",)),
        ],),
        Row(children: [
          Expanded(child: CardWidget(icon: AppImage.checkIcon, count: '3', bottomText: "Purchased Orders",)),
          SizedBox(width: 10,),
          Expanded(child: CardWidget(icon: AppImage.manIcon, count: '5', bottomText: "Promo Items Orders",)),
        ],),
        Row(children: [
          Expanded(child: CardWidget(icon: AppImage.productIcon, count: '3', bottomText: "Purchased Orders",)),
          SizedBox(width: 10,),
          Expanded(child: CardWidget(icon: AppImage.imageIcon, count: '5', bottomText: "Promo Items Orders",)),
        ],),
        Card(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: Row(children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFDEF1FF)
              ),
              child: Image.asset(AppImage.cartIcon),),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: "Manage Orders",fontWeight: FontWeight.w700,fontSize: 16,),
                SizedBox(height: 5,),
                AppText(text: "View & approve orders",color: Colors.grey,)
              ],
            ),
            Spacer(),
            Icon(Icons.arrow_right_alt,color: Color(0xFF8EBF1F),)
          ],),
        ),),
        Card(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: Row(children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFDEF1FF)
              ),
              child: Image.asset(AppImage.productIcon),),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: "Products",fontWeight: FontWeight.w700,fontSize: 16,),
                SizedBox(height: 5,),
                AppText(text: "Add & edit products",color: Colors.grey,)
              ],
            ),
            Spacer(),
            Icon(Icons.arrow_right_alt,color: Color(0xFF8EBF1F),)
          ],),
        ),),
        Card(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: Row(children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFDEF1FF)
              ),
              child: Image.asset(AppImage.imageIcon),),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: "Marketing",fontWeight: FontWeight.w700,fontSize: 16,),
                SizedBox(height: 5,),
                AppText(text: "Upload Content",color: Colors.grey,)
              ],
            ),
            Spacer(),
            Icon(Icons.arrow_right_alt,color: Color(0xFF8EBF1F),)
          ],),
        ),),
        Card(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
          child: Row(children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFDEF1FF)
              ),
              child: Image.asset(AppImage.giftIcon),),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: "Promotional",fontWeight: FontWeight.w700,fontSize: 16,),
                SizedBox(height: 5,),
                AppText(text: "Stock Management",color: Colors.grey,)
              ],
            ),
            Spacer(),
            Icon(Icons.arrow_right_alt,color: Color(0xFF8EBF1F),)
          ],),
        ),),
        SizedBox(height: 10,),
        Row(
          children: [
            AppText(text: "Pending Approval",fontWeight: FontWeight.w700,fontSize: 16,),
            Spacer(),
            AppText(text: "View All",color: Color(0xFF8EBF1F),),
            SizedBox(width: 3,),
            Icon(Icons.arrow_forward_rounded,color: Color(0xFF8EBF1F),)
          ],
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(itemBuilder: (context, index) {
            return Card(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  children: [
                    AppText(text: "#ORD-2026-001",fontWeight: FontWeight.w700,fontSize: 16,),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                      decoration: BoxDecoration(color: Color(0xFFF2EBD2),borderRadius: BorderRadius.circular(15)),
                      child: AppText(text: "Pending Approval"),)
                  ],
                ),
                Row(
                  children: [
                    Image.asset(AppImage.manIcon),
                    SizedBox(width: 5,),
                    AppText(text: "Distributor : Mumbai Water Solutions"),
                  ],
                ),
                SizedBox(height: 3,),
                Row(
                  children: [
                    Image.asset(AppImage.calenderIcon,),
                    SizedBox(width: 5,),
                    AppText(text: "Jan 05, 2026 • 01:48 PM"),
                  ],
                ),
                  SizedBox(height: 3,),
                Row(
                  children: [
                    Image.asset(AppImage.shippingBoxIcon,),
                    SizedBox(width: 5,),
                    AppText(text: "8 Products"),
                  ],
                ),
                  SizedBox(height: 3,),
                Row(
                  children: [
                    Image.asset(AppImage.truckIcon,),
                    SizedBox(width: 5,),
                    AppText(text: "Blue Dart Express"),
                  ],
                ),
                  SizedBox(height: 5,),
                Row(children: [
                  AppText(text: "Total Weight: "),
                  AppText(text: "73.00 kg",fontWeight: FontWeight.w700,fontSize: 16,),
                  AppText(text: "0.800 m³")
                ],),
                  SizedBox(height: 10,),
               Row(children: [
                 Expanded(
                   child: Container(
                     height: 40,
                     alignment: Alignment.center,
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Color(0xFF8EBF1F))),
                     child: AppText(text: "View Details",color: Color(0xFF8EBF1F),),),
                 ),
                 SizedBox(width: 3,),
                 Expanded(
                   child: Container(
                     height: 40,
                     alignment: Alignment.center,
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color(0xFF8EBF1F)),
                     child: AppText(text: "Approve",color: Colors.white,),),
                 ),
                 SizedBox(width: 3,),
                 Expanded(
                   child: Container(
                     height: 40,
                     alignment: Alignment.center,
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Color(0xFFBF1F1F))),
                     child: AppText(text: "Decline",color: Color(0xFFBF1F1F),),),
                 ),
               ],)
              ],),
            ),);
          },itemCount: 5,),
        )
      ],),
    ),);
  }
}
