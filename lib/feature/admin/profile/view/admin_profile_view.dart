import 'package:flutter/material.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../widget/app_button.dart';
import '../../../../widget/app_text.dart';

class AdminProfileView extends StatelessWidget {
  const AdminProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonWidget.AppAppBar(title: "Profile"),body: Column(children: [
      Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            Container(
              width: 100,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xFFDEF1FF)),
              child: AppText(text: "s",color: Colors.blue,fontWeight: FontWeight.w600,fontSize: 24,),),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: "Person Name",fontWeight: FontWeight.w600,fontSize: 18,),
                SizedBox(height: 3,),
                Container(
                    padding: EdgeInsets.only(left: 10,right: 10,top: 3,bottom: 3),
                    decoration: BoxDecoration(color: Color(0xFFEFF2D2)),
                    child: AppText(text: "Admin",color: Color(0xFF8EBF1F),fontWeight: FontWeight.w700,)),
                SizedBox(height: 3,),
                AppText(text: "+91 1234567890")
              ],),
          ],),
        ),),
      SizedBox(height: 10,),
      Card(
        margin: EdgeInsets.all(10),
        child:Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              AppText(text: "My Profile"),
              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 10,),
              AppText(text: "User Management"),
              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 10,),
              AppText(text: "Notifications"),
              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 10,),
              AppText(text: "Help & Support"),
              SizedBox(height: 10,),
            ],),
        ),),
      Spacer(),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppButton(text: "Logout",color: Color(0xFF8EBF1F),),
      ),
      SizedBox(height: 10,)
    ],),);
  }
}
