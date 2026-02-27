import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:purosis/consts/app_image.dart';
import 'package:purosis/widget/app_text.dart';

import '../../../../widget/card_widget.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                width: double.maxFinite,
                height: 250,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: double.maxFinite,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(
                      milliseconds: 800,
                    ),
                    viewportFraction: 1,
                  ),
                  items: [
                    Container(color: Colors.red),
                    Container(color: Colors.green),
                  ],
                ),
              ),
              Positioned(
                bottom: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    2,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: //_currentIndex == index
                      true
                          ? 10
                          : 8,
                      height: // _currentIndex == index
                      true
                          ? 10
                          : 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            true //_currentIndex == index
                            ? Colors.grey
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: CardWidget(
                  icon: AppImage.cartIcon,
                  count: '3',
                  bottomText: "Purchased Orders",
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: CardWidget(
                  icon: AppImage.giftIcon,
                  count: '5',
                  bottomText: "Promo Items Orders",
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                AppText(
                  text: "Latest Marketing Content",
                  fontWeight: FontWeight.w600,
                ),
                Spacer(),
                AppText(text: "View All"),
              ],
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
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
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                AppText(text: "Products", fontWeight: FontWeight.w600),
                Spacer(),
                AppText(text: "View All"),
              ],
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
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
                                text: "PuroAqua RO Cabi",
                                fontWeight: FontWeight.w700,
                              ),
                              AppText(
                                text: "Expereince the purity in every drop.",
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 40,
                                      // padding: EdgeInsets.only(right: 25,left: 25),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF8EBF1F),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: AppText(
                                        text: "View Details",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xFF0067B1),
                                    ),
                                    child: Image.asset(
                                      AppImage.cartIcon,
                                      color: Colors.white,
                                      scale: 1.5,
                                    ),
                                  ),
                                ],
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
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                AppText(text: "Reels", fontWeight: FontWeight.w600),
                Spacer(),
                AppText(text: "View All"),
              ],
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
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
      ),
    );
  }
}
