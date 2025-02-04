import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_irfan_ghozali/screen/auth/register_page.dart';

import '../../configs/theme.dart';
import '../../provider/auth_provider.dart';
import '../../widgets/button_fill_widget.dart';
import '../../widgets/textformfield_widget.dart';
import '../../widgets/textformpass_widget.dart';

class LoginPageScreen extends StatelessWidget {
  LoginPageScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBaseWhite,
      body: FadedScaleAnimation(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            topWidget(),
            spaceHeight32,
            formWidget(context),
            spaceHeight48,
          ],
        ),
      ),
    );
  }

  Widget topWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          spaceHeight50,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/ic_logo_sims.png',
                  width: 48, height: 48),
              spaceWidth12,
              const Text(
                'SIMS PPOB',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  height: 1,
                  fontSize: 28,
                ),
              )
            ],
          ),
          spaceHeight32,
          const Text(
            'Masuk atau Buat Akun',
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          const Text(
            'Untuk Memulai',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              height: 1,
              fontSize: 28,
            ),
          )
        ],
      ),
    );
  }

  Widget formWidget(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(children: [
        TextFormFieldWidget(
          controller: emailController,
          inputType: TextInputType.emailAddress,
          maxLines: 1,
          textHint: 'Masukkan email anda',
          iconData: Icons.alternate_email,
        ),
        spaceHeight8,
        TextFormPassWidget(
          controller: passwordController,
          textHint: 'Masukkan password anda',
        ),
        spaceHeight24,
        ButtonFillWidget(
          actionText: 'Masuk',
          onTap: () {
            // init Login
            auth.initLogin(
                context, emailController.text, passwordController.text);
          },
        ),
        spaceHeight5,
        Center(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 200),
                  reverseDuration: const Duration(milliseconds: 200),
                  child: const RegisterPageScreen(),
                ),
              );
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: RichText(
                text: const TextSpan(
                  text: 'Belum punya akun? Registrasi',
                  style: TextStyle(
                    color: baseTextBlackLight,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: ' disini',
                        style: TextStyle(
                          color: baseTextApp,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
