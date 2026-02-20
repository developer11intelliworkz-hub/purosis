import 'package:flutter/material.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/app_text_field.dart';

class CustomizePost extends StatelessWidget {
  const CustomizePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(height: 400),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  CircleAvatar(backgroundColor: Color(0xFF0067B1),child: Icon(Icons.image_outlined,color: Colors.white,),),
                  AppText(text: "Logo")
                ],),),
                SizedBox(width: 3,),
                Expanded(
                  child: Column(
                    children: [
                      AppTextField(labelText: "Address"),
                      SizedBox(height: 3,),
                      AppTextField(labelText: "Mail Id"),
                      SizedBox(height: 3,),
                      Row(
                        children: [
                          Expanded(child: AppTextField(labelText: "Call")),
                          SizedBox(width: 3,),
                          Expanded(child: AppTextField(labelText: "Whats app")),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(children: [
              Expanded(child: AppButton(text: "Cancel", isLoading: false, onPressed: () {},color: Colors.grey,)),
              SizedBox(width: 5,),
              Expanded(child: AppButton(text: "Preview", isLoading: false, onPressed: () {},color: Color(0xFF8EBF1F),)),
            ],)
          ],
        ),
      ),
    );
  }
}
