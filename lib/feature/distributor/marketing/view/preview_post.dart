import 'package:flutter/material.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/widget/app_button.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/app_text_field.dart';

class PreviewPost extends StatelessWidget {
  const PreviewPost({super.key});

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
                  child: Image.asset(AppImage.purosisLogo),),
                SizedBox(width: 3,),
                Expanded(
                  child: Column(
                    children: [
                      AppText(text: "Sector 45, Faridabad, Haryana 121010."),
                      SizedBox(height: 3,),
                      Row(
                        children: [
                          Icon(Icons.mail_outline_outlined),
                          AppTextField(labelText: "ropurifier@gmail.com"),
                        ],
                      ),
                      SizedBox(height: 3,),
                      Row(
                        children: [
                          Expanded(child: Row(
                            children: [
                              Icon(Icons.call),
                              AppTextField(labelText: "0171 251 8023"),
                            ],
                          )),
                          SizedBox(width: 3,),
                          Expanded(child: Row(
                            children: [
                              Image.asset(AppImage.whatsAppIcon),
                              AppTextField(labelText: "+91 12345 67890"),
                            ],
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(children: [
              Expanded(child: AppButton(text: "Save", isLoading: false, onPressed: () {},color: Colors.grey,)),
              SizedBox(width: 5,),
              Expanded(child: AppButton(text: "Download", isLoading: false, onPressed: () {},color: Color(0xFF8EBF1F),)),
            ],)
          ],
        ),
      ),
    );
  }
}
