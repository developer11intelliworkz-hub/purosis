import 'package:flutter/material.dart';
import 'package:purosis/widget/app_text.dart';

class MarketingAssetsView extends StatelessWidget {
  const MarketingAssetsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 600,
              child: GridView(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "Post",
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                          SizedBox(height: 40),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFDEF1FF),
                            ),
                            child: Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "Brochure",
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                          SizedBox(height: 40),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFDEF1FF),
                            ),
                            child: Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "Video",
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                          SizedBox(height: 40),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFDEF1FF),
                            ),
                            child: Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "Reel",
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                          SizedBox(height: 40),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFDEF1FF),
                            ),
                            child: Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "Leaflet",
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                          SizedBox(height: 40),
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFDEF1FF),
                            ),
                            child: Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
                    margin: EdgeInsets.all(5),
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
                                SizedBox(height: 5),
                                Container(
                                  height: 40,
                                  padding: EdgeInsets.only(
                                    right: 20,
                                    left: 20,
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  // alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF8EBF1F),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      AppText(
                                        text: "Download",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.arrow_downward,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
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
                  AppText(text: "Posts", fontWeight: FontWeight.w600),
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
      ),
    );
  }
}
