import 'package:flutter/material.dart';

import '../../../../consts/app_image.dart';
import '../../../../widget/app_search_field.dart';
import '../../../../widget/app_text.dart';


class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body: Column(children: [
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
                        AppText(text: "PuroAqua RO Cabi",fontWeight: FontWeight.w700,),
                        AppText(text: "Expereince the purity in every drop.",fontWeight: FontWeight.w700,color: Colors.grey,),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 40,
                                // padding: EdgeInsets.only(right: 25,left: 25),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: Color(0xFF8EBF1F),borderRadius: BorderRadius.circular(5)),
                                child: AppText(text: "View Details",fontWeight: FontWeight.w600,color: Colors.white,),),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color(0xFF0067B1)),
                              child: Image.asset(AppImage.cartIcon,color: Colors.white,scale: 1.5,),)
                          ],
                        )
                      ],),
                  ),

                ],),
            ),
          );
        },),
      )
    ],),);
  }
}
