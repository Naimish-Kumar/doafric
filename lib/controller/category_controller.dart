import 'package:get/get.dart';

class CategoryController extends GetxController {
  var onPageChanged = 1.obs;


  void pageChanged(int index) {
    onPageChanged.value = index;
  }
}
