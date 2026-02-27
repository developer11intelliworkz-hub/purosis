import 'package:flutter/material.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/widget/app_text.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 300),
                AppText(
                  text: "PuroAqua RO Cabinet Water Purifiers",
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
                AppText(
                  text: "Expereince the purity in every drop.",
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 60,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                        ),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(width: 5),
                    itemCount: 8,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: "Quantity:"),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          width: 170,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                    color: Color(0xFFCAE6FB),
                                  ),
                                  child: Icon(Icons.remove),
                                ),
                              ),
                              Expanded(
                                child: AppText(
                                  text: "3",
                                  align: TextAlign.center,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                    color: Color(0xFFCAE6FB),
                                  ),
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 3),
                        AppText(text: "20 units in 1 Box"),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImage.foodGradeIcon,
                                height: 60,
                                width: 60,
                              ),
                              Expanded(
                                child: AppText(
                                  text: "100% Food Grade ABS Plastic",
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                AppImage.pureIcon,
                                height: 60,
                                width: 60,
                              ),
                              Expanded(
                                child: AppText(
                                  text:
                                      "Purication Capacity 15 to 18 Ltr. /Hr.",
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                AppImage.waterBucketIcon,
                                height: 60,
                                width: 60,
                              ),
                              Expanded(
                                child: AppText(
                                  text: "Storage Capacity 9 Ltr.",
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                AppImage.filterCabIcon,
                                height: 60,
                                width: 60,
                              ),
                              Expanded(
                                child: AppText(
                                  text: "Wall Mount & Table Top",
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(flex: 1, child: AppText(text: "Net Weight :")),
                    Expanded(flex: 3, child: AppText(text: "7.5 KG(Approx)")),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(flex: 1, child: AppText(text: "Product Type :")),
                    Expanded(
                      flex: 3,
                      child: AppText(text: "Electric Home Appliance"),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(flex: 1, child: AppText(text: "Gross Weight :")),
                    Expanded(
                      flex: 3,
                      child: AppText(text: "10.50 KG(Approx.)"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.favorite_border),
                Spacer(),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF8EBF1F)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: AppText(text: "Buy Now", color: Color(0xFF8EBF1F)),
                ),
                SizedBox(width: 20),
                Container(
                  height: 40,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xFF8EBF1F),
                  ),
                  child: Row(
                    children: [
                      Image.asset(AppImage.cart2Icon, color: Colors.white),
                      SizedBox(width: 10),
                      AppText(text: "Add to Cart", color: Colors.white),
                    ],
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
