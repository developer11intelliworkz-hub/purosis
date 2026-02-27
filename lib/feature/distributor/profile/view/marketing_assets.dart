import 'package:flutter/material.dart';
import 'package:purosis/widget/app_text.dart';

class MarketingAssets extends StatelessWidget {
  const MarketingAssets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    children: [
                      AppText(
                        text: "Post",
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                      Spacer(),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFDEF1FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.arrow_right_alt, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    children: [
                      AppText(
                        text: "Brochure",
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                      Spacer(),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFDEF1FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.arrow_right_alt, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    children: [
                      AppText(
                        text: "Video",
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                      Spacer(),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFDEF1FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.arrow_right_alt, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    children: [
                      AppText(
                        text: "Reel",
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                      Spacer(),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFDEF1FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.arrow_right_alt, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    children: [
                      AppText(
                        text: "Leaflet",
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                      Spacer(),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFDEF1FF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.arrow_right_alt, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
