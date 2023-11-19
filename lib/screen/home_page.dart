import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sims_ppob_irfan_ghozali/configs/constants.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:sims_ppob_irfan_ghozali/screen/pagemenus/account_page.dart';
import 'package:sims_ppob_irfan_ghozali/screen/pagemenus/dashboard_page.dart';
import 'package:sims_ppob_irfan_ghozali/screen/pagemenus/topup_page.dart';
import 'package:sims_ppob_irfan_ghozali/screen/pagemenus/transaction_page.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors

    return Scaffold(
      backgroundColor: backgroundBaseWhite,
      extendBody: true,
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          backgroundColor: backgroundBaseApp,
          content: Text('Tap back again to leave'),
        ),
        child: _buildCurrentIndexNavBar(),
      ),
      bottomNavigationBar: Container(
          height: 72,
          decoration: const BoxDecoration(
            color: backgroundBaseWhite,
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                color: Color(0x33000000),
                offset: Offset(0, 0),
                spreadRadius: 3,
              )
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: _buildFloatingBar()),
    );
  }

  Widget _buildCurrentIndexNavBar() {
    if (_currentIndex == 0) {
      return const DashboardPageScreen();
    } else if (_currentIndex == 1) {
      return TopupPageScreen(
        onBackPressed: () {
          setState(() {
            _currentIndex = 0;
          });
        },
      );
    } else if (_currentIndex == 2) {
      return TransactionPageScreen(
        onBackPressed: () {
          setState(() {
            _currentIndex = 0;
          });
        },
      );
    } else {
      return AccountPageScreen(
        onBackPressed: () {
          setState(() {
            _currentIndex = 0;
          });
        },
      );
    }
  }

  Widget _buildFloatingBar() {
    return CustomNavigationBar(
      iconSize: 24.0,
      selectedColor: backgroundBaseApp,
      strokeColor: const Color(0x30ffffff),
      unSelectedColor: backgroundBaseDark,
      backgroundColor: backgroundBaseWhite,
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        CustomNavigationBarItem(
          selectedIcon: Image.asset(
            'assets/icons/ic_nav_menu_dashboard.png',
            color: baseTextBlackLight,
          ),
          icon: Image.asset(
            'assets/icons/ic_nav_menu_dashboard.png',
            color: backgroundBaseDark,
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              Constants.navigation.navigationHome,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: (_currentIndex == 0)
                      ? baseTextBlackLight
                      : backgroundBaseDark),
            ),
          ),
        ),
        CustomNavigationBarItem(
          selectedIcon: Image.asset(
            'assets/icons/ic_nav_menu_history.png',
            color: baseTextBlackLight,
          ),
          icon: Image.asset(
            'assets/icons/ic_nav_menu_history.png',
            color: backgroundBaseDark,
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              Constants.navigation.navigationTopup,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: (_currentIndex == 1)
                      ? baseTextBlackLight
                      : backgroundBaseDark),
            ),
          ),
        ),
        CustomNavigationBarItem(
          selectedIcon: Image.asset(
            'assets/icons/ic_nav_menu_progress.png',
            color: baseTextBlackLight,
          ),
          icon: Image.asset(
            'assets/icons/ic_nav_menu_progress.png',
            color: backgroundBaseDark,
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              Constants.navigation.navigationTrx,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: (_currentIndex == 2)
                      ? baseTextBlackLight
                      : backgroundBaseDark),
            ),
          ),
        ),
        CustomNavigationBarItem(
          selectedIcon: Image.asset(
            'assets/icons/ic_nav_menu_profile.png',
            color: baseTextBlackLight,
          ),
          icon: Image.asset(
            'assets/icons/ic_nav_menu_profile.png',
            color: backgroundBaseDark,
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              Constants.navigation.navigationAccount,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: (_currentIndex == 3)
                      ? baseTextBlackLight
                      : backgroundBaseDark),
            ),
          ),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        if (mounted) {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      isFloating: false,
      borderRadius: const Radius.circular(12),
    );
  }
}
