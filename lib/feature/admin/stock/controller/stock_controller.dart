import 'package:get/get.dart';

class StockController extends GetxController {
  int selectedList = 1;

  changeListType(int selectedIndex) {
    selectedList = selectedIndex;
    update();
  }
}
