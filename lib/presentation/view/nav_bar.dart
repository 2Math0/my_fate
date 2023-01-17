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

const double bottomNavItemsScale = AppSize.s20;

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
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppIcons.home,
                  color: _viewModel.navColors(0)),
              label: "Home"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.addTask,
                color: _viewModel.navColors(1),
              ),
              label: "Add"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppIcons.person,
                  color: _viewModel.navColors(2)),
              label: "Profile"),
        ],
        currentIndex: _viewModel.getCurrentIndex,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: AppColors.primaryBlue,
        onTap: _viewModel.onPageChanged,
      ),
    );
  }
}
