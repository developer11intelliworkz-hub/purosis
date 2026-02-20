import 'package:flutter/material.dart';

import '../../../../widget/app_text.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [
      Expanded(
        child: GridView.builder(itemBuilder: (context, index) {
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
                        Container(
                          height: 40,
                          width: double.maxFinite,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Color(0xFF8EBF1F),borderRadius: BorderRadius.circular(5)),
                          child: AppText(text: "View Details",fontWeight: FontWeight.w600,color: Colors.white,),),
                      ],),
                  ),

                ],),
            ),
          );
        },itemCount: 10, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.6,crossAxisSpacing: 5,mainAxisSpacing: 5),),
      )
    ],),floatingActionButton: FloatingActionButton(
      backgroundColor: Color(0xFF0067B1),
      onPressed: () {
      
    },child: Icon(Icons.add,color: Colors.white,),),);
  }
}
