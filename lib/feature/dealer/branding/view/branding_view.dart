import 'package:flutter/material.dart';

import '../../../../widget/app_text.dart';

class BrandingView extends StatelessWidget {
  const BrandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            AppText(text: "Brochures",fontWeight: FontWeight.w600,),
            Spacer(),
            AppText(text: "View All")
          ],),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(5),
                child: SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: SizedBox(width: 150,)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            AppText(text: "PuroAqua RO Cabi",fontWeight: FontWeight.w700,),
                            AppText(text: "Expereince the purity in every drop.",fontWeight: FontWeight.w700,color: Colors.grey,),
                            SizedBox(height: 5,),
                            Container(
                              height: 40,
                              padding: EdgeInsets.only(right: 20,left: 20,top: 5,bottom: 5),
                              // alignment: Alignment.center,
                              decoration: BoxDecoration(color: Color(0xFF8EBF1F),borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppText(text: "Download",fontWeight: FontWeight.w600,color: Colors.white,),
                                  SizedBox(width: 5,),
                                  Icon(Icons.arrow_downward,color: Colors.white,)
                                ],
                              ),)
                          ],),
                      ),
      
                    ],),
                ),
              );
            },),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            AppText(text: "Leaflets",fontWeight: FontWeight.w600,),
            Spacer(),
            AppText(text: "View All")
          ],),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Card(
                child: SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: SizedBox(width: 150,)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            AppText(text: "Christmas Post",fontWeight: FontWeight.w700,),
                            AppText(text: "25 Dec 2025",fontWeight: FontWeight.w700,color: Colors.grey,),
                          ],),
                      ),
      
                    ],),
                ),
              );
            },),
        ),
      ],),
    );
  }
}
