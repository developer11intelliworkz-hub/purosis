import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purosis/feature/admin/marketing/model/detail_model.dart';
import 'package:purosis/utils/common_api.dart';
import 'package:purosis/widget/common_widget.dart';

class FilterMarketingWidget extends StatefulWidget {
  const FilterMarketingWidget({super.key, required this.typeOfCategories});

  final String typeOfCategories;

  @override
  State<FilterMarketingWidget> createState() => _FilterMarketingWidgetState();
}

class _FilterMarketingWidgetState extends State<FilterMarketingWidget> {
  List<String> leftMenu = [];
  List<int> years = List.generate(51, (index) => 2000 + index);
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  List<String> selectedCategories = [];
  List<String> selectedType = [];
  List<int> selectedYear = [];
  List<String> selectedMonth = [];
  int selectedLeftIndex = 0;
  final Map<String, dynamic>? passArguments = Get.arguments;
  Map<String, dynamic>? selectedValue = {};

  @override
  void initState() {
    leftMenu = widget.typeOfCategories == "video"
        ? ["Categories", "Year", "Month", "Type"]
        : ["Categories", "Year", "Month"];
    //create a copy of passed map
    //because we need to modify the map
    //-----------------------------
    selectedValue = {
      "categories": List<String>.from(passArguments?["categories"] ?? []),
      "years": List<int>.from(passArguments?["years"] ?? []),
      "months": List<String>.from(passArguments?["months"] ?? []),
      "type": List<String>.from(passArguments?["type"] ?? []),
    };
    //---------------------------
    selectedCategories = selectedValue?["categories"] ?? [];
    selectedYear = selectedValue?["years"] ?? [];
    selectedMonth = selectedValue?["months"] ?? [];
    selectedType = selectedValue?["type"] ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Filters",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategories.clear();
                        selectedYear.clear();
                        selectedMonth.clear();
                        selectedType.clear();
                      });
                    },
                    child: const Text(
                      "Clear All",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 140,
                    color: Colors.grey.shade100,
                    child: ListView.builder(
                      itemCount: leftMenu.length,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedLeftIndex == index;

                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedLeftIndex = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 12,
                            ),
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade100,
                            child: Text(
                              leftMenu[index],
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const VerticalDivider(width: 1),
                  Expanded(child: rightView()),
                ],
              ),
            ),

            const Divider(height: 1),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 55,
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        "Close",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                  Container(width: 1, height: 30, color: Colors.grey.shade300),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Map<String, dynamic> filterData = {};
                        if (selectedCategories.isNotEmpty ||
                            selectedYear.isNotEmpty ||
                            selectedYear.isNotEmpty ||
                            selectedType.isNotEmpty) {
                          filterData["categories"] = selectedCategories;
                          filterData["months"] = selectedMonth;
                          filterData["years"] = selectedYear;
                          filterData["type"] = selectedType;
                        }
                        Navigator.pop(context, filterData);
                      },
                      child: const Text(
                        "Apply",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rightView() {
    if (selectedLeftIndex == 0) {
      return FutureBuilder(
        future: CommonApi().getDetailApi(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.data == null) {
            return Center(child: CommonWidget.commonLoading());
          }
          List<CategoryItem> categoriesData = [];
          if (widget.typeOfCategories == "post") {
            categoriesData = asyncSnapshot.data?.postCategory ?? [];
          } else if (widget.typeOfCategories == "reel") {
            categoriesData = asyncSnapshot.data?.reelCategory ?? [];
          } else if (widget.typeOfCategories == "video") {
            categoriesData = asyncSnapshot.data?.videoCategory ?? [];
          } else if (widget.typeOfCategories == "brochures") {
            categoriesData = asyncSnapshot.data?.brochureCategory ?? [];
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: asyncSnapshot.data?.postCategory?.length ?? 0,
            itemBuilder: (context, index) {
              String? item = categoriesData[index].key;
              bool isSelected = selectedCategories.contains(item);

              return CheckboxListTile(
                value: isSelected,
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      selectedCategories.add(item ?? "");
                    } else {
                      selectedCategories.remove(item);
                    }
                  });
                },
                title: Text(categoriesData[index].value ?? ""),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              );
            },
          );
        },
      );
    } else if (selectedLeftIndex == 1) {
      return ListView.builder(
        itemCount: years.length,
        itemBuilder: (context, index) {
          int item = years[index];
          bool isSelected = selectedYear.contains(item);
          return CheckboxListTile(
            value: isSelected,
            activeColor: Colors.green,
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  selectedYear.add(item);
                } else {
                  selectedYear.remove(item);
                }
              });
            },
            title: Text(years[index].toString()),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          );
        },
      );
    } else if (selectedLeftIndex == 2) {
      return ListView.builder(
        itemCount: months.length,
        itemBuilder: (context, index) {
          String item = months[index];
          bool isSelected = selectedMonth.contains(item);
          return CheckboxListTile(
            value: isSelected,
            activeColor: Colors.green,
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  selectedMonth.add(item);
                } else {
                  selectedMonth.remove(item);
                }
              });
            },
            title: Text(months[index].toString()),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          );
        },
      );
    } else if (selectedLeftIndex == 3) {
      return FutureBuilder(
        future: CommonApi().getDetailApi(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.data == null) {
            return Center(child: CommonWidget.commonLoading());
          }
          List<CategoryItem> typeData = [];
          if (widget.typeOfCategories == "video") {
            typeData = asyncSnapshot.data?.videoType ?? [];
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: asyncSnapshot.data?.postCategory?.length ?? 0,
            itemBuilder: (context, index) {
              String? item = typeData[index].key;
              bool isSelected = selectedType.contains(item);

              return CheckboxListTile(
                value: isSelected,
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      selectedType.add(item ?? "");
                    } else {
                      selectedType.remove(item);
                    }
                  });
                },
                title: Text(typeData[index].value ?? ""),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              );
            },
          );
        },
      );
    } else {
      return Container();
    }
  }
}
