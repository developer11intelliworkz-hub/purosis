import 'package:flutter/material.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text.dart';

class DealerAddress extends StatelessWidget {
  const DealerAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        AppButton(text: "Add New Address",color: Color(0xFF0061B1),),
        SizedBox(height: 10,),
        Expanded(
          child: ListView.separated(itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(
                  children: [
                    Expanded(child: AppText(text: "Billing Address",color: Color(0xFF0067B1),)),
                    Icon(Icons.delete_outline,color: Colors.grey,),
                    Icon(Icons.edit_outlined,color: Colors.grey)
                  ],
                ),
                  Divider(),
                  SizedBox(height: 20,),
                  AppText(text: "Silicon India Private Limited",fontWeight: FontWeight.w700,),
                  AppText(text: "Ramesh Patel"),
                  AppText(text: "GST: 24AA12345678"),
                  AppText(text: "Bandra, Mumbai"),
                  AppText(text: "Maharashtra"),
                  AppText(text: "+91 1234567890"),
                  AppText(text: "info@sillicon.com"),
                  AppText(text: "Shipping Address: Same as Billing Address")
                          ],),
              ),);
          },itemCount: 3, separatorBuilder: (BuildContext context, int index) =>SizedBox(height: 10,),),
        )
      ],),
    ),);
  }
}
