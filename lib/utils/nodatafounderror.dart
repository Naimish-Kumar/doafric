import 'package:doafric/utils/image_file.dart';
import 'package:doafric/utils/style_file.dart';
import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class NoDataFoundErrorScreens extends StatelessWidget {
  double? height;
  NoDataFoundErrorScreens({ this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height ?? 75.h,
        width: 100.w,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No Data Found",
                style: Style_File.title
                    .copyWith(color: Colors.grey.shade600, fontSize: 18.sp),
              ),
              SizedBox(
                height: .1.h,
              ),
              Image.asset(
                ImageFile.emptycart,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
