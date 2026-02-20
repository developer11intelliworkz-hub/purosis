import 'package:flutter/material.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/widget/app_text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body:true ?ListView.builder(itemBuilder: (context, index) {
      return Card(child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: "Order #7789 Dispatched",fontWeight: FontWeight.w700,fontSize:16),
                  SizedBox(height: 5,),
                  AppText(text: "Your order to Krishna Traders is on the way.")
                ],
              ),
            ),
            AppText(text: "Today, 5:23 PM",fontWeight: FontWeight.w400,)
          ],
        ),
      ));
    },itemCount: 10,): emptyWidget(),);
  }

  Widget emptyWidget(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xFFDEF1FF)),
            child: Image.asset(AppImage.notificationIcon,color: Colors.blue,),),
          SizedBox(height: 20,),
          AppText(text: "No notifications yet",fontWeight: FontWeight.w700,fontSize: 16,),
          AppText(text: "We'll notify you when there's something new",fontWeight: FontWeight.w400,)
        ],),
    );
  }
}
