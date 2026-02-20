import 'package:flutter/material.dart';
import 'package:purosis/widget/app_search_field.dart';
import 'package:purosis/widget/common_widget.dart';

import '../../../../widget/app_text.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Expanded(child: AppSearchField()),
          IconButton(onPressed: () {

          }, icon: Icon(Icons.tune))
        ],
      ),
      Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.6,crossAxisSpacing: 5,mainAxisSpacing: 5),
          itemBuilder: (context, index) {
            return Card(
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
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 30,
                                // padding: EdgeInsets.only(right: 25,left: 25),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: Color(0xFF0067B1),borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppText(text: "Customize",fontWeight: FontWeight.w600,color: Colors.white,),
                                    SizedBox(width: 5,),
                                    Icon(Icons.arrow_forward_rounded,color: Colors.white,size: 20,)
                                  ],
                                ),),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xFF8EBF1F)),
                              child: Icon(Icons.arrow_downward,color: Colors.white,size: 20,),)
                          ],
                        )
                      ],),
                  ),

                ],),
            );
          },itemCount: 10,),
      )

    ],);
  }
}
