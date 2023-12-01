import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/font_size.dart';
import 'package:doafric/utils/responsive_screen.dart';
import 'package:doafric/utils/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var categoryName = "Filters";

  double _startValue = 20.0;

  double _endValue = 90.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorWhite,
        centerTitle: true,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
            color: colorBlack,
            size: 25,
          ),
          onTap: () {
            Get.offAndToNamed(Routes.dashboard);
          },
        ),
        title: TextView(
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w500,
          font_size: isMobile(context)
              ? MyFontSize().normalTextSizeMobile
              : MyFontSize().normalTextSizeTablet,
          fontColor: colorPrimary,
          text: categoryName,
          textStyle: Theme.of(context).textTheme.bodyLarge!,
          softWrap: true,
        ),
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "Choose Your Price Range",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Amazon',
                        fontWeight: FontWeight.bold,
                        color: colorPrimary),
                  ),
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    inactiveTickMarkColor: Colors.white,
                    valueIndicatorShape:
                        const PaddleSliderValueIndicatorShape(),
                    valueIndicatorColor: Colors.black,
                    valueIndicatorTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  child: RangeSlider(
                    activeColor: colorGrey,
                    inactiveColor: colorPrimary,
                    min: 0.0,
                    max: 100.0,
                    divisions: 10,
                    labels: RangeLabels(
                      _startValue.round().toString(),
                      _endValue.round().toString(),
                    ),
                    values: RangeValues(_startValue, _endValue),
                    onChanged: (values) {
                      setState(() {
                        _startValue = values.start;
                        _endValue = values.end;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "Choose Your Category",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Amazon',
                        fontWeight: FontWeight.bold,
                        color: colorPrimary),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: Get.width,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color.fromARGB(255, 0, 4, 8)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "Choose Your Brand",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Amazon',
                        fontWeight: FontWeight.bold,
                        color: colorPrimary),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: Get.width,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color.fromARGB(255, 0, 4, 8)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 35,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                                (Color(0xFF113f60)),
                                (Color(0xFF113f60))
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.circular(1),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Colors.white,
                            )
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Reset Filter",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Amazon',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 35,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                                (Color(0xFF113f60)),
                                (Color(0xFF113f60))
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.circular(1),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Colors.white,
                            )
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Amazon',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
