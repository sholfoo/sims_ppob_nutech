import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';
import 'package:sims_ppob_irfan_ghozali/screen/auth/login_page.dart';
import 'package:sims_ppob_irfan_ghozali/shared/shared_prefs.dart';

class WidgetDialogExpiredAuth extends StatelessWidget {
  final String? message;
  const WidgetDialogExpiredAuth({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$message, To continue you need to re-login first",
                textScaleFactor: 1.0,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              spaceHeight16,
              GestureDetector(
                onTap: () {
                  SharedPrefManager().clearSF();
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 200),
                      reverseDuration: const Duration(milliseconds: 200),
                      child: const LoginPageScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                      child: Text(
                    "Re-Login",
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )),
                ),
              ),
            ]));
  }
}
