import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_fate/presentation/resources/assets_manager.dart';
import 'package:my_fate/presentation/view_model/nav_bar_view_model.dart';

import '../resources/colors_manager.dart';
import '../resources/values_manager.dart';

class NavBarScreen extends StatefulWidget {
  ///
  ///This is the page where the app start after splash and login
  ///moving around with bottom navigation this page doesn't change
  ///

  final int? intIndex;

  const NavBarScreen({Key? key, this.intIndex = 0}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

const double bottomNavItemsScale = AppSize.s28;
const BorderRadius bottomNavBarBorderRadius =
    BorderRadius.all(Radius.circular(AppCircularRadius.cr32));

class _NavBarScreenState extends State<NavBarScreen> {
  final NavBarViewModel _viewModel = NavBarViewModel();

  _bind() {
    _viewModel.start();
    if (widget.intIndex != null) {
      _viewModel.onPageChanged(widget.intIndex!);
    }
  }

  // int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _viewModel.outputNavViewObject,
        builder: (context, snapshot) {
          return getMarketUI(snapshot.data);
        });
  }

  Widget getMarketUI(fragment) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: fragment,
      ),
      floatingActionButton: Container(
          width: AppSize.s60,
          height: AppSize.s60,
          decoration: BoxDecoration(
              color:
                  _viewModel.navColors(i: 1, secondaryColor: AppColors.kBlack),
              borderRadius: const BorderRadius.all(
                  Radius.circular(AppCircularRadius.cr20))),
          child: IconButton(
            onPressed: () => _viewModel.onPageChanged(1),
            icon: SvgPicture.asset(AppIcons.plus,
                color: AppColors.kWhite, width: bottomNavItemsScale - 3),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            bottom: AppPadding.p8, left: AppPadding.p8, right: AppPadding.p8),
        child: Container(
          height: AppSize.s60,
          decoration: const BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: bottomNavBarBorderRadius,
              boxShadow: [
                BoxShadow(
                    color: AppColors.inactiveGrey,
                    spreadRadius: 1,
                    blurRadius: 50),
              ]),
          child: ClipRRect(
            borderRadius: bottomNavBarBorderRadius,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () => _viewModel.onPageChanged(0),
                    tooltip: "Home",
                    splashRadius: AppSize.s10,
                    icon: SvgPicture.asset(AppIcons.home,
                        width: bottomNavItemsScale,
                        color: _viewModel.navColors(i: 0))),

                // for centering the items in row
                const SizedBox(width: bottomNavItemsScale),
                const SizedBox(width: bottomNavItemsScale),

                IconButton(
                  tooltip: "Profile",
                  splashRadius: AppSize.s10,
                  onPressed: () => _viewModel.onPageChanged(2),
                  icon: SvgPicture.asset(AppIcons.person,
                      width: bottomNavItemsScale,
                      color: _viewModel.navColors(i: 2)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
