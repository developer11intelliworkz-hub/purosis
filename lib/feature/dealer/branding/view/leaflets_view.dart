import 'package:flutter/material.dart';

import '../../../../widget/app_search_field.dart';
import '../../../../widget/app_text.dart';

class LeafleatsView extends StatelessWidget {
  const LeafleatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: AppSearchField()),
              IconButton(onPressed: () {

              }, icon: Icon(Icons.tune))
            ],
          ),
          Expanded(
            child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.6,crossAxisSpacing: 5,mainAxisSpacing: 5), itemBuilder: (context, index) {
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
                            AppText(text: "Water Purifier",fontWeight: FontWeight.w700,),
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
        ],
      ),
    ),);
  }
}