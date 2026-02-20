import 'package:flutter/material.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_drop_down.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/app_text_field.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body: SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Card(
          color: Colors.white,
          child: SizedBox(
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            child: Column(children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xFFDEF1FF)),
                child: Image.asset(AppImage.callIcon),),
              AppText(text: "Call Us",fontWeight: FontWeight.w700,),
              AppText(text: "+91 1234567890"),
              AppText(text: "Mon-Sat, 9AM - 6PM",color: Colors.grey,)
            ],),
          ),
        ),),
        Card(
          color: Colors.white,
          child: SizedBox(
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
            child: Column(children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xFFDEF1FF)),
                child: Image.asset(AppImage.mailIcon),),
              AppText(text: "Email",fontWeight: FontWeight.w700,),
              AppText(text: "info@purosis.com"),
              AppText(text: "We'll respond within 24 hours",color: Colors.grey,)
            ],),
          ),
        ),),
        SizedBox(height: 10,),
        AppText(text: "Send us a Message",color: Color(0xFF0067B1),),
        SizedBox(height: 5,),
        Card(
          color: Colors.white,child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          child: Column(children: [
            AppTextField(labelText: "Subject"),
            SizedBox(height: 10,),
            AppDropDown(label: "Category", items: (p0, p1) => [],compareFn: (p0, p1) => p0==p1,),
            SizedBox(height: 10,),
            AppTextField(labelText: "Message",hintText: "Please describe your question or issue in detail",),
            SizedBox(height: 10,),
            AppButton(text: "Send",color: Color(0xFF8eBF1F),)
          ],),
        ),)
      ],),
    ),);
  }
}
