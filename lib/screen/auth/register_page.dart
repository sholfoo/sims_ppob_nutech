import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_irfan_ghozali/configs/theme.dart';
import 'package:sims_ppob_irfan_ghozali/provider/auth_provider.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/button_fill_widget.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/textformfield_widget.dart';
import 'package:sims_ppob_irfan_ghozali/widgets/textformpass_widget.dart';
import 'package:animation_wrappers/animation_wrappers.dart';

class RegisterPageScreen extends StatefulWidget {
  const RegisterPageScreen({super.key});

  @override
  State<RegisterPageScreen> createState() => _RegisterPageScreenState();
}

class _RegisterPageScreenState extends State<RegisterPageScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundBaseWhite,
      body: SingleChildScrollView(
        child: FadedScaleAnimation(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              spaceHeight50,
              topWidget(),
              spaceHeight32,
              formWidget(),
              spaceHeight48,
            ],
          ),
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
            'Lengkapi data untuk',
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          const Text(
            'Membuat Akun',
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

  Widget formWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(children: [
        registerForm(),
        spaceHeight24,
        ButtonFillWidget(
          actionText: 'Registrasi',
          onTap: () {
            // init Register
            Provider.of<AuthProvider>(context, listen: false).initRegister(
                context,
                emailController.text,
                firstNameController.text,
                lastNameController.text,
                passwordController.text,
                confirmPasswordController.text);
          },
        ),
        spaceHeight5,
        Center(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: RichText(
                text: const TextSpan(
                  text: 'Sudah punya akun? Login',
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

  Widget registerForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            controller: emailController,
            inputType: TextInputType.emailAddress,
            maxLines: 1,
            textHint: 'Masukkan email anda',
            iconData: Icons.alternate_email,
          ),
          spaceHeight8,
          TextFormFieldWidget(
            controller: firstNameController,
            inputType: TextInputType.emailAddress,
            maxLines: 1,
            textHint: 'Nama depan',
            iconData: Icons.person_outline,
          ),
          spaceHeight8,
          TextFormFieldWidget(
            controller: lastNameController,
            inputType: TextInputType.emailAddress,
            maxLines: 1,
            textHint: 'Nama belakang',
            iconData: Icons.person_outline,
          ),
          spaceHeight8,
          TextFormPassWidget(
            controller: passwordController,
            textHint: 'Buat password',
          ),
          spaceHeight8,
          TextFormPassWidget(
            controller: confirmPasswordController,
            textHint: 'Konfirmasi password',
          ),
        ],
      ),
    );
  }
}
