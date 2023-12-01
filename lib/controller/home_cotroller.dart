import 'package:get/get.dart';

class HomeController extends GetxController {
  var onPageChanged = 0.obs;


  void pageChanged(int index) {
    onPageChanged.value = index;
  }
}
