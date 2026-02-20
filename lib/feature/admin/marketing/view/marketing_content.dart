import 'package:flutter/material.dart';
import 'package:purosis/utils/commmon_function.dart';
import 'package:purosis/widget/app_search_field.dart';
import 'package:purosis/widget/app_text.dart';
import 'package:purosis/widget/common_widget.dart';

class MarketingContent extends StatelessWidget {
  const MarketingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonWidget.AppAppBar(title: "Marketing Content"),body: SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        AppSearchField(),
        SizedBox(height: 5,),
        Row(
          children: [
            AppText(text: "Brochures",fontWeight: FontWeight.w600,fontSize: 16,),
            Spacer(),
            AppText(text: "View All",color: Color(0xFF8EBF1F),),
            Icon(Icons.arrow_forward_rounded,color: Color(0xFF8EBF1F))
          ],
        ),
        SizedBox(height: 5,),
        SizedBox(height: 300,
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
                          AppText(text: "Brochure 2025",fontWeight: FontWeight.w700,),
                          AppText(text: "15 june, 2025",fontWeight: FontWeight.w400,color: Colors.grey,),
                          Container(
                            height: 40,
                            // padding: EdgeInsets.only(right: 25,left: 25),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Color(0xFF8EBF1F),borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppText(text: "Download",fontWeight: FontWeight.w600,color: Colors.white,),
                                SizedBox(width: 5,),
                                Icon(Icons.arrow_downward,color: Colors.white,)
                              ],
                            ),),
                        ],),
                    ),

                  ],),
              ),
            );
          },),
        ),
        SizedBox(height: 5,),
        Row(
          children: [
            AppText(text: "Brochures",fontWeight: FontWeight.w600,fontSize: 16,),
            Spacer(),
            AppText(text: "View All",color: Color(0xFF8EBF1F),),
            Icon(Icons.arrow_forward_rounded,color: Color(0xFF8EBF1F))
          ],
        ),
        SizedBox(height: 5,),
        SizedBox  (height: 300,
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
                            AppText(text: "Brochure 2025",fontWeight: FontWeight.w700,),
                            AppText(text: "15 june, 2025",fontWeight: FontWeight.w400,color: Colors.grey,),
                          ],),
                      ),

                    ],),
                ),
              );
            },),
        ),
      ],),
    ),);
  }
}
