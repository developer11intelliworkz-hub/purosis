import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../widget/app_search_field.dart';
import '../../../../widget/app_text.dart';

class ReelListView extends StatelessWidget {
  const ReelListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: AppSearchField()),
            IconButton(onPressed: () {}, icon: Icon(Icons.tune)),
          ],
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              return Card(
                child: SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: SizedBox(width: 150)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: "Christmas Post",
                              fontWeight: FontWeight.w700,
                            ),
                            AppText(
                              text: "25 Dec 2025",
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
