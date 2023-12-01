import 'package:doafric/controller/dashoard_controller1.dart';
import 'package:doafric/drawer/navigation_drawer.dart';
import 'package:doafric/page_routes/routes.dart';
import 'package:doafric/utils/colors.dart';
import 'package:doafric/utils/custom_search_delegate.dart';
import 'package:doafric/utils/image_file.dart';
import 'package:doafric/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  final _dashboardController1 = Get.put(DashoardController1());

   Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Obx(
      () => Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: colorWhite,
          leading: IconButton(
            icon: const ImageIcon(
              AssetImage(ImageFile.navig),
              color: colorBlack,
          ),
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                color: colorGrey,
                size: 25,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                  query: ''
                );
              },
            ),
            IconButton(
              icon: const ImageIcon(
                AssetImage(ImageFile.heart),
                color: colorGrey,
                size: 25,
              ),
              onPressed: () {
                Get.to(const WishList());
              },
            ),
            IconButton(
              color: colorBlack,
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: colorGrey,
                size: 25,
              ),
              onPressed: () {
                Get.toNamed(Routes.notification);
              },
            ),
          ],
        ),
        body: _dashboardController1.wigetOptions
            .elementAt(_dashboardController1.tabIndex.value),
       drawer:   CustomDrawer(),
         
        bottomNavigationBar: BottomNavigationBar(
          
            type: BottomNavigationBarType.fixed,
              currentIndex: _dashboardController1.tabIndex.value,
              selectedItemColor: colorPrimary,
              unselectedItemColor: colorlightGrey,
              onTap: (index) {
                _dashboardController1.tabIndex.value = index;
              },
              items: [
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage(
                        _dashboardController1.imagesList[0],
                      ),
                    ),
                    label: _dashboardController1.app_title[0]),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage(
                        _dashboardController1.imagesList[1],
                      ),
                    ),
                    label: _dashboardController1.app_title[1]),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage(
                        _dashboardController1.imagesList[3],
                      ),
                    ),
                    label: _dashboardController1.app_title[3]),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage(
                        _dashboardController1.imagesList[6],
                      ),
                    ),
                    label: _dashboardController1.app_title[6]),
              ]),
        ),
      
    );
  }
}
