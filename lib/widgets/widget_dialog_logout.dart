import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';
import 'package:sims_ppob_irfan_ghozali/screen/auth/login_page.dart';
import 'package:sims_ppob_irfan_ghozali/shared/shared_prefs.dart';
import 'package:sims_ppob_irfan_ghozali/utils/util.dart';

class WidgetDialogLogout extends StatelessWidget {
  const WidgetDialogLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Are you sure you want to sign out?",
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              spaceHeight16,
              GestureDetector(
                onTap: () {
                  Utility.loadingDialog(context, false, baseTextApp);
                  Timer(
                      const Duration(seconds: 3),
                      () => {
                            Navigator.pop(context),
                            SharedPrefManager().clearSF(),
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                duration: const Duration(milliseconds: 200),
                                reverseDuration:
                                    const Duration(milliseconds: 200),
                                child: const LoginPageScreen(),
                              ),
                              (r) => false,
                            ),
                          });
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: backgroundBaseApp,
                    borderRadius: BorderRadius.circular(paddingDefault),
                  ),
                  child: const Center(
                      child: Text(
                    "Logout",
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  )),
                ),
              ),
            ]));
  }
}
